function openChartCategoryModal() {
    document.getElementById("myCategorymodal").style.display = "block";
}


// 대분류선택하면 대분류에 해당하는 모든 소분류 select에 넣기
function handleClickBig(key) {
    const categoryBig = key;

    $.ajax({
        url: '/safetyCard/selectSmallByBigCategory',
        type: 'POST',
        contentType: 'application/json',
        data: JSON.stringify({categoryBig: categoryBig}),
        success: function(response) {

            for (let i = 0; i < response.length; i++) {
                const value = response[i].categorySmall;


                const selectedBtnDiv = document.querySelector('.myselect-category-no-content');

                const newButton = document.createElement('button');
                newButton.textContent = value;
                newButton.classList.add('selected-category-no', 'custom-button-style');

                selectedBtnDiv.appendChild(newButton);

                updateAlarmText();

                newButton.addEventListener('click', function (event) {

                    event.target.remove();

                    updateAlarmText();
                });
            }
        },
        error: function() {

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

    newButton.addEventListener('click', function (event) {

        event.target.remove();

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
        alarmSpan.textContent = "";
    }
}


var myCategoryCntChart;
var myCategorySumChart;

let myChart = null;

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
                myChart.destroy();
            }


            let colors = [
                'rgb(255, 99, 132)',
                'rgb(54, 162, 235)',
                'rgb(255, 206, 86)',
                'rgb(75, 192, 192)',
                'rgb(153, 102, 255)',
                'rgb(255, 159, 64)',
                'rgb(99, 255, 132)',
                'rgb(255, 99, 255)',
                'rgb(255, 255, 0)',
                'rgb(132, 99, 255)'
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
                        position: 'right'
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

        newqueryString = `${currentQueryString}&${queryString}`;
    } else {

        newqueryString = `?${queryString}`;
    }
    console.log("newqueryString",newqueryString);

    window.location.href = `/safetyCard/safetySettingValue${newqueryString}`;
}