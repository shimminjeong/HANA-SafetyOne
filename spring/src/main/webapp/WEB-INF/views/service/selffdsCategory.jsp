<%@ page import="java.util.List" %>
<%@ page import="java.util.Arrays" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Title</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <link href="../../../resources/css/common.css" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/chart.js@3.5.1/dist/chart.min.js"></script>
</head>
<style>
    #formsize img {
        width: 40%;
        height: auto;
    }

    /* Style for vertical navigation */
    .service-nav {
        background-color: #f9f9f9;
        width: 100px;
        padding-top: 20px;
        padding-left: 0px;
        padding-right: 0px;
        padding-bottom: 0px;
        margin-right: 20px;
        margin-left: 20px;
        margin-bottom: 20px;
        margin-top: 50px;
        height: 120px;
        border: none;
        display: flex;
        flex-direction: column;
        border-radius: 10px;
        text-decoration: none;
        cursor: pointer;
        transition: background-color 0.3s, transform 0.3s;
        box-shadow: 0 4px 6px rgba(0, 0, 0, 0.4);
        align-items: center;
    }

    .service-nav a {
        margin-bottom: 10px;
        font-size: 16px;
    }

    .sub-container {
        display: flex;
        flex-direction: row;
        justify-content: center;
        width: 1000px;
        height: 500px;
        margin: 50px auto;
        text-decoration: none;

    }

    #formsize {
        margin-top: 50px;
        display: flex;
        flex-direction: column;
        justify-content: center;
        color: black; /* 글자색 변경 */
        border: none; /* 테두리 없음 */
        border-radius: 10px; /* 둥근 모서리 */
        text-decoration: none;
        font-size: 12px; /* 폰트 크기 변경 */
        cursor: pointer;
        background-color: #ffffff; /* 배경색 추가 */
        transition: background-color 0.3s, transform 0.3s; /* 부드러운 전환 효과 추가 */
        box-shadow: 0 4px 6px rgba(0, 0, 0, 0.4); /* 그림자 추가 */
        width: 600px; /* 가로 크기 */
        height: 400px; /* 세로 크기 */
    }

    .sub-container {
        display: flex;
        margin: 0;
        width: 800px; /* 가로 크기 */
        height: 500px; /* 세로 크기 */
    }

    .service-nav a {
        text-decoration: none;
        color: black;
    }

    .info {
        display: flex;
        flex-direction: row;
    }


    .grid-container {
        display: grid;
        grid-template-columns: repeat(7, 80px); /* 2열로 반복 */
        /*grid-gap: 10px; !* 박스 사이의 간격 설정 *!*/
        align-items: center; /* 내용 수직 가운데 정렬 */
        text-align: center; /* 내용 가로 가운데 정렬 */

    }


    /* 박스 스타일 설정 */
    .grid-item {
        display: flex;
        flex-direction: column;
        border: 1px solid black;
        padding: 10px 5px;
        height: 60px; /* 그리드 컨테이너의 높이 설정 */
        cursor: pointer;
        transition: background-color 0.3s;

    }

    /* 이미지 스타일 설정 */
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

    .category-dropdown {
        display: none;
        position: absolute;
        top: 100%;
        left: 0;
        width: 100%;
        background-color: #fff;
        border: 1px solid #ccc;
        z-index: 1;
    }

    .grid-item:hover .category-dropdown {
        display: block;
    }

    .category-list {
        list-style: none;
        padding: 0;
        margin: 0;
    }

    .category-list-item {
        padding: 8px;
        cursor: pointer;
    }

    .category-list-item:hover {
        background-color: #f0f0f0;
    }


</style>
<%@ include file="../include/header.jsp" %>
<body>
<div class="container">
    <div class="sub-container">
        <div class="service-nav">
            <a href="/service/selffdsRegion">지역설정</a>
            <a href="/service/selffdsCategory">업종설정</a>
            <a href="/service/selffdsTime">시간설정</a>
        </div>

        <div id="formsize">
            <div class="info">업종선택</div>
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
                    <div class="grid-item" onmouseover="showCategoryDropdown(<%= i %>)" onmouseout="hideCategoryDropdown(<%= i %>)">
                        <img class="grid-image" src="<%= imgSrc %>" alt="<%= item %> 이미지">
                        <div class="item-name"><%= item %></div>
                        <div id="category-dropdown-<%= i %>" class="category-dropdown">
                            <ul class="category-list">
                                <%
                                    for (String category : categoryList) {
                                %>
                                <li class="category-list-item"><%= category %></li>
                                <%
                                    }
                                %>
                            </ul>
                        </div>
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
<script>

    function positionCategoryDropdown(itemIndex) {
        const gridItem = document.getElementById('grid-item-${itemIndex}');
        const dropdown = document.getElementById('category-dropdown-${itemIndex}');

        const gridItemRect = gridItem.getBoundingClientRect();
        const scrollTop = window.pageYOffset || document.documentElement.scrollTop;
        const topPosition = gridItemRect.bottom + scrollTop;

        dropdown.style.left = '${gridItemRect.left}px';
        dropdown.style.top = '${topPosition}px'
        dropdown.style.display = "block";
    }


    function showCategoryDropdown(itemIndex) {
        const dropdown = document.getElementById('category-dropdown-${itemIndex}');
        dropdown.style.display = "block";
    }

    function hideCategoryDropdown(itemIndex) {
        const dropdown = document.getElementById('category-dropdown-${itemIndex}');
        dropdown.style.display = "none";
    }
</script>
</html>

