function openChartCategoryModal() {
    document.getElementById("myCategorymodal").style.display = "block";
}


// 대분류선택하면 대분류에 해당하는 모든 소분류 select에 넣기
function handleClickBig(key) {
    const categoryBig = key;  // key 값을 사용하거나 필요에 따라 수정합니다.

    $.ajax({
        url: '/safetyCard/selectSmallByBigCategory',
        type: 'POST',
        contentType: 'application/json',
        data: JSON.stringify({categoryBig: categoryBig}),
        success: function(response) {
            // 성공적으로 데이터를 받은 경우
            for (let i = 0; i < response.length; i++) {
                const value = response[i].categorySmall;  // 데이터의 text 값을 timeText로 설정


                const selectedBtnDiv = document.querySelector('.myselect-category-no-content');

                // 새로운 버튼 생성
                const newButton = document.createElement('button');
                newButton.textContent = value;
                newButton.classList.add('selected-category-no', 'custom-button-style');

                // 새로운 버튼을 선택된 버튼 영역에 추가
                selectedBtnDiv.appendChild(newButton);

                updateAlarmText();

                // 이벤트 리스너를 newButton에만 추가
                newButton.addEventListener('click', function (event) {

                    // 클릭된 버튼 제거
                    event.target.remove();

                    // 알람 텍스트 업데이트
                    updateAlarmText();
                });
            }
        },
        error: function() {
            // 오류 발생시 처리
            alert('Error loading data');
        }
    });
}

// 소분류 select에 넣기
function handleClick(value) {

    const selectedBtnDiv = document.querySelector('.myselect-category-no-content');

    // 새로운 버튼 생성
    const newButton = document.createElement('button');
    newButton.textContent = value;
    newButton.classList.add('selected-category-no', 'custom-button-style');

    // 새로운 버튼을 선택된 버튼 영역에 추가
    selectedBtnDiv.appendChild(newButton);

    updateAlarmText();

// 이벤트 리스너를 newButton에만 추가
    newButton.addEventListener('click', function (event) {

        // 클릭된 버튼 제거
        event.target.remove();

        // 알람 텍스트 업데이트
        updateAlarmText();
    });
}



function updateAlarmText() {
    var selectedBtnDiv = document.querySelector('.myselect-category-no-content');
    var existingButtons = selectedBtnDiv.querySelectorAll('.selected-category-no');
    var alarmSpan = document.querySelector('.select-alarm');

    if (existingButtons.length > 0) {
        alarmSpan.innerHTML = "업종을 <span class='highlighted-text-no'>차단</span>합니다.";
    } else {
        alarmSpan.textContent = ""; // 텍스트 삭제
    }
}





var myCategoryCntChart;
var myCategorySumChart;

let myChart = null; // 전역 변수로 차트 선언

function updateCategoryChart(selectedCategory) {
    let categorySmallList = [];
    let categoryCntList = [];

    $.ajax({
        url: '/chart/categoryServiceChart',
        type: 'POST',
        contentType: 'application/json',
        data: JSON.stringify({ categoryBig: selectedCategory }),
        success: function (data) {
            for (let i = 0; i < data.length; i++) {
                categorySmallList.push(data[i].categorySmall);
                categoryCntList.push(data[i].categoryCnt);
            }

            var ctx1 = document.getElementById('myCategoryCntChart').getContext('2d');

            if (myChart) {
                myChart.destroy(); // 이미 차트가 있으면 파괴
            }

            // 색상 배열 - 데이터 포인트마다 다른 색상을 제공합니다.
            let colors = [
                'rgb(255, 99, 132)',   // 진한 붉은색
                'rgb(54, 162, 235)',   // 진한 파란색
                'rgb(255, 206, 86)',   // 진한 노란색
                'rgb(75, 192, 192)',   // 진한 청록색
                'rgb(153, 102, 255)',  // 진한 보라색
                'rgb(255, 159, 64)',   // 진한 주황색
                'rgb(99, 255, 132)',   // 진한 녹색
                'rgb(255, 99, 255)',   // 진한 핑크색
                'rgb(255, 255, 0)',    // 진한 노란색
                'rgb(132, 99, 255)'    // 진한 파란색
            ];

            myChart = new Chart(ctx1, {
                type: 'pie',
                data: {
                    labels: categorySmallList,
                    datasets: [{
                        label: 'Amount Count',
                        data: categoryCntList,
                        backgroundColor: colors,
                        borderWidth: 1
                    }]
                },
                options: {
                    legend: {
                        position: 'right'  // legend를 오른쪽에 위치시킵니다.
                    }
                }
            });

        },
        error: function () {
            console.log('Error fetching categorySmall data.');
        }
    });
}


function closeChartCategoryModal() {
    document.getElementById("myCategorymodal").style.display = "none";
}

function collectButtonValues() {
    const btnDiv = document.querySelector('.myselect-category-no-content');
    const buttons = btnDiv.querySelectorAll('button.selected-category-no');
    let values = [];

    buttons.forEach(btn => {
        values.push(btn.textContent);
    });

    return values;
}

function registerCategory() {
    const values = collectButtonValues();
    const queryString = values.map(value => `categorySmall=${value}`).join('&');
    const currentQueryString = window.location.search;

    let newqueryString;
    if (currentQueryString) {
        // 이미 쿼리 스트링이 있는 경우 &와 함께 추가
        newqueryString = `${currentQueryString}&${queryString}`;
    } else {
        // 쿼리 스트링이 없는 경우 ?와 함께 추가
        newqueryString = `?${queryString}`;
    }
    console.log("newqueryString",newqueryString);

    window.location.href = `/safetyCard/safetySettingValue${newqueryString}`;
}