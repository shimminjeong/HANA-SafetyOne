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
        margin-top: 40px;
        margin-bottom: 30px;
        display: grid;
        grid-template-columns: repeat(7, 87px); /* 2열로 반복 */
        /*grid-gap: 10px; !* 박스 사이의 간격 설정 *!*/
        align-items: center; /* 내용 수직 가운데 정렬 */
        text-align: center; /* 내용 가로 가운데 정렬 */
    }

    .recommend {
        top: 225px;
        left: 211px;
    }

    .grid-item {
        display: flex;
        flex-direction: column;
        border: 1px solid black;
        padding: 10px 5px;
        height: 80px; /* 그리드 컨테이너의 높이 설정 */
        cursor: pointer;
        transition: background-color 0.3s;
        position: relative;
        font-size: 15px;

    }

    .dropdown-item {
        display: none;
        cursor: pointer;
        margin: auto;
        font-size: 12px;
        line-height: 25px;
        height: 25px;
        background-color: transparent; /* 초기 배경 설정 */
        transition: background-color 0.3s ease; /* 배경 변경 시 부드러운 효과를 위한 트랜지션 추가 */
        padding: 0px 3px;
    }

    .dropdown-item:hover {
        background-color: #00857F; /* 마우스 호버 시 배경 변경 */
        transform: scale(1.1); /* hover 시 약간 확대되는 효과 */
        box-shadow: 0 6px 8px rgba(0, 0, 0, 0.2); /* hover 시 그림자 약간 강화 */
        color: white;
    }



    .dropdown-list {
        position: absolute;
        top: 100%; /* Position the dropdown below the grid item */
        left: 0;
        width: 100%; /* Make the dropdown width match the grid item width */
        z-index: 1; /* Ensure the dropdown appears above other content */
        background-color: #ffffff; /* Add a background color */
        /*border: 1px solid  !* Add a border for visual separation *!*/
        box-shadow: 0px 2px 5px rgba(0, 0, 0, 0.1); /* Add shadow for depth */
    }

    .grid-item:hover .dropdown-item {
        display: block;
        color: black;
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
        color: black;
    }


    .grid-item:hover {
        background-color: #00857F;
        border: 1px solid #ffffff;
        color: black;
    }

    .selected-category button {
        margin: 5px;
        padding: 5px 10px;
        background-color: #00857F;
        color: white;
        border: none;
        border-radius: 4px;
        cursor: pointer;
    }

    .recommend {
        width: 300px; /* 원하는 너비(px)로 수정 */
        height: 200px; /* 원하는 높이(px)로 수정 */
        background-color: lightgray;
        border: 1px solid gray;
        position: absolute;
        top: 50px; /* 원하는 수직 위치(px)로 수정 */
        left: 100px; /* 원하는 수평 위치(px)로 수정 */
    }


    .info {
        display: flex;
        flex-direction: column;
    }

    .info h1 {
        margin: auto 0px;
    }

    .info h2 {
        margin-bottom: 0px;
    }


</style>
<%@ include file="../include/header.jsp" %>
<body>

<div class="container">
    <div class="setting-container">
        <div class="setting-nav">
            <a href="/safetyCard/region">지역설정</a>
            <a href="/safetyCard/category" style="color: #00857F">업종설정</a>
            <a href="/safetyCard/time">시간설정</a>
        </div>

        <div class="setting-form">
            <span class="info">
                <a>안심결제서비스</a>
                <a>결제를 차단할 업종을 선택해주세요</a>
            </span>
            <div class="info-content">
<%--                <div class="recommend">--%>
<%--                    추천--%>
<%--                </div>--%>
                <div class="grid-container">
                    <c:set var="imgList"
                           value="${['restaurant.png', 'shopping-cart.png', 'butcher-shop.png', 'fashion.png', 'sports.png', 'world.png', 'cosmetics.png', 'laundry-shop.png', 'education.png', 'hospital.png', 'electronics.png', 'taxi.png', 'oilstation.png']}"/>

                    <c:forEach var="entry" items="${categoryMap}" varStatus="loop">
                        <div class="grid-item" onmouseover="showDropdown(this)">
                            <c:set var="imgIndex" value="${loop.index % imgList.size()}"/>
                            <c:set var="imageName" value="${imgList[imgIndex]}"/>
                            <img class="grid-image" src="../../../resources/img/${imageName}" alt="${entry.key}">
                            <div class="item-name">${entry.key}</div>
                            <div class="dropdown-list">
                                <div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
                                    <c:forEach var="category" items="${entry.value}">
                                        <a class="dropdown-item"
                                           onclick="selectCategory('${category.categorySmall}')">${category.categorySmall}</a>
                                    </c:forEach>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>
            <div class="selected-category"></div>
            <button class="okBtn"><a href="/safetyCard/time">다음</a></button>
        </div>


    </div>
</div>
</body>

<script>
    function selectCategory(selectedCategory) {
        // Create a new button element
        var button = document.createElement("button");
        button.innerText = selectedCategory; // Set the button's text
        button.className = "selected"; // Add a class for styling

        // Append the button to the category-select div
        var categorySelectDiv = document.querySelector(".selected-category");
        categorySelectDiv.appendChild(button);

        document.querySelector('.selected').addEventListener('click', function (event) {
            // 클릭된 요소가 버튼인 경우에만 동작
            if (event.target.tagName === 'BUTTON') {
                // 클릭된 버튼 제거
                event.target.remove();
            }
        });
    }
</script>


</html>