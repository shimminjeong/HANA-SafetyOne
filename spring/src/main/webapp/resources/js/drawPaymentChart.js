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


function drawChart(elementId, labels, pdfData, numericData, xAxisLabel, pointData, X_feature) {
    const ctx = document.getElementById(elementId).getContext('2d');

    let bins = 20;
    let histogramData = computeHistogram(X_feature, bins);

    const data = {
        labels: labels,  // 이것은 Gaussian PDF 데이터를 위한 것이므로 그대로 둡니다.
        datasets: [{
            label: 'Gaussian PDF',
            data: pdfData,
            borderColor: 'green',
            borderWidth: 1,
            fill: false
        },
            {
                label: pointData,
                data: [{x: numericData, y: 0}],
                borderColor: 'red',
                borderWidth: 3,
                pointRadius: 6,
                pointHoverRadius: 8,
                showLine: false,
                pointStyle: 'circle'
            }, {
                label: 'Histogram',
                data: histogramData,  // 히스토그램의 데이터는 x, y 쌍으로 반환됩니다.
                type: 'bar',
                backgroundColor: 'blue',
                borderColor: 'blue',
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

    new Chart(ctx, {
        type: 'line',
        data: data,
        options: options
    });
}


function drawChart1(elementId, labels, pdfData, numericData, xAxisLabel, pointData, X_feature) {
    const ctx = document.getElementById(elementId).getContext('2d');

    let bins = 20;
    let histogramData = computeHistogram(X_feature, bins);

    const data = {
        labels: labels,  // 이것은 Gaussian PDF 데이터를 위한 것이므로 그대로 둡니다.
        datasets: [{
            label: 'Gaussian PDF',
            data: pdfData,
            borderColor: 'green',
            borderWidth: 1,
            fill: false
        },
            {
                label: pointData,
                data: [{x: numericData, y: 0}],
                borderColor: 'red',
                borderWidth: 3,
                pointRadius: 6,
                pointHoverRadius: 8,
                showLine: false,
                pointStyle: 'circle'
            }, {
                label: 'Histogram',
                data: histogramData,  // 히스토그램의 데이터는 x, y 쌍으로 반환됩니다.
                type: 'bar',
                backgroundColor: 'blue',
                borderColor: 'blue',
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

    new Chart(ctx, {
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
            drawChart('gaussianChart2', responseData.timePdf[0], responseData.timePdf[1], responseData.embeddingData.timeNumeric, '시간', responseData.embeddingData.timeNumeric + '시', responseData.timeFeature);
            drawChart('gaussianChart3', responseData.categorySmallPdf[0], responseData.categorySmallPdf[1], responseData.embeddingData.categorySmallNumeric, '업종', responseData.category, responseData.categoryFeature);
            drawChart1('gaussianChart4', responseData.amountPdf[0], responseData.amountPdf[1], responseData.embeddingData.amountNumeric, '금액', responseData.embeddingData.amountNumeric.toLocaleString() + '원', responseData.amountFeature);
            // drawBubbleChart('bubbleChartRegion', responseData.regionCntList);
            // drawBubbleChart('bubbleChartCategory', responseData.categoryCntList);

            // 모달을 표시합니다.
            modal.style.display = "block";
        },
        error: function (error) {
            console.error('Error:', error);
        }
    });
}

