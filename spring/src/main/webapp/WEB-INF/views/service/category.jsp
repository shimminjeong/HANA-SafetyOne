<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <%--    <link href="../../../resources/css/regionspot.css" rel="stylesheet">--%>
    <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/chart.js/dist/Chart.js"></script>
    <link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
    <script src="../../../resources/js/category.js" type="text/javascript"></script>
    <link href="../../../resources/css/safetyCardCommon.css" rel="stylesheet">
    <%--    <link href="../../../resources/css/category.css" rel="stylesheet">--%>
    <link href="../../../resources/css/region.css" rel="stylesheet">
</head>
<body>
<%@ include file="../include/header.jsp" %>
<div class="big-header" style="margin-left: 585px;">안심서비스 설정</div>
<div class="big-container">
    <div class="details__left">
        <ul class="menu">
            <li class="menu__item">
                <a href="/mypage" class="menu__link">
                    STEP1 지역
                </a>
            </li>
            <li class="menu__item">
                <a href="/mypageCardHistory" class="menu__link">
                    STEP2 시간
                </a>
            </li>
            <li class="menu__item" style="background-color:#e1f1ff;">
                <a href="/mypageReport" class="menu__link">
                    STEP3 업종
                </a>
            </li>
        </ul>
    </div>
    <div class="details">
        <div class="category-subcontainer">
            <div class="detail__right">
                <div class="right-info"><h2><span style="color:red;">차단</span> 업종 선택</h2></div>
                <div class="right-info2"><h4></h4>
                    <button class="chart-name" onclick="openChartCategoryModal()">업종별 나의 소비 확인</button>
                </div>
                <div class="right-info3">※ 붉은색으로 표시된 업종에 마우스를 올리면 추천 차단 항목을 볼 수 있습니다.</div>
                <div class="right-subcontainer">
                    <div class="grid-container">
                        <c:set var="imgList"
                               value="${['fashion.png', 'laundry-shop.png','cosmetics.png','sports.png','restaurant.png','butcher-shop.png',
                               'electronics.png', 'world.png', 'education.png','hospital.png',  'shopping-cart.png',   'oilstation.png']}"/>
                        <%--                        <c:forEach var="entry" items="${categoryMap}" varStatus="loop">--%>
                        <%--                            <div class="grid-item"--%>
                        <%--                                 style="${bigCategoryList.contains(entry.key) ? 'background-color: #ffe6e6;' : ''}">--%>
                        <%--                                <c:set var="imgIndex" value="${loop.index % imgList.size()}"/>--%>
                        <%--                                <c:set var="imageName" value="${imgList[imgIndex]}"/>--%>
                        <%--                                <img class="grid-image" onclick="handleClickBig('${entry.key}')"--%>
                        <%--                                     src="../../../resources/img/${imageName}" alt="${entry.key}">--%>
                        <%--                                <div class="item-name">${entry.key}</div>--%>
                        <%--                                <div class="dropdown-list">--%>
                        <%--                                    <div class="dropdown-menu" aria-labelledby="dropdownMenuButton">--%>
                        <%--                                        <c:forEach var="category" items="${entry.value}">--%>
                        <%--                                            <a class="dropdown-item"--%>
                        <%--                                               onclick="handleClick('${category.categorySmall}')">${category.categorySmall}</a>--%>
                        <%--                                        </c:forEach>--%>
                        <%--                                    </div>--%>
                        <%--                                </div>--%>
                        <%--                            </div>--%>
                        <%--                        </c:forEach>--%>
                        <c:forEach var="entry" items="${categoryMap}" varStatus="loop">
                            <div class="grid-item"
                                 style="${bigCategoryList.contains(entry.key) ? 'background-color: #ffe6e6;' : ''}">
                                <c:set var="imgIndex" value="${loop.index % imgList.size()}"/>
                                <c:set var="imageName" value="${imgList[imgIndex]}"/>
                                <img class="grid-image" onclick="handleClickBig('${entry.key}')"
                                     src="../../../resources/img/${imageName}" alt="${entry.key}">
                                <div class="item-name">${entry.key}</div>
                                <div class="dropdown-list">
                                    <div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
                                        <c:forEach var="category" items="${entry.value}">
                                            <a class="dropdown-item"
                                               style="${smallCategoryList.contains(category.categorySmall) ? 'color: red;' : ''}"
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
                        <br>
                        <br>
                        <span class="myselect-category-no-content"></span><span class="select-alarm"></span>
                    </div>

                </c:if>

            </div>
        </div>
        <div class="btn-div">
            <button class="prev-Btn" onclick="window.location.href='#'">이전</button>
            <button class="next-Btn" onclick="registerCategory()">다음</button>
        </div>
    </div>
</div>
<div class="modal">
    <div id="myCategorymodal">
        <span class="close-btn" onclick="closeChartCategoryModal()">&#10006;</span>
        <div class="chart-head">최근 3개월 업종별 이용 빈도</div>
        <select id="selectCategoryBig" class="limited-options">
            <c:forEach var="entry" items="${categoryBigList}">
                <option name="${entry}">${entry}</option>
            </c:forEach>
        </select>
        <div class="chart-div">
            <canvas id="myCategoryCntChart"></canvas>
        </div>
        <div class="chart-info1"><span class="recomend">
            주 이용 업종 : <c:forEach var="category" items="${categoryTopList}"
                                                                   varStatus="status">
             <c:if test="${status.index < 3}">
                ${category.categorySmall}
                <c:if test="${status.index + 1 != 3}">,</c:if>
            </c:if>
        </c:forEach></span>
        </div>
        <div class="chart-info2"><span class="recomend-bottom">이용하지 않은 업종 : <c:forEach var="category" items="${categoryAllList}"
                                                                          varStatus="status">
            <c:if test="${status.index < 3}">
                <span style="color:#d45151;">${category}</span>
                <c:if test="${status.index + 1 != 3}">,</c:if>
            </c:if>
        </c:forEach>
        </div>
    </div>
</div>

<script>
    document.getElementById('selectCategoryBig').addEventListener('change', function () {
        updateCategoryChart(this.value);
    });
</script>
</body>
</html>

