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
    <link href="../../../resources/css/time.css" rel="stylesheet">
</head>
<body>
<%@ include file="../include/header.jsp" %>
<div class="container">
    <div class="main">
        <h2>안심카드설정</h2>
        <h3>대상카드</h3>
        <hr>
        <div class="card-info">
            <div class="card-details">
                <span>본인 | </span>
                <span><%=session.getAttribute("cardId")%></span>
            </div>
            <div class="card-type">
                <span>알뜰교통 S20(체크)</span>
            </div>
        </div>
        <div class="sub-container">
            <div class="sub-info">
                결제를 차단할 시간을 선택하세요
            </div>
            <div class="sub-main">
                <div class="sub-main-content1">
                    <div class="time-select">
                        <button class="time-range" onclick="handleTimeRangeClick(this)">00시 ~ 04시</button>
                        <button class="time-range" onclick="handleTimeRangeClick(this)">05시 ~ 09시</button>
                        <button class="time-range" onclick="handleTimeRangeClick(this)">10시 ~ 14시</button>
                        <button class="time-range" onclick="handleTimeRangeClick(this)">15시 ~ 19시</button>
                        <button class="time-range" onclick="handleTimeRangeClick(this)">19시 ~ 23시</button>
                        <div style="font-size: 20px; margin-top: 20px">직접선택</div>
                        <div class="time-choose">
                            <select id="startHour"></select>
                            <p><strong> 시 </strong></p>
                            <p><strong> ~ </strong></p>
                            <select id="endHour" onchange="updateTime()"></select>
                            <p><strong> 시 </strong></p>
                        </div>
                    </div>
                </div>
                <div class="sub-main-content2">
                    <div class="chart" onclick="openChartTimeModal()">
                        <img src="../../../resources/img/clock1.png">
                        <div class="chart-name">시간별 나의 소비 확인</div>
                    </div>
                    <%
                        String[] regions = request.getParameterValues("regions");
                        System.out.println("regions" + regions);
                    %>
                    <c:if test="${empty regions}">
                        <div class="myselect">
                            <div class="myselect-head">선택한 결제 차단시간</div>
                            <div>
                                <span class="myselect-time-no-content"></span><span class="select-alarm"></span>
                            </div>
                        </div>
                    </c:if>
                </div>
            </div>
            <c:if test="${not empty regions}">
                <div class="thissetting-info">
                    <div class="thissetting-head">현재까지 조합된 나만의 rule</div>
                    <div class="thissetting-content">
                        <c:forEach var="region" items="${regions}" varStatus="loop">
                            <span><strong>${region}</strong></span>
                            <c:if test="${loop.index +1 < fn:length(regions)}">
                                <span><strong>,</strong></span>
                            </c:if>
                        </c:forEach>에서 <span class="myselect-time-no-content"></span><span class="select-alarm"></span>
                    </div>
                </div>
            </c:if>
            <div class="reg-btn-div">
                <button class="reg-Btn" onclick="registerTime()">등록</button>
            </div>
        </div>
    </div>

    <div class="modal">
        <div id="myTimemodal">
            <div class="chart-head">최근 3개월간 나의 소비</div>
            <canvas id="myTimeCntChart"></canvas>
            <span class="close" onclick="closeChartTimeModal()">&times;</span>
        </div>
    </div>
</div>

</body>
</html>
