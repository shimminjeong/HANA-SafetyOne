<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <%--    <link href="../../../resources/css/regionspot.css" rel="stylesheet">--%>
    <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/chart.js@3.5.1/dist/chart.min.js"></script>
    <link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
    <script src="../../../resources/js/category.js" type="text/javascript"></script>
    <link href="../../../resources/css/safetyCardCommon.css" rel="stylesheet">
    <%--    <link href="../../../resources/css/category.css" rel="stylesheet">--%>
    <link href="../../../resources/css/region.css" rel="stylesheet">
</head>
<body>
<%@ include file="../include/header.jsp" %>
<div class="details">
    <h2>안심카드설정</h2>
    <h3>대상카드</h3>
    <div class="lostcard-list hidden">
        <div class="card-list-info">
            <div class="card-list-info-cardid"><%=session.getAttribute("cardId")%>
            </div>
            <div class="card-list-info-name">본인 | &nbsp;
            </div>
            <div class="card-list-info-cardname"><%=session.getAttribute("cardName")%>
            </div>
            <img class="card-img" src="../../../resources/img/cardImg${loop.index + 1}.png">
        </div>
    </div>
    <div class="subcontainer">
        <div class="details__left">
            <ul class="menu">
                <li class="menu__item">
                    <a href="/mypage" class="menu__link">
                        <div class="menu__icon"><img src="../../../resources/img/pin.png"></div>
                        위치
                    </a>
                </li>
                <li class="menu__item">
                    <a href="/mypageCardHistory" class="menu__link">
                        <div class="menu__icon"><img src="../../../resources/img/clock1.png"></div>
                        시간
                    </a>
                </li>
                <li class="menu__item">
                    <a href="/mypageReport" class="menu__link">
                        <div class="menu__icon"><img src="../../../resources/img/categories.png"></div>
                        업종
                    </a>
                </li>
            </ul>
        </div>
        <div class="detail__right">
            <div class="right-info"><h2>업종안심</h2></div>
            <div class="right-info2"><h3>차단업종 선택</h3>
                <div class="chart-name" onclick="openChartCategoryModal()">업종별 나의 소비 확인 ></div>
            </div>
            <div class="right-info3" style="color: red">※ 거래하지 않는 업종을 지정하여 금융사고를 예방하는 서비스입니다.</div>
            <div class="right-subcontainer">
                <div class="grid-container">
                    <c:set var="imgList"
                           value="${['restaurant.png', 'shopping-cart.png', 'butcher-shop.png', 'fashion.png', 'sports.png', 'world.png', 'cosmetics.png', 'laundry-shop.png', 'education.png', 'hospital.png', 'electronics.png', 'taxi.png', 'oilstation.png']}"/>
                    <c:forEach var="entry" items="${categoryMap}" varStatus="loop">
                        <div class="grid-item">
                            <c:set var="imgIndex" value="${loop.index % imgList.size()}"/>
                            <c:set var="imageName" value="${imgList[imgIndex]}"/>
                            <img class="grid-image" onclick="handleClickBig('${entry.key}')"
                                 src="../../../resources/img/${imageName}" alt="${entry.key}">
                            <div class="item-name">${entry.key}</div>
                            <div class="dropdown-list">
                                <div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
                                    <c:forEach var="category" items="${entry.value}">
                                        <a class="dropdown-item"
                                           onclick="handleClick('${category.categorySmall}')">${category.categorySmall}</a>
                                    </c:forEach>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>

            <%
                String[] regions = request.getParameterValues("regions");
                String[] times = request.getParameterValues("times");
            %>
            <c:if test="${empty regions && empty times}">

                <div class="myselect-option">
                    <span class="myselect-category-no-content"></span><span class="select-alarm"></span>
                </div>

            </c:if>

            <c:if test="${not empty regions || not empty times}">
                <div class="myselect-option">
                    <c:choose>
                        <c:when test="${not empty regions && not empty times}">
                            <c:forEach var="region" items="${regions}" varStatus="loop">
                                <span><strong>${region}</strong></span>
                                <c:if test="${loop.index+1 < fn:length(regions)}">
                                    <span><strong>,</strong></span>
                                </c:if>
                            </c:forEach> 에서
                            <c:forEach var="time" items="${times}" varStatus="loop">
                                <span><strong>${time}</strong></span>
                                <c:if test="${loop.index+1 < fn:length(times)}">
                                    <span><strong>,</strong></span>
                                </c:if>
                            </c:forEach> 까지
                        </c:when>
                        <c:when test="${empty regions && not empty times}">
                            <strong>모든 지역</strong>에서
                            <c:forEach var="time" items="${times}" varStatus="loop">
                                <span><strong>${time}</strong></span>
                                <c:if test="${loop.index+1 < fn:length(times)}">
                                    <span><strong>,</strong></span>
                                </c:if>
                            </c:forEach> 까지
                        </c:when>
                        <c:when test="${not empty regions && empty times}">
                            <c:forEach var="region" items="${regions}" varStatus="loop">
                                <span><strong>${region}</strong></span>
                                <c:if test="${loop.index+1 < fn:length(regions)}">
                                    <span><strong>,</strong></span>
                                </c:if>
                            </c:forEach> 에서
                        </c:when>
                    </c:choose>
                    <span class="myselect-category-no-content"></span><span class="select-alarm"></span>
                </div>
            </c:if>
            <div class="reg-btn-div">
                <button class="next-Btn" onclick="registerCategory()">다음</button>
            </div>
        </div>
    </div>
</div>
<div class="modal">
    <div id="myCategorymodal">
        <div class="chart-head">최근 3개월간 나의 소비</div>
        <select id="selectCategoryBig" class="limited-options">
            <c:forEach var="entry" items="${categoryBigList}">
                <option name="${entry}">${entry}</option>
            </c:forEach>
        </select>
        <canvas id="myCategoryCntChart"></canvas>
        <span class="close" onclick="closeChartCategoryModal()">&times;</span>
    </div>
</div>

<script>
    document.getElementById('selectCategoryBig').addEventListener('change', function () {
        updateCategoryChart(this.value);
    });
</script>
</body>
</html>

