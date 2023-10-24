function changeMapImage(buttonElement) {
    var newImagePath = buttonElement.getAttribute('data-img');
    document.getElementById('mapImage').src = newImagePath;
}

function selectRegion(button) {
    const value = button.value;
    button.style.color = 'white';
    button.style.background = '#00857F';
    const selectedBtnDiv = document.querySelector('.myselect-region-ok-content');

    const newButton = document.createElement('button');
    newButton.textContent = value;
    newButton.style.background = '#00857F';  // 배경색 설정
    newButton.classList.add('selected-region-ok', 'custom-button-style');
    selectedBtnDiv.appendChild(newButton);

    updateAlarmText();

    newButton.addEventListener('click', function (event) {

        button.style.color = 'red';

        event.target.remove();

        updateAlarmText();
    });
}

function updateAlarmText() {
    var selectedBtnDiv = document.querySelector('.myselect-region-ok-content');
    var existingButtons = selectedBtnDiv.querySelectorAll('.selected-region-ok');
    var alarmSpan = document.querySelector('.select-alarm');

    var regions = Array.from(existingButtons).map(btn => btn.textContent).join(' ');

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
                            display: false,
                        }
                    },
                    scales: {
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