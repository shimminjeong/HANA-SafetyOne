document.addEventListener("DOMContentLoaded", function() {
    populateTimeOptions();
});

function populateTimeOptions() {
    const startHourSelect = document.getElementById('startHour');
    const endHourSelect = document.getElementById('endHour');

    if(!startHourSelect || !endHourSelect) {
        console.error("Elements not found!");
        return;
    }

    for (let i = 1; i <= 24; i++) {
        const option1 = document.createElement('option');
        option1.value = i;
        option1.textContent = i;
        startHourSelect.appendChild(option1);

        const option2 = option1.cloneNode(true);
        endHourSelect.appendChild(option2);
    }
}

function handleTimeRangeClick(button) {
    const timeText = button.textContent;

    const selectedBtnDiv = document.querySelector('.myselect-time-no-content');
    const newButton = document.createElement('button');
    newButton.textContent = timeText;
    newButton.classList.add('selected-time-no', 'custom-button-style');

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


// 시작 시간 업데이트
function updateTime() {
    const startHour = document.getElementById('startHour').value;
    const endHour = document.getElementById('endHour').value;
    const timeText = startHour + ' 시 ~ ' + endHour + ' 시 ';

    const selectedBtnDiv = document.querySelector('.myselect-time-no-content');


    const newButton = document.createElement('button');
    newButton.textContent = timeText;
    newButton.classList.add('selected-time-no', 'custom-button-style');

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
    var selectedBtnDiv = document.querySelector('.myselect-time-no-content');
    var existingButtons = selectedBtnDiv.querySelectorAll('.selected-time-no');
    var alarmSpan = document.querySelector('.select-alarm');

    if (existingButtons.length > 0) {
        alarmSpan.textContent = "까지 결제를 차단합니다.";
    } else {
        alarmSpan.textContent = ""; // 텍스트 삭제
    }
}


function openChartTimeModal() {
    document.getElementById("myTimemodal").style.display = "block";

    let timeNameList = [];
    let timeCntList = [];
    let timeSumList = [];

    $.ajax({
        url: '/chart/timeServiceChart',
        type: 'GET',
        success: function (data) {
            for (let i = 0; i < data.length; i++) {
                timeNameList.push(data[i].time);
                timeCntList.push(data[i].timeCnt);
                timeSumList.push(data[i].amountSum);
            }
            console.log(timeNameList);

            var ctx1 = document.getElementById('myTimeCntChart').getContext('2d');
            new Chart(ctx1, {
                type: 'bar',
                data: {
                    labels: timeNameList,
                    datasets: [{
                        label: '시간대별 나의 소비 횟수',
                        data: timeCntList,
                        backgroundColor: 'rgba(75, 192, 192, 0.2)',
                        borderColor: 'rgb(75, 192, 192)',
                        borderWidth: 1
                    }]
                },
                options: {
                    scales: {
                        y: {
                            beginAtZero: true
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


function closeChartTimeModal() {
    document.getElementById("myTimemodal").style.display = "none";
}
