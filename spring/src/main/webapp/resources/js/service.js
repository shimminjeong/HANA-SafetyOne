var myCategoryCntChart;
var myCategorySumChart;

function selectCategoryBig() {

    if (myCategoryCntChart) {
        console.log("myCategoryCntChart", myCategoryCntChart)
        myCategoryCntChart.destroy();
    }

    if (myCategorySumChart) {
        myCategorySumChart.destroy();
    }


    setTimeout(() => {
        var selectedCategory = document.getElementById('selectCategoryBig').value;

        let categorySmallList = [];
        let categoryCntList = [];
        let amountSumList = [];

        $.ajax({
            url: '/chart/categoryServiceChart',
            type: 'POST',
            contentType: 'application/json',
            data: JSON.stringify({categoryBig: selectedCategory}),
            success: function (data) {
                for (let i = 0; i < data.length; i++) {
                    categorySmallList.push(data[i].categorySmall);
                    categoryCntList.push(data[i].categoryCnt);
                    amountSumList.push(data[i].amountSum);
                }

                // 첫 번째 바 차트 그리기
                var ctx1 = document.getElementById('myCategoryCntChart').getContext('2d');
                new Chart(ctx1, {
                    type: 'bar',
                    data: {
                        labels: categorySmallList,
                        datasets: [{
                            label: 'Amount Count',
                            data: categoryCntList,
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

                // 두 번째 바 차트 그리기
                var ctx2 = document.getElementById('myCategorySumChart').getContext('2d');
                new Chart(ctx2, {
                    type: 'bar',
                    data: {
                        labels: categorySmallList,
                        datasets: [{
                            label: 'Amount Sum',
                            data: amountSumList,
                            backgroundColor: 'rgba(255, 99, 132, 0.2)',
                            borderColor: 'rgb(255, 99, 132)',
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

    }, 100);
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

            var ctx2 = document.getElementById('myRegionSumChart').getContext('2d');
            new Chart(ctx2, {
                type: 'bar',
                data: {
                    labels: regionNameList,
                    datasets: [{
                        label: 'Amount Sum',
                        data: amount_sumList,
                        backgroundColor: 'rgba(255, 99, 132, 0.2)',
                        borderColor: 'rgb(255, 99, 132)',
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

            var ctx2 = document.getElementById('myTimeSumChart').getContext('2d');
            new Chart(ctx2, {
                type: 'bar',
                data: {
                    labels: timeNameList,
                    datasets: [{
                        label: 'Amount Sum',
                        data: timeSumList,
                        backgroundColor: 'rgba(255, 99, 132, 0.2)',
                        borderColor: 'rgb(255, 99, 132)',
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