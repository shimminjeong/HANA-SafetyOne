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
                'rgba(255, 99, 132, 0.2)',
                'rgba(54, 162, 235, 0.2)',
                'rgba(255, 206, 86, 0.2)',
                'rgba(75, 192, 192, 0.2)',
                'rgba(153, 102, 255, 0.2)',
                'rgba(255, 159, 64, 0.2)',
                'rgba(99, 255, 132, 0.2)',
                'rgba(255, 99, 255, 0.2)',
                'rgba(255, 255, 0, 0.2)',
                'rgba(132, 99, 255, 0.2)'
                // 필요한 만큼 더 많은 색상을 추가할 수 있습니다.
            ];

            myChart = new Chart(ctx1, {
                type: 'pie',
                data: {
                    labels: categorySmallList,
                    datasets: [{
                        label: 'Amount Count',
                        data: categoryCntList,
                        backgroundColor: colors,  // 각 데이터 항목에 대한 색상 배열
                        borderColor: 'rgb(75, 192, 192)',
                        borderWidth: 1
                    }]
                }
            });
        },
        error: function () {
            console.log('Error fetching categorySmall data.');
        }
    });
}

function selectRegion(button) {
    var value = button.value;
    var selectedBtnDiv = document.querySelector('.selected-btn');

    // 새로운 버튼 생성
    var newButton = document.createElement('button');
    newButton.textContent = value;
    newButton.classList.add('selected-region');

    // 새로운 버튼을 선택된 버튼 영역에 추가
    selectedBtnDiv.appendChild(newButton);

    document.querySelector('.selected-btn').addEventListener('click', function (event) {
        // 클릭된 요소가 버튼인 경우에만 동작
        if (event.target.tagName === 'BUTTON') {
            // 클릭된 버튼 제거
            event.target.remove();
        }
    });
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
                        label: 'Amount Count',
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

function openChartCategoryModal() {
    document.getElementById("myCategorymodal").style.display = "block";
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
                        label: 'Amount Count',
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


function closeChartRegionModal() {
    document.getElementById("myRegionmodal").style.display = "none";
}

function closeChartCategoryModal() {
    document.getElementById("myCategorymodal").style.display = "none";
}

function closeChartTimeModal() {
    document.getElementById("myTimemodal").style.display = "none";
}

function openMapModal() {
    document.getElementById("mapmodal").style.display = "block";
}

function closeMapModal() {
    document.getElementById("mapmodal").style.display = "none";
}

function openCategoryModal() {
    document.getElementById("categorymodal").style.display = "block";
}

function closeCategoryModal() {
    document.getElementById("categorymodal").style.display = "none";
}



