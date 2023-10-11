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

let myChart = null; // 차트를 저장할 변수

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
        labels: labels,  // 이것은 Gaussian PDF 데이터를 위한 것이므로 그대로 둡니다.
        datasets: [{
            label: '확률분포',
            data: pdfData,
            borderColor: 'rgb(14,157,151)', // 예쁜 터쿼이즈색
            borderWidth: 0.3,
            pointRadius: 1.5,
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
                pointStyle: 'circle', // 내부가 채워진 circle로 표시
                backgroundColor: 'rgb(245,83,117)' // 원 내부의 채우는 색상 설정
            }, {
                label: '빈도수',
                data: histogramData,  // 히스토그램의 데이터는 x, y 쌍으로 반환됩니다.
                type: 'bar',
                backgroundColor: 'rgb(6,63,103)',
                borderWidth: 1
            }]
    };

    const options = {
        scales: {
            x: {
                type: 'linear',
                position: 'bottom',
                title: {
                    display: true,
                    text: xAxisLabel
                }
            }
        },
        plugins: {
            legend: {
                display: true
            },
            afterDatasetsDraw: function (chart, easing) {
                // Only on easing complete
                if (easing !== 1) return;

                var ctx = chart.ctx;
                chart.data.datasets.forEach(function (dataset, i) {
                    var meta = chart.getDatasetMeta(i);
                    if (meta.type !== 'bar') return; // Only draw label on bars

                    meta.data.forEach(function (bar, index) {
                        // Calculate where to place the label based on the bar's data value
                        var yPosition = bar._model.y - 5;

                        // Get the data for this bar
                        var data = dataset.data[index].y;

                        // Draw the data value on top of the bar
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

let myChart2 = null; // 차트를 저장할 변수

function destroyChart2() {
    if (myChart2 !== null) {
        myChart2.destroy(); // 이전 차트 파기
        myChart2 = null; // 변수 초기화
    }
}

function drawChart2(elementId, labels, pdfData, numericData, xAxisLabel, pointData, X_feature) {

    destroyChart2();

    const ctx = document.getElementById(elementId).getContext('2d');

    let bins = 20;
    let histogramData = computeHistogram(X_feature, bins);

    const data = {
        labels: labels,  // 이것은 Gaussian PDF 데이터를 위한 것이므로 그대로 둡니다.
        datasets: [{
            label: '확률분포',
            data: pdfData,
            borderColor: 'rgb(14,157,151)', // 예쁜 터쿼이즈색
            borderWidth: 0.3,
            pointRadius: 1.5,
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
                pointStyle: 'circle', // 내부가 채워진 circle로 표시
                backgroundColor: 'rgb(245,83,117)' // 원 내부의 채우는 색상 설정
            }, {
                label: '빈도수',
                data: histogramData,  // 히스토그램의 데이터는 x, y 쌍으로 반환됩니다.
                type: 'bar',
                backgroundColor: 'rgb(6,63,103)',
                borderWidth: 1
            }]
    };

    const options = {
        scales: {
            x: {
                type: 'linear',
                position: 'bottom',
                title: {
                    display: true,
                    text: xAxisLabel
                }
            }
        },
        plugins: {
            legend: {
                display: true
            },
            afterDatasetsDraw: function (chart, easing) {
                // Only on easing complete
                if (easing !== 1) return;

                var ctx = chart.ctx;
                chart.data.datasets.forEach(function (dataset, i) {
                    var meta = chart.getDatasetMeta(i);
                    if (meta.type !== 'bar') return; // Only draw label on bars

                    meta.data.forEach(function (bar, index) {
                        // Calculate where to place the label based on the bar's data value
                        var yPosition = bar._model.y - 5;

                        // Get the data for this bar
                        var data = dataset.data[index].y;

                        // Draw the data value on top of the bar
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




let myChart3 = null; // 차트를 저장할 변수

function destroyChart3() {
    if (myChart3 !== null) {
        myChart3.destroy(); // 이전 차트 파기
        myChart3 = null; // 변수 초기화
    }
}

function drawChart3(elementId, labels, pdfData, numericData, xAxisLabel, pointData, X_feature) {

    destroyChart3();

    const ctx = document.getElementById(elementId).getContext('2d');

    let bins = 20;
    let histogramData = computeHistogram(X_feature, bins);

    const data = {
        labels: labels,  // 이것은 Gaussian PDF 데이터를 위한 것이므로 그대로 둡니다.
        datasets: [{
            label: '확률분포',
            data: pdfData,
            borderColor: 'rgb(14,157,151)', // 예쁜 터쿼이즈색
            borderWidth: 0.3,
            pointRadius: 1.5,
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
                pointStyle: 'circle', // 내부가 채워진 circle로 표시
                backgroundColor: 'rgb(245,83,117)' // 원 내부의 채우는 색상 설정
            }, {
                label: '빈도수',
                data: histogramData,  // 히스토그램의 데이터는 x, y 쌍으로 반환됩니다.
                type: 'bar',
                backgroundColor: 'rgb(6,63,103)',
                borderWidth: 1
            }]
    };

    const options = {
        scales: {
            x: {
                type: 'linear',
                position: 'bottom',
                title: {
                    display: true,
                    text: xAxisLabel
                }
            }
        },
        plugins: {
            legend: {
                display: true
            },
            afterDatasetsDraw: function (chart, easing) {
                // Only on easing complete
                if (easing !== 1) return;

                var ctx = chart.ctx;
                chart.data.datasets.forEach(function (dataset, i) {
                    var meta = chart.getDatasetMeta(i);
                    if (meta.type !== 'bar') return; // Only draw label on bars

                    meta.data.forEach(function (bar, index) {
                        // Calculate where to place the label based on the bar's data value
                        var yPosition = bar._model.y - 5;

                        // Get the data for this bar
                        var data = dataset.data[index].y;

                        // Draw the data value on top of the bar
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



let myChart1 = null; // 차트를 저장할 변수

function destroyChart1() {
    if (myChart1 !== null) {
        myChart1.destroy(); // 이전 차트 파기
        myChart1 = null; // 변수 초기화
    }
}

function drawChart1(elementId, labels, pdfData, numericData, xAxisLabel, pointData, X_feature) {

    destroyChart1();

    const ctx = document.getElementById(elementId).getContext('2d');

    let bins = 20;
    let histogramData = computeHistogram(X_feature, bins);

    const data = {
        labels: labels, // 이것은 Gaussian PDF 데이터를 위한 것이므로 그대로 둡니다.
        datasets: [{
            label: '확률분포',
            data: pdfData,
            borderColor: 'rgb(14,157,151)', // 예쁜 터쿼이즈색
            borderWidth: 0.3,
            pointRadius: 1.5,
            fill: false
        }, {
            label: '거래데이터',
            data: [{ x: numericData, y: 0 }],
            borderWidth: 2,
            pointRadius: 5,
            pointHoverRadius: 8,
            showLine: false,
            pointStyle: 'circle', // 내부가 채워진 circle로 표시
            backgroundColor: 'rgb(245,83,117)' // 원 내부의 채우는 색상 설정
        }, {
            label: '빈도수',
            data: histogramData, // 히스토그램의 데이터는 x, y 쌍으로 반환됩니다.
            type: 'bar',
            backgroundColor: 'rgb(6,63,103)', // 예쁜 파란색

            borderWidth: 1
        }]
    };


    const options = {
        scales: {
            x: {
                type: 'linear',
                position: 'bottom',
                title: {
                    display: true,
                    text: xAxisLabel
                }
            },
            y: {
                ticks: {
                    callback: function(value, index, values) {
                        let exponent = Math.round(Math.log10(Math.abs(value))) - 4;
                        let baseValue = value / Math.pow(10, Math.round(Math.log10(Math.abs(value))));
                        let formattedValue = baseValue.toFixed(2) + 'E' + (exponent >= 0 ? '+' : '') + exponent;

                        // NaN, Infinity, -Infinity를 체크하고 해당 경우에 0 반환
                        if (!isFinite(baseValue) || isNaN(baseValue) || !isFinite(exponent) || isNaN(exponent)) {
                            return '0';
                        }
                        return formattedValue;
                    }
                }
            }
        }


        ,
        plugins: {
            legend: {
                display: true
            },
            afterDatasetsDraw: function (chart, easing) {
                // Only on easing complete
                if (easing !== 1) return;

                var ctx = chart.ctx;
                chart.data.datasets.forEach(function (dataset, i) {
                    var meta = chart.getDatasetMeta(i);
                    if (meta.type !== 'bar') return; // Only draw label on bars

                    meta.data.forEach(function (bar, index) {
                        // Calculate where to place the label based on the bar's data value
                        var yPosition = bar._model.y - 5;

                        // Get the data for this bar
                        var data = dataset.data[index].y;

                        // Draw the data value on top of the bar
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

            // 거래업종 TOP3를 처리
            if (responseData.categoryCntList && responseData.categoryCntList.length >= 3) {
                const categoryDiv = document.querySelector(".category-top");
                categoryDiv.appendChild(document.createElement("br"));
                categoryDiv.appendChild(document.createTextNode("1. " + responseData.categoryCntList[0].categorySmall));
                categoryDiv.appendChild(document.createElement("br"));
                categoryDiv.appendChild(document.createTextNode("2. " + responseData.categoryCntList[1].categorySmall));
                categoryDiv.appendChild(document.createElement("br"));
                categoryDiv.appendChild(document.createTextNode("3. " + responseData.categoryCntList[2].categorySmall));
            }
            // console.log("responseData.timePdf[0]" + responseData.timePdf[0]);
            // console.log("responseData.regionCntList" + responseData.regionCntList[0].regionName);
            // console.log("responseData.regionCntList" + responseData.regionCntList[0].cnt);
            // console.log("responseData.categoryCntList" + responseData.categoryCntList);
            // console.log("responseData.categoryCntList" + responseData.categoryCntList);

            const splitAddress = responseData.address.split(' ');
            const formattedAddress = splitAddress[0] + ' ' + splitAddress[1];

            drawChart('gaussianChart1', responseData.regionPdf[0], responseData.regionPdf[1], responseData.embeddingData.regionNameNumeric, '지역', formattedAddress, responseData.regionFeature);
            drawChart2('gaussianChart2', responseData.timePdf[0], responseData.timePdf[1], responseData.embeddingData.timeNumeric, '시간', responseData.embeddingData.timeNumeric + '시', responseData.timeFeature);
            drawChart3('gaussianChart3', responseData.categorySmallPdf[0], responseData.categorySmallPdf[1], responseData.embeddingData.categorySmallNumeric, '업종', responseData.category, responseData.categoryFeature);
            drawChart1('gaussianChart4', responseData.amountPdf[0], responseData.amountPdf[1], responseData.embeddingData.amountNumeric, '금액', responseData.embeddingData.amountNumeric.toLocaleString() + '원', responseData.amountFeature);
            // drawBubbleChart('bubbleChartRegion', responseData.regionCntList);
            // drawBubbleChart('bubbleChartCategory', responseData.categoryCntList);

            const cardIdElement = document.querySelector('.anomalychart-info .cardId');
            const regionElement = document.querySelector('.info-right .region');
            const timeElement = document.querySelector('.info-right .time');
            const categoryElement = document.querySelector('.info-right .category');
            const amountElement = document.querySelector('.info-right .amount');

            const cardIdValue = cardId+'카드의 '; // responseData.cardId는 실제 데이터로 대체해야 합니다.
            const regionValue = '거래 지역 : ' + formattedAddress; // responseData.embeddingData.region는 실제 데이터로 대체해야 합니다.
            const timeValue = '거래 시간 : ' + responseData.embeddingData.timeNumeric + '시'; // responseData.embeddingData.timeNumeric는 실제 데이터로 대체해야 합니다.
            const categoryValue = '거래 업종 : ' + responseData.category; // responseData.category는 실제 데이터로 대체해야 합니다.
            const amountValue = '거래 금액 : ' + responseData.embeddingData.amountNumeric.toLocaleString() + '원'; // responseData.embeddingData.amountNumeric는 실제 데이터로 대체해야 합니다.

            cardIdElement.textContent = cardIdValue;
            regionElement.textContent = regionValue;
            timeElement.textContent = timeValue;
            categoryElement.textContent = categoryValue;
            amountElement.textContent = amountValue;

            // 모달을 표시합니다.
            modal.style.display = "block";
        },
        error: function (error) {
            console.error('Error:', error);
        }
    });
}

