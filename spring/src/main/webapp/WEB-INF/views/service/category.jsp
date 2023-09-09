<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
    <link href="../../../resources/css/category.css" rel="stylesheet">
</head>
<body>
<%@ include file="../include/header.jsp" %>
<div class="container">
    <div class="main">
        <h1>안심카드설정</h1>
        <h2>대상카드</h2>
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
                결제를 차단할 업종을 선택하세요
            </div>
            <div class="sub-main">
                <div class="sub-main-content1">
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
                <div class="sub-main-content2">
                    <div class="chart" onclick="openChartCategoryModal()">
                        <img src="../../../resources/img/categories.png">
                        <div class="chart-name">업종별 나의 소비 확인</div>
                    </div>
                    <div class="myselect">
                        <div class="myselect-head">선택한 결제 차단업종</div>
                        <div>
                            <span class="myselect-category-no-content"></span><span class="select-alarm"></span>
                        </div>
                    </div>
                </div>
            </div>
            <div class="thissetting-info">
                <%
                    String[] regions = request.getParameterValues("regions");
                    String[] times = request.getParameterValues("times");
                %>
                <c:forEach var="region" items="${regions}">
                    <span>${region}, </span>
                </c:forEach> 지역에서
                <c:forEach var="time" items="${times}">
                    <span>${time}, </span>
                </c:forEach> 시간을 차단합니다.
            </div>
            <div class="reg-btn-div">
                <button class="reg-Btn" onclick="registerCategory()">등록</button>
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
</div>

<script>
    document.getElementById('selectCategoryBig').addEventListener('change', function () {
        updateCategoryChart(this.value);
    });
</script>
</body>
</html>
