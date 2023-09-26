function drawChart(chartData) {

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


    var ctx= document.getElementById('manyChart').getContext('2d');

    var data = chartData.clusterDetail.slice(0, 5).map(function (item) {
        return {
            categorySmall: item.categorySmall,
            totalAmount: item.totalAmount,
            count: item.count
        };
    });

    // labels 배열 생성
    var labels = data.map(function(item) {
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

    var myRadarChart = new Chart(ctx, {
        type: 'radar',
        data: {
            labels: labels,
            datasets: [
                {
                    label: 'top5 거래금액',
                    data: amountData,
                    backgroundColor: 'rgba(54, 162, 235, 0.2)',
                    borderColor: 'rgba(54, 162, 235, 1)',
                    borderWidth: 1,
                    datalabels: {
                        align: 'end',
                        anchor: 'end',
                        color: '#555',
                        formatter: function (value, context) {
                            return value.toLocaleString();  // 숫자를 콤마로 구분된 문자열로 변환
                        }
                    }
                }]
        },
        options: {
            scale: {
                ticks: {
                    beginAtZero: true
                }
            },
            plugins: {
                datalabels: {
                    display: true
                }
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
    var labels = data.map(function(item) {
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

    console.log("amountData" + amountData);

    var myRadarChart = new Chart(ctx, {
        type: 'radar',
        data: {
            labels: labels,
            datasets: [
                {
                    label: 'amount',
                    data: amountData,
                    backgroundColor: 'rgba(54, 162, 235, 0.2)',
                    borderColor: 'rgba(54, 162, 235, 1)',
                    borderWidth: 1
                }]
        },
        options: {
            scale: {
                ticks: {
                    beginAtZero: true
                }
            },
            plugins: {
                datalabels: {
                    display: true
                }
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
    new Chart(ctx, {
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