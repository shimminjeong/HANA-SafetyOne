<%@ page import="java.util.List" %>
<%@ page import="java.util.Arrays" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Title</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <link href="../../../resources/css/common.css" rel="stylesheet">
    <link href="../../../resources/css/service.css" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/chart.js@3.5.1/dist/chart.min.js"></script>
</head>
<style>


    .grid-container {
        margin:30px;
        display: grid;
        grid-template-columns: repeat(7, 80px); /* 2열로 반복 */
        /*grid-gap: 10px; !* 박스 사이의 간격 설정 *!*/
        align-items: center; /* 내용 수직 가운데 정렬 */
        text-align: center; /* 내용 가로 가운데 정렬 */

    }


    .grid-item {
        display: flex;
        flex-direction: column;
        border: 1px solid black;
        padding: 10px 5px;
        height: 80px; /* 그리드 컨테이너의 높이 설정 */
        cursor: pointer;
        transition: background-color 0.3s;

    }

    .grid-image {
        width: 50px; /* 이미지 너비 설정 */
        height: 50px; /* 이미지 높이 설정 */
        padding-bottom: 14px;
        margin: 0 auto; /* 이미지 가운데 정렬 */
        /*display: block; !* 이미지를 블록 요소로 변경 *!*/
    }

    .info-content {
        display: flex;
        flex-direction: column;
        align-items: center;
    }

    .grid-item:hover {
        background-color: #00857F;
        border: 1px solid #888;
    }

    .grid-item:hover {
        display: block;
    }




</style>
<%@ include file="../include/header.jsp" %>
<body>
<div class="container">
    <div class="setting-container">
        <div class="setting-nav">
            <a href="/service/selffdsRegion">지역설정</a>
            <a href="/service/selffdsCategory">업종설정</a>
            <a href="/service/selffdsTime">시간설정</a>
            <a href="/service/selffdsTotal">통합설정</a>
        </div>

        <div class="setting-form">
            <div class="info">
                <h1>안심결제서비스</h1>
                <h2>결제를 차단할 업종을 선택해주세요</h2>
            </div>
            <div class="info-content">
                <div class="grid-container">
                    <%
                        List<String> itemList = Arrays.asList("요식/유흥", "유통", "음/식료품", "의류/잡화", "스포츠/문화", "여행/교통", "미용",
                                "생활서비스", "교육/학원", "의료", "가전/가구", "자동차", "주유");
                        List<String> imgList = Arrays.asList("restaurant.png", "shopping-cart.png", "butcher-shop.png", "fashion.png", "sports.png",
                                "world.png", "cosmetics.png", "laundry-shop.png", "education.png", "hospital.png",
                                "electronics.png", "taxi.png", "oilstation.png");
                        List<String> categoryList = Arrays.asList("한식", "중식/일식", "커피전문점", "노래방");

                        for (int i = 0; i < itemList.size(); i++) {
                            String item = itemList.get(i);
                            String imgSrc = "../../../resources/img/" + imgList.get(i);
                    %>
                    <div class="grid-item">
                        <img class="grid-image" src="<%= imgSrc %>" alt="<%= item %> 이미지">
                        <div class="item-name"><%= item %></div>
                    </div>
                    <%
                        }
                    %>
                </div>

            </div>
            <div class="category-select">
            </div>
            <button class="okBtn">등록</button>
        </div>
    </div>
</div>
</body>
<%--<script>--%>

<%--    function positionCategoryDropdown(itemIndex) {--%>
<%--        const gridItem = document.getElementById('grid-item-${itemIndex}');--%>
<%--        const dropdown = document.getElementById('category-dropdown-${itemIndex}');--%>

<%--        const gridItemRect = gridItem.getBoundingClientRect();--%>
<%--        const scrollTop = window.pageYOffset || document.documentElement.scrollTop;--%>
<%--        const topPosition = gridItemRect.bottom + scrollTop;--%>

<%--        dropdown.style.left = '${gridItemRect.left}px';--%>
<%--        dropdown.style.top = '${topPosition}px'--%>
<%--        dropdown.style.display = "block";--%>
<%--    }--%>


<%--    function showCategoryDropdown(itemIndex) {--%>
<%--        const dropdown = document.getElementById('category-dropdown-${itemIndex}');--%>
<%--        dropdown.style.display = "block";--%>
<%--    }--%>

<%--    function hideCategoryDropdown(itemIndex) {--%>
<%--        const dropdown = document.getElementById('category-dropdown-${itemIndex}');--%>
<%--        dropdown.style.display = "none";--%>
<%--    }--%>
<%--</script>--%>
</html>

