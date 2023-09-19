<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Document</title>
    <link rel="stylesheet" href="../../../resources/css/admin/adminCommon.css"/>
    <link rel="stylesheet" href="../../../resources/css/admin/adminFds.css"/>
    <link rel="stylesheet" href="../../../resources/css/admin/adminFdsData.css"/>
    <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

</head>
<body>
<jsp:include page="adminHeader.jsp"/>
<hr>
<div class="details">
    <jsp:include page="adminSideBar.jsp"/>
    <div class="detail__right">
        <h2 class="details____title">이상소비서비스관리</h2>
        <div class="box-container">
            <div class="info-box" onclick="window.location.href='/admin/fds'">
                <div class="info-content">서비스사용자관리</div>
            </div>
            <div class="info-box" onclick="window.location.href='/admin/fdsData'">
                <div class="info-content">이상소비데이터관리</div>
            </div>
        </div>

        <div class="table-container">
            <h3>신규 신청</h3>
            <br>
            <!-- 테이블로 데이터베이스 데이터 표시 -->
            <span>*학습시작 버튼을 누르고 학습이 완료된 후 해당 고객은 서비스를 이용할 수 있습니다.</span>
            <table class="data-table">
                <thead>
                <tr>
                    <th>카드번호</th>
                    <th>거래일자</th>
                    <th>가맹점주소</th>
                    <th>업종</th>
                    <th>거래가격</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${anomalyList}" var="anomalydata">
                    <tr onclick="showAnomalyDetails(${anomalydata.paymentLogId}, '${anomalydata.cardId}');"
                        style="cursor: pointer;">
                        <td>${anomalydata.cardId}</td>
                        <td>${anomalydata.paymentDate}</td>
                        <td>${anomalydata.address}</td>
                        <td>${anomalydata.categorySmall}</td>
                        <td>${anomalydata.amount}</td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</div>
<!-- The Modal -->
<div id="chartModal" class="modal">
    <div class="modal-content">
        <div class="modal-header">
            <span class="close">&times;</span>
            <h2>Anomaly Details</h2>
        </div>
        <div class="modal-body">
            <div class="canvas-div1">
                <div class="chart-head">지역</div>
                <div class="chart-content">
                    <canvas id="gaussianChart1"></canvas>
                    <canvas id="bubbleChartRegion"></canvas>
                </div>
                <div class="chart-head">시간</div>
                <div class="chart-content">
                    <canvas id="gaussianChart2"></canvas>
                </div>

                <%--            <div class="canvas-div2">--%>
                <div class="chart-head">업종</div>
                <div class="chart-content">
                    <canvas id="gaussianChart3"></canvas>
                    <canvas id="bubbleChartCategory"></canvas>
                </div>
                <div class="chart-head">금액</div>
                <div class="chart-content">
                    <canvas id="gaussianChart4"></canvas>
                </div>
            </div>
            <%--            </div>--%>
        </div>
    </div>
</div>


<script>

    function createBubbleCloudData(dataList) {
        let colors = [
            {
                background: 'rgba(255, 99, 132, 0.2)',
                border: 'rgba(255, 99, 132, 1)',
                hoverBg: 'rgba(255, 99, 132, 0.4)',
                hoverBorder: 'rgba(255, 99, 132, 1)'
            },
            {
                background: 'rgba(54, 162, 235, 0.2)',
                border: 'rgba(54, 162, 235, 1)',
                hoverBg: 'rgba(54, 162, 235, 0.4)',
                hoverBorder: 'rgba(54, 162, 235, 1)'
            },
            {
                background: 'rgba(255, 206, 86, 0.2)',
                border: 'rgba(255, 206, 86, 1)',
                hoverBg: 'rgba(255, 206, 86, 0.4)',
                hoverBorder: 'rgba(255, 206, 86, 1)'
            }
        ];

        return dataList.map((data, index) => {
            let color = colors[index % colors.length];
            let label = data.regionName || data.categorySmall || 'Unknown';  // regionName 또는 category 중 존재하는 값을 사용하거나 둘 다 없으면 'Unknown'을 사용

            return {
                label: label,
                data: [
                    {
                        x: Math.random() * 100,
                        y: Math.random() * 100,
                        r: data.cnt * 0.4
                    }
                ],
                backgroundColor: color.background,
                borderColor: color.border,
                borderWidth: 2,
                hoverBackgroundColor: color.hoverBg,
                hoverBorderColor: color.hoverBorder
            };
        });
    }

    function drawBubbleChart(elementId, dataList) {
        const ctx = document.getElementById(elementId).getContext('2d');

        const datasets = createBubbleCloudData(dataList);

        const data = {
            datasets: datasets
        };

        const options = {
            scales: {
                x: {display: false},
                y: {display: false}
            },
            plugins: {
                legend: {
                    display: true
                }
            }
        };

        new Chart(ctx, {
            type: 'bubble',
            data: data,
            options: options
        });
    }


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
                console.log("responseData.timePdf[0]" + responseData.timePdf[0]);
                console.log("responseData.regionCntList" + responseData.regionCntList[0].regionName);
                console.log("responseData.regionCntList" + responseData.regionCntList[0].cnt);
                console.log("responseData.categoryCntList" + responseData.categoryCntList);
                console.log("responseData.categoryCntList" + responseData.categoryCntList);
                drawChart('gaussianChart1', responseData.regionPdf[0], responseData.regionPdf[1], responseData.embeddingData.regionNameNumeric, '지역', responseData.address, responseData.regionFeature);
                drawChart('gaussianChart2', responseData.timePdf[0], responseData.timePdf[1], responseData.embeddingData.timeNumeric, '시간', responseData.embeddingData.timeNumeric, responseData.timeFeature);
                drawChart('gaussianChart3', responseData.categorySmallPdf[0], responseData.categorySmallPdf[1], responseData.embeddingData.categorySmallNumeric, '업종', responseData.category, responseData.categoryFeature);
                drawChart('gaussianChart4', responseData.amountPdf[0], responseData.amountPdf[1], responseData.embeddingData.amountNumeric, '금액', responseData.embeddingData.amountNumeric, responseData.amountFeature);
                drawBubbleChart('bubbleChartRegion', responseData.regionCntList);
                drawBubbleChart('bubbleChartCategory', responseData.categoryCntList);

                // 모달을 표시합니다.
                modal.style.display = "block";
            },
            error: function (error) {
                console.error('Error:', error);
            }
        });
    }

    // Get the modal
    var modal = document.getElementById("chartModal");

    // Get the <span> element that closes the modal
    var span = document.getElementsByClassName("close")[0];

    // When the user clicks on <span> (x), close the modal
    span.onclick = function () {
        modal.style.display = "none";
    }

    // Whenever you want to show the modal:
    // modal.style.display = "block";


</script>
</body>
</html>
