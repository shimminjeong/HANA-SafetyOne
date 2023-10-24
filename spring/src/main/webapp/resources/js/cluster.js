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


    document.querySelectorAll('.open-modal').forEach(function (button) {
        button.addEventListener('click', function (event) {
            var clusterPeopleCount = event.target.getAttribute('data-clusterPeopleCount');
            console.log("clusterPeopleCount", clusterPeopleCount);

            // Update .people-info element's text
            document.querySelector('.people-info').innerText = "군집에 포함된 회원 수 : " + clusterPeopleCount + "명";
        });
    });


    var totalAmount = chartData.cluster1.totalAmount;

    var meanDiv = document.querySelector('.mean-div');

    meanDiv.innerHTML = "한 달 평균 사용금액 : 약 <span style='color: red;'>" + totalAmount.toLocaleString() + "</span>원";


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

    var labels = data.map(function (item) {
        return '[' + item.categorySmall + ']';
    });

    var selectedLabels = labels.slice(0, 5).join('\n');

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
                    backgroundColor: 'rgb(7,143,137)',
                    yAxisID: 'y-axis-count'
                },
                {
                    label: '거래금액',
                    data: amountData,
                    backgroundColor: 'rgba(199,123,45,0.87)',
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


    var labels = data.map(function (item) {
        return '[' + item.categorySmall + ']';
    });

    var selectedLabels = labels.slice(0, 5).reverse().join('\n');

    document.querySelector('.smallcategory').innerText = selectedLabels;

    var labels = data.map(function (item) {
        return item.categorySmall;
    }).reverse();


    var amountData = data.map(function (item) {
        return item.totalAmount;
    }).reverse();

    var countData = data.map(function (item) {
        return item.count;
    }).reverse();

    console.log("labels", labels);
    console.log("amountData", amountData);
    console.log("countData", countData);


    myRadarChart = new Chart(ctx, {
        type: 'bar',
        data: {
            labels: labels,
            datasets: [
                {
                    label: '거래건수',
                    data: countData,
                    backgroundColor: 'rgb(7,143,137)',
                    yAxisID: 'y-axis-count'
                },
                {
                    label: '거래금액',
                    data: amountData,
                    backgroundColor: 'rgba(199,123,45,0.87)',
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
        return data ? -data.count : 0;
    });


    var ctx = document.getElementById('genderAgeChart').getContext('2d');
    horizontalChart = new Chart(ctx, {
        type: 'horizontalBar',
        data: {
            labels: ageRanges,
            datasets: [{
                label: '남성',
                data: mCounts,
                backgroundColor: 'rgb(9,82,131)'
            }, {
                label: '여성',
                data: fCounts,
                backgroundColor: 'rgb(245,83,117)'
            }]
        },
        options: {
            scales: {
                xAxes: [{
                    ticks: {
                        beginAtZero: true,
                        callback: function (value) {
                            return Math.abs(value) + '명';
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