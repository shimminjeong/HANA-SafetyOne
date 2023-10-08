
var radarChartMany;
var myRadarChart;
var horizontalChart;
function drawChart(chartData) {



    if (radarChartMany) {
        radarChartMany.destroy();
    }

    if (horizontalChart) {
        horizontalChart.destroy();
    }

    if (myRadarChart) {
        myRadarChart.destroy();
    }


    var modalButton = document.querySelector('.open-modal');
    var clusterPeopleCount = modalButton.getAttribute('data-clusterPeopleCount');

    // .people-info 요소의 텍스트 업데이트
    document.querySelector('.people-info').innerText = "군집에 포함된 회원 수 : " + clusterPeopleCount + "명";

    // chartData.cluster1.totalAmount의 값을 가져옵니다.
    var totalAmount = chartData.cluster1.totalAmount;

// .mean-div 클래스를 가진 <div> 요소를 선택합니다.
    var meanDiv = document.querySelector('.mean-div');

// 해당 <div> 요소의 내용을 수정합니다.
    meanDiv.innerText = "한달 평균 사용금액 : 약 " + totalAmount.toLocaleString() + "원";

    // chartData.cluster1.clusterNum
    var reportDiv = document.querySelector('.report');
    reportDiv.innerText = chartData.cluster1.clusterNum + " 번 군집 대시보드";



    var ctx = document.getElementById('manyChart').getContext('2d');

    var data = chartData.clusterDetail.slice(0, 5).map(function (item) {
        return {
            categorySmall: item.categorySmall,
            totalAmount: item.totalAmount,
            count: item.count
        };
    });

    // labels 배열 생성
    var labels = data.map(function (item) {
        return '[' + item.categorySmall + ']';
    });

// labels 배열에서 처음 3개의 값을 선택하고 줄 바꿈으로 결합
    var selectedLabels = labels.slice(0, 3).join('\n');

// 해당 <div> 요소의 내용을 수정
    document.querySelector('.bigcategory').innerText = selectedLabels;


    var labels = data.map(function (item) {
        return item.categorySmall;
    });


    var amountData = data.map(function (item) {
        return item.totalAmount;
    });

    var countData = data.map(function (item) {
        return item.count;
    });



    radarChartMany = new Chart(ctx, {
        type: 'bar',
        data: {
            labels: labels,
            datasets: [
                {
                    label: '거래건수',
                    data: countData,
                    backgroundColor: 'rgba(255, 99, 132, 0.5)', // 붉은색
                    yAxisID: 'y-axis-count'
                },
                {
                    label: '평균 거래금액',
                    data: amountData,
                    backgroundColor: 'rgba(54, 162, 235, 0.5)', // 파란색
                    yAxisID: 'y-axis-sum'
                }
            ]
        },
        options: {
            responsive: true,
            legend: {
                position: 'top'
            },
            scales: {
                xAxes: [{
                    stacked: false
                }],
                yAxes: [
                    {
                        id: 'y-axis-count',
                        position: 'left',
                        ticks: {
                            beginAtZero: true,
                            callback: function (value, index, values) {
                                return value + '건';
                            }
                        }
                    },
                    {
                        id: 'y-axis-sum',
                        position: 'right',
                        ticks: {
                            beginAtZero: true,
                            callback: function (value, index, values) {
                                return new Intl.NumberFormat('en-US').format(value / 10000) + '만원';
                            }
                        },
                        gridLines: {
                            display: false
                        }

                    }
                ]
            }
        }
    });



    var ctx = document.getElementById('smallChart').getContext('2d');

    var data = chartData.clusterDetail.slice(-5).map(function (item) {
        return {
            categorySmall: item.categorySmall,
            totalAmount: item.totalAmount,
            count: item.count
        };
    });

    // labels 배열 생성
    var labels = data.map(function (item) {
        return '[' + item.categorySmall + ']';
    });

// labels 배열에서 처음 3개의 값을 선택하고 줄 바꿈으로 결합
    var selectedLabels = labels.slice(0, 3).join('\n');

// 해당 <div> 요소의 내용을 수정
    document.querySelector('.smallcategory').innerText = selectedLabels;

    var labels = data.map(function (item) {
        return item.categorySmall;
    });


    var amountData = data.map(function (item) {
        return item.totalAmount;
    });

    var countData = data.map(function (item) {
        return item.count;
    });

    console.log("labels",labels);
    console.log("amountData",amountData);
    console.log("countData",countData);



    myRadarChart = new Chart(ctx, {
        type: 'bar',
        data: {
            labels: labels,
            datasets: [
                {
                    label: '거래건수',
                    data: countData,
                    backgroundColor: 'rgba(255, 99, 132, 0.5)', // 붉은색
                    yAxisID: 'y-axis-count'
                },
                {
                    label: '거래금액',
                    data: amountData,
                    backgroundColor: 'rgba(54, 162, 235, 0.5)', // 파란색
                    yAxisID: 'y-axis-sum'
                }
            ]
        },
        options: {
            responsive: true,
            legend: {
                position: 'top'
            },
            scales: {
                xAxes: [{
                    stacked: false
                }],
                yAxes: [
                    {
                        id: 'y-axis-count',
                        position: 'left',
                        ticks: {
                            beginAtZero: true,
                            callback: function (value, index, values) {
                                return value + '건';
                            }
                        }
                    },
                    {
                        id: 'y-axis-sum',
                        position: 'right',
                        ticks: {
                            beginAtZero: true,
                            callback: function (value, index, values) {
                                return new Intl.NumberFormat('en-US').format(value / 10000) + '만원';
                            }
                        },
                        gridLines: {
                            display: false
                        }

                    }
                ]
            }
        }
    });


    // 인구분포
    var rawData = chartData.clusterPeopleInfo.map(function (item) {
        return {
            gender: item.gender,
            ageRange: item.ageRange,
            count: item.count
        };
    });

    var ageRanges = ['20대', '30대', '40대', '50대', '60대', '70대이상'];

    var mCounts = ageRanges.map(function (range) {
        var data = rawData.find(function (item) {
            return item.gender === 'M' && item.ageRange === range;
        });
        return data ? data.count : 0;
    });

    var fCounts = ageRanges.map(function (range) {
        var data = rawData.find(function (item) {
            return item.gender === 'F' && item.ageRange === range;
        });
        return data ? -data.count : 0; // 음수로 설정하여 왼쪽에 그리게 합니다.
    });



    var ctx = document.getElementById('genderAgeChart').getContext('2d');
    horizontalChart=new Chart(ctx, {
        type: 'horizontalBar',
        data: {
            labels: ageRanges,
            datasets: [{
                label: 'M',
                data: mCounts,
                backgroundColor: 'blue'
            }, {
                label: 'F',
                data: fCounts,
                backgroundColor: 'pink'
            }]
        },
        options: {
            scales: {
                xAxes: [{
                    ticks: {
                        beginAtZero: true,
                        callback: function (value) {
                            return Math.abs(value);
                        }
                    }
                }]
            },
            legend: {
                display: true,
                position: 'top'
            }
        }
    });


}