function computeHistogram(data, bins) {
    let min = Math.min(...data);
    let max = Math.max(...data);
    let binSize = (max - min) / bins;
    let histogram = new Array(bins).fill(0);

    for (let value of data) {
        let binIndex = Math.min(Math.floor((value - min) / binSize), bins - 1);
        histogram[binIndex]++;
    }

    let binCenters = [...Array(bins).keys()].map(i => min + (i * binSize) + (binSize / 2));

    let normalizedHistogram = histogram.map(val => val / (data.length * binSize));
    let histogramPoints = binCenters.map((center, index) => {
        return {x: center, y: normalizedHistogram[index]};
    });

    return histogramPoints;
}

let myChart = null;

function destroyChart() {
    if (myChart !== null) {
        myChart.destroy(); // 이전 차트 파기
        myChart = null; // 변수 초기화
    }
}

function drawChart(elementId, labels, pdfData, numericData, xAxisLabel, pointData, X_feature) {

    destroyChart();

    const ctx = document.getElementById(elementId).getContext('2d');

    let bins = 20;
    let histogramData = computeHistogram(X_feature, bins);

    const data = {
        labels: labels,
        datasets: [{
            label: '확률분포',
            data: pdfData,
            borderColor: 'rgba(37,150,99,0.5)',
            backgroundColor: 'green',
            borderWidth: 0.3,
            pointRadius: 1.8
        },
            {
                label: '거래데이터',
                data: [{ x: numericData, y: 0 }],
                borderColor: 'red',
                borderWidth: 2,
                pointRadius: 5,
                pointHoverRadius: 8,
                showLine: false,
                pointStyle: 'circle',
                backgroundColor: 'rgb(245,83,117)'
            }, {
                label: '빈도수',
                data: histogramData,
                type: 'bar',
                backgroundColor: 'rgb(6,63,103)',
                borderWidth: 1,
                barPercentage: 1.2
            }]
    };

    const options = {
        scales: {
            x: {
                type: 'linear',
                position: 'bottom',
                title: {
                    display: true,
                }
            }
        },
        plugins: {
            legend: {
                display: true
            },
            afterDatasetsDraw: function (chart, easing) {
                if (easing !== 1) return;

                var ctx = chart.ctx;
                chart.data.datasets.forEach(function (dataset, i) {
                    var meta = chart.getDatasetMeta(i);
                    if (meta.type !== 'bar') return;

                    meta.data.forEach(function (bar, index) {
                        var yPosition = bar._model.y - 5;

                        var data = dataset.data[index].y;

                        ctx.fillText(data.toFixed(2), bar._model.x, yPosition);
                    });
                });
            }
        }
    };

    myChart =new Chart(ctx, {
        type: 'line',
        data: data,
        options: options
    });
}

let myChart2 = null;

function destroyChart2() {
    if (myChart2 !== null) {
        myChart2.destroy();
        myChart2 = null;
    }
}

function drawChart2(elementId, labels, pdfData, numericData, xAxisLabel, pointData, X_feature) {

    destroyChart2();

    const ctx = document.getElementById(elementId).getContext('2d');

    let bins = 20;
    let histogramData = computeHistogram(X_feature, bins);

    const data = {
        labels: labels,
        datasets: [{
            label: '확률분포',
            data: pdfData,
            borderColor: 'rgba(37,150,99,0.5)',
            backgroundColor: 'green',
            borderWidth: 0.3,
            pointRadius: 1.8,
            fill: false
        },
            {
                label: '거래데이터',
                data: [{ x: numericData, y: 0 }],
                borderColor: 'red',
                borderWidth: 2,
                pointRadius: 5,
                pointHoverRadius: 8,
                showLine: false,
                pointStyle: 'circle',
                backgroundColor: 'rgb(245,83,117)'
            }, {
                label: '빈도수',
                data: histogramData,
                type: 'bar',
                backgroundColor: 'rgb(6,63,103)',
                borderWidth: 1,
                barPercentage: 1.2,
            }]
    };

    const options = {
        scales: {
            x: {
                type: 'linear',
                position: 'bottom',
                title: {
                    display: true,

                }
            }
        },
        plugins: {
            legend: {
                display: true
            },
            afterDatasetsDraw: function (chart, easing) {

                if (easing !== 1) return;

                var ctx = chart.ctx;
                chart.data.datasets.forEach(function (dataset, i) {
                    var meta = chart.getDatasetMeta(i);
                    if (meta.type !== 'bar') return;

                    meta.data.forEach(function (bar, index) {

                        var yPosition = bar._model.y - 5;

                        var data = dataset.data[index].y;

                        ctx.fillText(data.toFixed(2), bar._model.x, yPosition);
                    });
                });
            }
        }
    };

    myChart2 =new Chart(ctx, {
        type: 'line',
        data: data,
        options: options
    });
}




