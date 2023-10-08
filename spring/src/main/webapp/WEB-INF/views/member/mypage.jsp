<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<html>
<head>
    <title>Document</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<%--    <link href="../../../resources/css/admin/adminCommon.css" rel="stylesheet">--%>
    <link href="../../../resources/css/member/mypage.css" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/chart.js/dist/Chart.js"></script>
    <script src="../../../resources/js/mypage.js" type="text/javascript"></script>

</head>

<body>
<%@ include file="../include/header.jsp" %>
<div class="details">
    <%@ include file="../include/mypageSideBar.jsp" %>
    <hr style="border:1px solid #00857F; margin:0px;">
    <div class="detail__right">
        <div class="sub-container">
            <span class="user-info">
                <span class="hello"><%= name %>님 안녕하세요!!</span>
                <button class="myinfo-button">내정보관리</button>
            </span>
            <div class="cardId-info">
                <div class="allow-img-prev"><a class="prev" onclick="plusSlides(-1)">
                    <img src="../../../resources/img/previous.png" alt="Previous Slide">
                </a>
                </div>
                <div class="slideshow-container">
                    <c:forEach items="${cards}" var="card" varStatus="loop">
                        <div class="mySlides fade">
                            <img src="../../resources/img/${card.cardName}.png"
                                 onclick="openChartCardDetailModal(this.getAttribute('data-card-id'))"
                                 data-card-id="${card.cardId}">
                            <div style="display: none" class="cardIdtext">${card.cardId}</div>
                        </div>
                    </c:forEach>
                </div>
                <div class="cardId-info-sub">
                    <div class="cardId-info-name"></div>
                    <div class="cardId-info-sub-stats">
                        <div class="total-amount">총 거래금액<br><br><div style="text-align: right" id="totalAmount"></div></div>
                        <div class="total-cnt">총 거래건수<br><br><div style="text-align: right" id="totalCnt"></div></div>
                    </div>
                </div>
                <div class="cardId-serviceStatus">
                    <div class="safety" id="safety-yes">안심카드 이용현황</div>
                    <div class="no" id="safety-no">안심카드 서비스 신청</div>
                    <div class="fds" id="fds-yes">이상소비 이용현황</div>
                    <div class="no" id="fds-no">이상소비알림 신청</div>
                </div>
                <div class="allow-img-next"><a class="next" onclick="plusSlides(1)">
                    <img src="../../../resources/img/next.png" alt="Next Slide">
                </a>
                </div>
            </div>
            <div class="cardTotal-info">
                <div class="cardTotal-info-div1">
                    <div class="cardTotal-info-div-header"> 최근이용내역 ></div>
                    <c:forEach items="${cardHistoryList}" var="cardHistory" varStatus="loop">
                        <c:if test="${loop.index < 3}">
                            <div class="item">
                                <div class="left">
                                    <div class="store-name">${cardHistory.store}</div>
                                    <div class="date">${fn:substring(cardHistory.cardHisDate, 0, 16)}</div>
                                </div>
                                <div class="right"><fmt:formatNumber value="${cardHistory.amount}" type="currency"
                                                                     currencySymbol="" groupingUsed="true"/>원
                                </div>
                                <div class="clear"></div>
                            </div>
                            <c:if test="${loop.index != 2}">
                                <hr>
                            </c:if>
                        </c:if>
                    </c:forEach>
                </div>
                <div class="cardTotal-info-div2">
                    <div class="cardTotal-info-div-header">카테고리별 사용 금액 TOP5 </div>
                    <div class="cardTotal-info-div-chart">
                        <canvas id="myPieChart"></canvas>
                    </div>
                </div>
                <div class="cardTotal-info-div3">
                    <div class="cardTotal-info-div-header">사용처별 이용 횟수 TOP5</div>
                    <div>
                        <c:forEach var="item" items="${storeCntList}" begin="0" end="4" varStatus="status">
                            <div class="name-left" style="margin-bottom: 10px;">
                                <span>${status.index + 1}&nbsp;&nbsp;</span>
                                <span> ${item.store}</span>

                            </div>
                            <div class="name-right">${item.categoryCnt}회
                            </div>
                        </c:forEach>
                    </div>
                </div>
            </div>
        </div>

    </div>
</div>
<script>
    let slideIndex = 1;
    showSlides(slideIndex);

    let labels = [];
    let data = [];

    <c:forEach var="item" items="${categoryTopList}" varStatus="loop">
    <c:if test="${loop.index < 5}">
    labels.push("${item.categorySmall}");
    data.push(${item.amountSum});
    </c:if>
    </c:forEach>


    var ctx = document.getElementById('myPieChart').getContext('2d');
    var myPieChart = new Chart(ctx, {
        type: 'pie',
        data: {
            labels: labels,
            datasets: [{
                data: data,
                backgroundColor: [
                    'rgb(255, 99, 132)',   // 진한 붉은색
                    'rgb(54, 162, 235)',   // 진한 파란색
                    'rgb(255, 206, 86)',   // 진한 노란색
                    'rgb(75, 192, 192)',   // 진한 청록색
                    'rgb(153, 102, 255)',  // 진한 보라색
                ]
            }]
        },
        options: {
            legend: {
                position: 'right'
            }
        }
    });



</script>
</body>
</html>
