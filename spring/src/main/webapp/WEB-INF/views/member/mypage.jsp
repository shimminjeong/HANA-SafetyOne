<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<html>
<head>
    <title>Document</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <link href="../../../resources/css/admin/adminCommon.css" rel="stylesheet">
    <link href="../../../resources/css/member/mypage.css" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/chart.js/dist/Chart.js"></script>
    <script src="../../../resources/js/mypage.js" type="text/javascript"></script>

</head>

<body>
<%@ include file="../include/header.jsp" %>
<div class="details">
    <%@ include file="../include/mypageSideBar.jsp" %>
    <hr style="border:1px solid #00857F">
    <div class="detail__right">
        <div class="sub-container">
            <span class="user-info">
                <span class="hello"><%= name %>님 안녕하세요!!</span>
                <button class="myinfo-button"> > 내정보관리</button>
            </span>
            <div class="cardId-info">
                <div class="allow-img-prev"><a class="prev" onclick="plusSlides(-1)">
                    <img src="../../../resources/img/previous.png" alt="Previous Slide">
                </a>
                </div>
                <div class="slideshow-container">
                    <c:forEach items="${cards}" var="card" varStatus="loop">
                        <div class="mySlides fade">
                            <img src="../../resources/img/cardImg${loop.index + 1}.png"
                                 onclick="openChartCardDetailModal(this.getAttribute('data-card-id'))"
                                 data-card-id="${card.cardId}">
                            <div style="display: none" class="cardIdtext">${card.cardId}</div>
                        </div>
                    </c:forEach>
                </div>
                <div class="cardId-info-sub">
                    <div class="cardId-info-name"></div>
                    <div class="cardId-info-sub-stats">
                        <div class="total-amount">총 거래금액<br><br><span id="totalAmount"></span></div>
                        <div class="total-cnt">총거래건수<br><br><span id="totalCnt"></span></div>
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
                    <div class="cardTotal-info-div-header">이번달 TOP5 카테고리</div>
                    <div class="cardTotal-info-div-chart">
                        <canvas id="myPieChart"></canvas>
                    </div>
                </div>
                <div class="cardTotal-info-div3">
                    <div class="cardTotal-info-div-header">이번달 과소비한 영역은 어디?</div>
                    <div class=""></div>
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
                    '#FF6B6B', '#4ECDC4', '#F7FFF7', '#FFE66D', '#1A535C'
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