let myChart3 = null;

function destroyChart3() {
    if (myChart3 !== null) {
        myChart3.destroy();
        myChart3 = null;
    }
}

function drawChart3(elementId, labels, pdfData, numericData, xAxisLabel, pointData, X_feature) {

    destroyChart3();

    const ctx = document.getElementById(elementId).getContext('2d');

    let bins = 20;
    let histogramData = computeHistogram(X_feature, bins);

    const data = {
        labels: labels,
        datasets: [{
            label: '확률분포',
            data: pdfData,
            borderColor: 'rgba(37,150,99,0.5)',
            backgroundColor: 'green',
            borderWidth: 0.3,
            pointRadius: 1.8,
            fill: false
        },
            {
                label: '거래데이터',
                data: [{ x: numericData, y: 0 }],
                borderColor: 'red',
                borderWidth: 2,
                pointRadius: 5,
                pointHoverRadius: 8,
                showLine: false,
                pointStyle: 'circle',
                backgroundColor: 'rgb(245,83,117)'
            }, {
                label: '빈도수',
                data: histogramData,
                type: 'bar',
                backgroundColor: 'rgb(6,63,103)',
                borderWidth: 1,
                barPercentage: 1.2,
            }]
    };

    const options = {
        scales: {
            x: {
                type: 'linear',
                position: 'bottom',
                title: {
                    display: true,
                }
            }
        },
        plugins: {
            legend: {
                display: true
            },
            afterDatasetsDraw: function (chart, easing) {
                if (easing !== 1) return;

                var ctx = chart.ctx;
                chart.data.datasets.forEach(function (dataset, i) {
                    var meta = chart.getDatasetMeta(i);
                    if (meta.type !== 'bar') return;

                    meta.data.forEach(function (bar, index) {
                        var yPosition = bar._model.y - 5;

                        var data = dataset.data[index].y;

                        ctx.fillText(data.toFixed(2), bar._model.x, yPosition);
                    });
                });
            }
        }
    };

    myChart3 =new Chart(ctx, {
        type: 'line',
        data: data,
        options: options
    });
}



let myChart1 = null;

function destroyChart1() {
    if (myChart1 !== null) {
        myChart1.destroy();
        myChart1 = null;
    }
}

function drawChart1(elementId, labels, pdfData, numericData, xAxisLabel, pointData, X_feature) {

    destroyChart1();

    const ctx = document.getElementById(elementId).getContext('2d');

    let bins = 20;
    let histogramData = computeHistogram(X_feature, bins);

    const data = {
        labels: labels,
        datasets: [{
            label: '확률분포',
            data: pdfData,
            borderColor: 'rgba(13,128,76,0.5)',
            backgroundColor: 'green',
            borderWidth: 0.3,
            pointRadius: 1.8,
            fill: false
        }, {
            label: '거래데이터',
            data: [{ x: numericData, y: 0 }],
            borderWidth: 2,
            pointRadius: 5,
            pointHoverRadius: 8,
            showLine: false,
            pointStyle: 'circle',
            backgroundColor: 'rgb(245,83,117)'
        }, {
            label: '빈도수',
            data: histogramData,
            type: 'bar',
            backgroundColor: 'rgb(6,63,103)',

            borderWidth: 1,
            barPercentage: 1.2,
        }]
    };


    const options = {
        scales: {
            x: {
                type: 'linear',
                position: 'bottom',
                title: {
                    display: true,
                }
            },
            y: {
                ticks: {
                    callback: function(value, index, values) {
                        let exponent = Math.round(Math.log10(Math.abs(value))) - 4;
                        let baseValue = value / Math.pow(10, Math.round(Math.log10(Math.abs(value))));
                        let formattedValue = baseValue.toFixed(2) + 'E' + (exponent >= 0 ? '+' : '') + exponent;

                        if (!isFinite(baseValue) || isNaN(baseValue) || !isFinite(exponent) || isNaN(exponent)) {
                            return '0';
                        }
                        return formattedValue;
                    }
                }
            }
        },
            legend: {
                labels: {
                    filter: function(item, chart) {
                        if (item.text === '확률분포') {
                            item.fillStyle = 'rgba(37,150,99,0.5)';
                        }
                        return item.text !== '확률분포' ? true : false;
                    },
                    usePointStyle: true,
                }
            },
        plugins: {
            legend: {
                display: true
            },
            afterDatasetsDraw: function (chart, easing) {
                if (easing !== 1) return;

                var ctx = chart.ctx;
                chart.data.datasets.forEach(function (dataset, i) {
                    var meta = chart.getDatasetMeta(i);
                    if (meta.type !== 'bar') return;

                    meta.data.forEach(function (bar, index) {

                        var yPosition = bar._model.y - 5;

                        var data = dataset.data[index].y;

                        ctx.fillText(data.toFixed(2), bar._model.x, yPosition);
                    });
                });
            }
        }
    };

    myChart1=new Chart(ctx, {
        type: 'line',
        data: data,
        options: options
    });
}


