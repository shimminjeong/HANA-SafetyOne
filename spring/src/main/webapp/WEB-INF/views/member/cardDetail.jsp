<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html>
<head>
    <title>Document</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <link href="../../../resources/css/common.css" rel="stylesheet">
    <link href="../../../resources/css/admin/adminCommon.css" rel="stylesheet">
    <link href="../../../resources/css/member/mypage.css" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
    <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/chart.js@3.5.1/dist/chart.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

</head>
<style>
    .chart-row1{
        display: flex;
        flex-direction: row;
    }
</style>
<body>
<%@ include file="../include/header.jsp" %>
<div class="details">
    <div class="details__left">
        <ul class="menu">
            <li class="menu__item">
                <a href="/admin/safetyCard" class="menu__link">
                    <div class="menu__icon"><img src="../../../resources/img/bell%20(1).png"></div>
                    나의 소비 관리
                </a>
            </li>
            <li class="menu__item">
                <a href="/admin/fds" class="menu__link">
                    <div class="menu__icon"><img src="../../../resources/img/bell%20(1).png"></div>
                    서비스 이용현황
                </a>
            </li>
        </ul>
    </div>
    <div class="detail__right">
        <div class="sub-container">
            <div class="chart-row1">
                <div class="month">
                    <div class="chart-info">최근 6개월간 지출</div>
                    <canvas id="monthChart"></canvas>
                </div>
                <div class="week">
                    <div class="chart-info">최근 1주일간 지출</div>
                    <canvas id="week"></canvas>
                </div>
            </div>
            <div class="chart-row2">
                <div class="month"></div>
                <div class="month"></div>
            </div>
        </div>
    </div>
</div>
<script>

    var monthChartData = ${cardData.monthData};  // JSP EL을 통해 데이터를 JavaScript 변수에 할당
    var weekChartData = ${cardData.weekData};

    $("#monthChart").replaceWith('<canvas id="monthChart"></canvas>');


    // 전역 변수로 차트 선언
    var ctx = document.getElementById('monthChart').getContext('2d');

    var monthChartData = JSON.parse('${fn:escapeXml(cardData.monthData)}');
    var weekChartData = JSON.parse('${fn:escapeXml(cardData.weekData)}');

    var months = monthChartData.map(item => item.month);
    var amountSums = monthChartData.map(item => item.amountSum);

    var monChart = new Chart(ctx, {
        type: 'bar',
        data: {
            labels: months,
            datasets: [{
                label: 'Amount Sum',
                data: amountSums,
                backgroundColor: 'rgba(75, 192, 192, 0.2)', // 배경색
                borderColor: 'rgba(75, 192, 192, 1)', // 테두리 색
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
</script>
</body>
</html>
