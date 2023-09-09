function closeChartRegionModal() {
    document.getElementById("myRegionmodal").style.display = "none";
}


function registerRegion() {
    var selectedBtnDiv = document.querySelector('.myselect-region-ok-content');
    var selectedValues = Array.from(selectedBtnDiv.querySelectorAll('[data-value]'))
        .map(el => el.getAttribute('data-value')); // 값들을 배열로 가져옴

    fetch('/safetyCard/region', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({values: selectedValues})
    })
        .then(response => response.json())
        .then(data => {
            // 서버에서 반환한 응답을 처리
            console.log(data);
        })
        .catch(error => {
            console.error('Error:', error);
        });

}


function selectRegion(button) {
    var value = button.value;
    button.style.color = 'green';
    var selectedBtnDiv = document.querySelector('.myselect-region-ok-content');

    // 새로운 버튼 생성
    var newButton = document.createElement('button');
    newButton.textContent = value;
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

    if (existingButtons.length > 0) {
        alarmSpan.textContent = "외 모든 지역을 차단합니다.";
    } else {
        alarmSpan.textContent = ""; // 텍스트 삭제
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

            var ctx1 = document.getElementById('myRegionCntChart').getContext('2d');
            new Chart(ctx1, {
                type: 'bar',
                data: {
                    labels: regionNameList,
                    datasets: [{
                        label: '지역별 나의 소비 횟수',
                        data: region_cntList,
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