function showAnomalyDetails(paymentLogId, cardId) {
    console.log(paymentLogId);
    console.log(cardId);
    $.ajax({
        type: 'POST',
        url: '/admin/anomalyChart',
        data: JSON.stringify({
            paymentLogId: paymentLogId,
            cardId: cardId
        }),
        contentType: 'application/json',
        dataType: 'json',
        success: function (responseData) {

            if (responseData.regionCntList && responseData.regionCntList.length >= 3) {
                const regionDiv = document.querySelector(".region-top");
                regionDiv.appendChild(document.createElement("br"));
                regionDiv.appendChild(document.createTextNode("1. " + responseData.regionCntList[0].regionName));
                regionDiv.appendChild(document.createElement("br"));
                regionDiv.appendChild(document.createTextNode("2. " + responseData.regionCntList[1].regionName));
                regionDiv.appendChild(document.createElement("br"));
                regionDiv.appendChild(document.createTextNode("3. " + responseData.regionCntList[2].regionName));
            }

            // 거래업종 TOP3
            if (responseData.categoryCntList && responseData.categoryCntList.length >= 3) {
                const categoryDiv = document.querySelector(".category-top");
                categoryDiv.appendChild(document.createElement("br"));
                categoryDiv.appendChild(document.createTextNode("1. " + responseData.categoryCntList[0].categorySmall));
                categoryDiv.appendChild(document.createElement("br"));
                categoryDiv.appendChild(document.createTextNode("2. " + responseData.categoryCntList[1].categorySmall));
                categoryDiv.appendChild(document.createElement("br"));
                categoryDiv.appendChild(document.createTextNode("3. " + responseData.categoryCntList[2].categorySmall));
            }


            const splitAddress = responseData.address.split(' ');
            const formattedAddress = splitAddress[0] + ' ' + splitAddress[1];

            drawChart('gaussianChart1', responseData.regionPdf[0], responseData.regionPdf[1], responseData.embeddingData.regionNameNumeric, '지역', formattedAddress, responseData.regionFeature);
            drawChart2('gaussianChart2', responseData.timePdf[0], responseData.timePdf[1], responseData.embeddingData.timeNumeric, '시간', responseData.embeddingData.timeNumeric + '시', responseData.timeFeature);
            drawChart3('gaussianChart3', responseData.categorySmallPdf[0], responseData.categorySmallPdf[1], responseData.embeddingData.categorySmallNumeric, '업종', responseData.category, responseData.categoryFeature);
            drawChart1('gaussianChart4', responseData.amountPdf[0], responseData.amountPdf[1], responseData.embeddingData.amountNumeric, '금액', responseData.embeddingData.amountNumeric.toLocaleString() + '원', responseData.amountFeature);


            const cardIdElement = document.querySelector('.anomalychart-info .cardId');
            const regionElement = document.querySelector('.info-right .region');
            const timeElement = document.querySelector('.info-right .time');
            const categoryElement = document.querySelector('.info-right .category');
            const amountElement = document.querySelector('.info-right .amount');

            const cardIdValue = cardId+' 카드의 ';
            const regionValue = '거래 지역 : ' + formattedAddress;
            const timeValue = '거래 시간 : ' + responseData.embeddingData.timeNumeric + '시';
            const categoryValue = '거래 업종 : ' + responseData.category;
            const amountValue = '거래 금액 : ' + responseData.embeddingData.amountNumeric.toLocaleString() + '원';

            cardIdElement.textContent = cardIdValue;
            regionElement.textContent = regionValue;
            timeElement.textContent = timeValue;
            categoryElement.textContent = categoryValue;
            amountElement.textContent = amountValue;


            modal.style.display = "block";
        },
        error: function (error) {
            console.error('Error:', error);
        }
    });
}

