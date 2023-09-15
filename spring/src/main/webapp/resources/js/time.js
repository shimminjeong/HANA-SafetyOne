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

    for (let i = 0; i <= 23; i++) {
        const option1 = document.createElement('option');
        const option2 = document.createElement('option');

        // 시간을 두 자리로 포맷팅
        const formattedHour = i.toString().padStart(2, '0');

        option1.value = formattedHour;
        option1.textContent = formattedHour;

        option2.value = formattedHour;
        option2.textContent = formattedHour;

        startHourSelect.appendChild(option1);
        endHourSelect.appendChild(option2);
    }

}

function handleTimeRangeClick(button) {
    const timeText = button.textContent;

    const allSelectedBtnDivs = document.querySelectorAll('.myselect-time-no-content');

    allSelectedBtnDivs.forEach(selectedBtnDiv => {
        const newButton = document.createElement('button');
        newButton.textContent = timeText;
        newButton.classList.add('selected-time-no', 'custom-button-style');

        // 새로운 버튼을 선택된 버튼 영역에 추가
        selectedBtnDiv.appendChild(newButton);

        // 클릭 이벤트 리스너 추가
        newButton.addEventListener('click', function(event) {
            event.target.remove();
            updateAlarmText();
        });
    });

    updateAlarmText();
}


// 시작 시간 업데이트
function updateTime() {
    const startHour = document.getElementById('startHour').value;
    const endHour = document.getElementById('endHour').value;
    const timeText = startHour + ' 시 ~ ' + endHour + ' 시 ';

    const allSelectedBtnDivs = document.querySelectorAll('.myselect-time-no-content');

    allSelectedBtnDivs.forEach(selectedBtnDiv => {
        const newButton = document.createElement('button');
        newButton.textContent = timeText;
        newButton.classList.add('selected-time-no', 'custom-button-style');

        // 새로운 버튼을 선택된 버튼 영역에 추가
        selectedBtnDiv.appendChild(newButton);

        // 클릭 이벤트 리스너 추가
        newButton.addEventListener('click', function(event) {
            event.target.remove();
            updateAlarmText();
        });
    });

    updateAlarmText();
}

function updateAlarmText() {
    var selectedBtnDiv = document.querySelector('.myselect-time-no-content');
    var existingButtons = selectedBtnDiv.querySelectorAll('.selected-time-no');
    // .select-alarm 클래스를 가진 모든 요소들 선택
    var allAlarmSpans = document.querySelectorAll('.select-alarm');

    allAlarmSpans.forEach(alarmSpan => {
        if (existingButtons.length > 0) {
            alarmSpan.textContent = "까지 결제를 차단합니다.";
        } else {
            alarmSpan.textContent = ""; // 텍스트 삭제
        }
    });
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

function collectButtonValues() {
    const btnDiv = document.querySelector('.myselect-time-no-content');
    const buttons = btnDiv.querySelectorAll('button.selected-time-no');
    let values = [];

    buttons.forEach(btn => {
        values.push(btn.textContent);
    });

    return values;
}

function registerTime() {
    const values = collectButtonValues();
    const queryString = values.map(value => `time=${value}`).join('&');
    const currentPath = window.location.pathname;
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

