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
            <h2><span class="cardId"></span> 거래내역 확률분포 시각화</h2>
        </div>
        <div class="info-div">
            <div class="info-left">
                <div class="anomalychart-info"><span class="cardId"></span> 거래지역, 시간, 업종, 금액에 대한 확률분포를 시각화한 것입니다.</div>
<%--                <div class="anomalychart-info">※ 초록색 그래프는 가우시안 확률분포를 사용하여 추정한 데이터의 확률 분포를 각 feature 별로 시각화한 것 입니다.</div>--%>
<%--                <div class="anomalychart-info">※ 사용자의 각 4개 feature에 대한 거래가 발생할 확률을 이용하여 이상치를 판단할 수 있습니다.</div>--%>
                <div class="anomalychart-info">초록색 그래프는 각 feature에 대한 데이터 분포를 가우시안 확률분포로 추정한 결과입니다.</div>
                <div class="anomalychart-info">※ 각 4개 feature에 대한 거래가 발생할 확률을 이용하여 이상치를 판단할 수 있습니다.</div>
<%--                초록색 그래프는 가우시안 확률분포를 통해 데이터의 분포를 추정한 것이며, 이를 통해 각 feature의 거래 발생 확률을 기반으로 이상치를 판단하실 수 있습니다."--%>
            </div>
            <div class="info-right">
                <div class="region"></div>
                <div class="time"></div>
                <div class="category"></div>
                <div class="amount"></div>
            </div>
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