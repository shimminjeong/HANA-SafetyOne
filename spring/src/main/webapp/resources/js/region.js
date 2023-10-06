// function registerRegion() {
//     var selectedBtnDiv = document.querySelector('.myselect-region-ok-content');
//     var selectedValues = Array.from(selectedBtnDiv.querySelectorAll('[data-value]'))
//         .map(el => el.getAttribute('data-value')); // 값들을 배열로 가져옴
//
//     fetch('/safetyCard/region', {
//         method: 'POST',
//         headers: {
//             'Content-Type': 'application/json'
//         },
//         body: JSON.stringify({values: selectedValues})
//     })
//         .then(response => response.json())
//         .then(data => {
//             // 서버에서 반환한 응답을 처리
//             console.log(data);
//         })
//         .catch(error => {
//             console.error('Error:', error);
//         });
//
// }
function changeMapImage(buttonElement) {
    var newImagePath = buttonElement.getAttribute('data-img'); // 버튼의 data-img 속성 값을 가져옵니다.
    document.getElementById('mapImage').src = newImagePath; // 이미지의 src 속성을 새 경로로 변경합니다.
}

function selectRegion(button) {
    const value = button.value;
    button.style.color = 'white';
    button.style.background = '#00857F';
    const selectedBtnDiv = document.querySelector('.myselect-region-ok-content');

    // 새로운 버튼 생성
    const newButton = document.createElement('button');
    newButton.textContent = value;
    newButton.style.background = '#00857F';  // 배경색 설정
    newButton.classList.add('selected-region-ok', 'custom-button-style');

    // 새로운 버튼을 선택된 버튼 영역에 추가
    selectedBtnDiv.appendChild(newButton);

    updateAlarmText();

    // 이벤트 리스너를 newButton에만 추가
    newButton.addEventListener('click', function (event) {
        // 원래의 버튼의 색상을 빨간색으로 변경
        button.style.color = 'red';

        // 클릭된 버튼 제거
        event.target.remove();

        // 알람 텍스트 업데이트
        updateAlarmText();
    });
}

function updateAlarmText() {
    var selectedBtnDiv = document.querySelector('.myselect-region-ok-content');
    var existingButtons = selectedBtnDiv.querySelectorAll('.selected-region-ok');
    var alarmSpan = document.querySelector('.select-alarm');

    var regions = Array.from(existingButtons).map(btn => btn.textContent).join(' '); // 모든 선택된 버튼의 텍스트를 연결

    if (existingButtons.length > 0) {
        alarmSpan.innerHTML = "지역의 거래만 <span class='highlighted-text'>허용</span> 합니다.";
    } else {
        alarmSpan.textContent = "";
    }
}



function openChartRegionModal() {
    document.getElementById("myRegionmodal").style.display = "block";

    let regionNameList = [];
    let region_cntList = [];
    let amount_sumList = [];
    $.ajax({
        url: '/chart/regionServiceChart',
        type: 'GET',
        success: function (data) {

            for (let i = 0; i < data.length; i++) {
                regionNameList.push(data[i].regionName);
                region_cntList.push(data[i].regionCnt);
                amount_sumList.push(data[i].amountSum);
            }



             // recommend
            // 세 개의 지역 이름을 연결
            const joinedRegionNames = regionNameList.slice(0, 3).join(', ');

            // 연결된 문자열을 <span class="recomend"></span> 내에 넣기
            document.querySelector('.recomend').textContent = joinedRegionNames;

            var ctx1 = document.getElementById('myRegionCntChart').getContext('2d');
            new Chart(ctx1, {
                type: 'bar',
                data: {
                    labels: regionNameList,
                    datasets: [{
                        data: region_cntList,
                        backgroundColor: '#355C7D',
                        borderColor: '#355C7D',
                        borderWidth: 1
                    }]
                },
                options: {
                    plugins: {
                        legend: {
                            display: false, // Set to false to hide the legend
                        }
                    },
                    scales: {
                        y: {
                            beginAtZero: true,
                            ticks: {
                                // 사용자 정의 레이블 콜백 함수
                                callback: function(value, index, values) {
                                    return value + '건';
                                }
                            }
                        }
                    }
                }

            });

        },
        error: function () {
            console.error("Error while fetching data");
        }
    });
}

function closeChartRegionModal() {
    document.getElementById("myRegionmodal").style.display = "none";
}



function collectButtonValues() {
    const btnDiv = document.querySelector('.myselect-region-ok-content');
    const buttons = btnDiv.querySelectorAll('button.selected-region-ok');
    let values = [];

    buttons.forEach(btn => {
        values.push(btn.textContent);
    });

    return values;
}

function registerRegion() {
    const values = collectButtonValues();
    const queryString = values.map(value => `region=${value}`).join('&');
    window.location.href = `/safetyCard/safetySettingValue?${queryString}`;
}