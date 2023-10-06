<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <link rel="stylesheet" href="../../../resources/css/admin/drawPaymentChart.css"/>
    <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <script src="../../../resources/js/drawPaymentChart.js" type="text/javascript"></script>
</head>
<body>
<div id="chartModal" class="modal">
    <div class="modal-content">
        <div class="modal-header">
            <span class="close">&times;</span>
            <h2>Anomaly Details</h2>
        </div>
        <div class="outer-container">
            <%--            <div class="canvas-div1">--%>
            <div class="region-div">
                <div class="chart-head">지역</div>
                <div class="detail-content">
                    <div class="chart-content">
                        <canvas id="gaussianChart1"></canvas>
                        <%--                    <canvas id="bubbleChartRegion"></canvas>--%>
                    </div>
                    <div class="region-top"><p style="font-size: 14px; margin-bottom: 0px;">거래지역 TOP3</p></div>
                </div>
            </div>
            <div class="time-div">
                <div class="chart-head">시간</div>
                <div class="chart-content">
                    <canvas id="gaussianChart2"></canvas>
                </div>
            </div>

            <%--            <div class="canvas-div2">--%>
            <div class="category-div">
                <div class="chart-head">업종</div>
                <div class="detail-content">
                    <div class="chart-content">
                        <canvas id="gaussianChart3"></canvas>
                        <%--                    <canvas id="bubbleChartCategory"></canvas>--%>
                    </div>
                    <div class="category-top"><p style="font-size: 14px; margin-bottom: 0px;">거래업종 TOP3</p></div>
                </div>
            </div>
            <div class="price-div">
                <div class="chart-head">금액</div>
                <div class="chart-content">
                    <canvas id="gaussianChart4"></canvas>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>