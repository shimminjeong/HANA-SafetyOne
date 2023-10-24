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
        newButton.style.display = 'inline-block';
        newButton.textContent = timeText;
        newButton.classList.add('selected-time-no', 'custom-button-style');

        selectedBtnDiv.appendChild(newButton);

        newButton.addEventListener('click', function(event) {
            event.target.remove();
            updateAlarmText();
        });
    });

    updateAlarmText();
}


function updateTime() {
    const startHour = document.getElementById('startHour').value;
    const endHour = document.getElementById('endHour').value;
    const timeText = startHour + '시 ~ ' + endHour + '시 ';

    const allSelectedBtnDivs = document.querySelectorAll('.myselect-time-no-content');

    allSelectedBtnDivs.forEach(selectedBtnDiv => {
        const newButton = document.createElement('button');
        newButton.textContent = timeText;
        newButton.classList.add('selected-time-no', 'custom-button-style');

        selectedBtnDiv.appendChild(newButton);

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
    var allAlarmSpans = document.querySelectorAll('.select-alarm');

    allAlarmSpans.forEach(alarmSpan => {
        if (existingButtons.length > 0) {
            alarmSpan.innerHTML = "까지 거래를 <span class='highlighted-text-no'>차단</span>합니다.";
        } else {
            alarmSpan.textContent = "";
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

            let topThreeTimes = data.slice()
                .sort((a, b) => b.timeCnt - a.timeCnt)
                .slice(0, 3)  // 상위 3개 항목 선택
                .map(item => item.time + '시');

            let joinedTimes = topThreeTimes.join(', ');
            document.querySelector('.recomend').textContent = joinedTimes;

            let bottomThreeTimes = data.slice()
                .sort((a, b) => a.timeCnt - b.timeCnt)
                .slice(0, 3)
                .map(item => item.time + '시');

            let joinedBottomTimes = bottomThreeTimes.join(', ');
            document.querySelector('.recomend-bottom').textContent = joinedBottomTimes;


            for (let i = 0; i < data.length; i++) {
                timeNameList.push(data[i].time+'시');
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
                        backgroundColor: '#355C7D',
                        borderColor:'#355C7D',
                        borderWidth: 1
                    }]
                },
                options: {
                    plugins: {
                        legend: {
                            display: false,
                        }
                    },
                    scales: {
                        x: {
                            ticks: {
                                maxRotation: 0,
                                minRotation: 0
                            }
                        },
                        y: {
                            beginAtZero: true,
                            ticks: {
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

        newqueryString = `${currentQueryString}&${queryString}`;
    } else {

        newqueryString = `?${queryString}`;
    }
    console.log("newqueryString",newqueryString);

    window.location.href = `/safetyCard/safetySettingValue${newqueryString}`;
}

