<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/chart.js@3.5.1/dist/chart.min.js"></script>
    <link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
    <script src="../../../resources/js/time.js" type="text/javascript"></script>
    <link href="../../../resources/css/safetyCardCommon.css" rel="stylesheet">
    <link href="../../../resources/css/region.css" rel="stylesheet">
</head>
<body>
<%@ include file="../include/header.jsp" %>
<div class="big-header" style="margin-left: 585px;">안심서비스 설정</div>
<div class="time-big-container">
    <div class="details__left">
        <ul class="menu">
            <li class="menu__item">
                <a href="/mypage" class="menu__link">
                    STEP1 지역
                </a>
            </li>
            <li class="menu__item" style="background-color:#c7dbec;">
                <a href="/mypageCardHistory" class="menu__link">
                    STEP2 시간
                </a>
            </li>
            <li class="menu__item">
                <a href="/mypageReport" class="menu__link">
                    STEP3 업종
                </a>
            </li>
        </ul>
    </div>
    <div class="details">
        <div class="subcontainer">
            <div class="detail__right">
                <div class="right-info"><h2><span style="color:red;">차단</span> 시간 선택</h2></div>
                <div class="right-info2"><h4></h4>
                    <button class="chart-name" onclick="openChartTimeModal()">시간별 나의 소비 확인</button>
                </div>
                <%--            <div class="right-info3" style="color: red">※ 거래하지 않는 시간을 지정하여 금융사고를 예방하는 서비스입니다.</div>--%>

                <div class="time-subcontainer">
                    <div class="clock-div">
                        <img src="../../../resources/img/safetyTime.jpg">
                    </div>

                    <div class="time-select">
                        <div class="time-choose">
                            <select id="startHour" style="margin-right: 2%"></select>
                            <p style="margin-right: 5%"> 시 </p>
                            <p style="margin-right: 5%"> ~ </p>
                            <select id="endHour" style="margin-right: 2%" onchange="updateTime()"></select>
                            <p> 시 </p>
                        </div>
                    </div>

                </div>
                <%
                    String[] regions = request.getParameterValues("regions");
                    System.out.println("regions" + regions);
                %>
                <c:if test="${empty regions}">
                    <div class="myselect-option">
                        <span class="myselect-time-no-content"></span><span class="select-alarm"></span>
                    </div>
                </c:if>
                <c:if test="${not empty regions}">
                    <div class="myselect-option">
                        <c:forEach var="region" items="${regions}" varStatus="loop">
                            <span><strong>${region}</strong></span><c:if
                                test="${loop.index +1 < fn:length(regions)}"><strong>,</strong></c:if>
                        </c:forEach>에서
                        <br>
                        <br>
                        <span class="myselect-time-no-content" style="display: inline;"></span><span style="display: inline;"class="select-alarm"></span>
                    </div>
                </c:if>
            </div>
        </div>
        <div class="btn-div">
            <button class="prev-Btn" onclick="registerTime()">이전</button>
            <button class="next-Btn" onclick="registerTime()">다음</button>
        </div>
    </div>
</div>
<div class="modal">
    <div id="myTimemodal">
        <span class="close-btn" onclick="closeChartTimeModal()">&#10006;</span>
        <div class="chart-head">최근 3개월 시간별 이용 빈도</div>
        <div class="chart-div">
            <canvas id="myTimeCntChart"></canvas>
        </div>
        <div class="chart-info1">높은 빈도의 거래 시간 : <span class="recomend"></span></div>
        <div class="chart-info2">낮은 빈도의 이용 시간 : <span class="recomend-bottom"></span></div>
    </div>
</div>

</body>
</html>
