<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Title</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <link href="../../../resources/css/common.css" rel="stylesheet">
    <link href="../../../resources/css/service.css" rel="stylesheet">
    <link href="../../../resources/css/regionspot.css" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/chart.js@3.5.1/dist/chart.min.js"></script>
</head>
<style>

    .info-content {
        display: flex;
        flex-direction: row;
        width: 100%;
        align-items: stretch;

    }


    .spot-container {
        position: relative;
        display: inline-block;
    }

    .spot-container button {
        position: absolute;
        cursor: pointer;
        background-color: transparent;
        border: none;
        padding: 0;
        font-size: 12px;
        color: black;
    }

    .time-category {
        display: flex;
        align-items: center;
        flex-direction: column;
        box-sizing: border-box;
        width: 100%;
        margin-top: 10px;

    }

    .time-select {
        display: flex;
        justify-content: center;
        align-items: center;
        margin-bottom: 30px;
        margin-top: 15px;

    }

    .inputBox1, .inputBox2 {
        padding: 10px;
        border: 1px solid #ccc;
        border-radius: 4px;
        background-color: #f5f5f5;
        width: 70px;
        height: 40px;
        font-size: 18px;
        text-align: center;
        margin-right: 10px;
    }

    p {
        font-size: 18px;
        margin-right: 10px;
    }


    .category-select {
        display: flex;
        justify-content: center;
        align-items: center;
        flex-direction: column;

    }


    .okBtn a {
        flex: 1;
    }

    .region-head {
        position: absolute;
        top: 32px;
        left: 0px;
    }


    .grid-container {
        margin-top: 15px;
        display: grid;
        grid-template-columns: repeat(3, 90px); /* 2열로 반복 */
        /*grid-gap: 10px; !* 박스 사이의 간격 설정 *!*/
        align-items: center; /* 내용 수직 가운데 정렬 */
        text-align: center; /* 내용 가로 가운데 정렬 */
    }

    .grid-item {
        display: flex;
        flex-direction: column;
        border: 1px solid black;
        align-items: center;

        /*padding: 10px ;*/
        height: 35px; /* 그리드 컨테이너의 높이 설정 */
        cursor: pointer;
        transition: background-color 0.3s;
        position: relative;
        font-size: 15px;
        justify-content: center;

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

    .grid-item:hover {
        background-color: #00857F;
        border: 1px solid #ffffff;
        color: black;
    }


</style>

<%@ include file="../include/header.jsp" %>
<body>
<div class="container">
    <%
        // Get selected preferences from query parameters
        String selectedRegion = request.getParameter("region");
        String selectedCategory = request.getParameter("category");
        String selectedTime = request.getParameter("time");
    %>

    <!-- Use selected preferences to filter and display content -->
    <%-- Example: Display region if selected --%>
    <% if (selectedRegion != null && !selectedRegion.isEmpty()) { %>
    <div>Selected Region: <%= selectedRegion %></div>
    <% } %>

    <%-- Example: Display category if selected --%>
    <% if (selectedCategory != null && !selectedCategory.isEmpty()) { %>
    <div>Selected Category: <%= selectedCategory %></div>
    <% } %>

    <%-- Example: Display time if selected --%>
    <% if (selectedTime != null && !selectedTime.isEmpty()) { %>
    <div>Selected Time: <%= selectedTime %></div>
    <% } %>

    <div class="setting-container">
        <div class="info">
            <h1>안심결제서비스</h1>
            <h2>결제를 차단할 지역, 업종, 시간의 조합을 설정하세요</h2>
        </div>
        <div class="info-content">
            <span id="region" class="spot-container">
                <img src="../../../resources/img/map.png" style="height: 380px">
                <a class="region-head" style="font-size: 20px">지역 선택</a>
                <button class="seoul-btn" onclick="selectRegion(this)" value="${regionList[0]}">서울</button>
                <button class="gyeonggi-btn" onclick="selectRegion(this)" value="${regionList[1]}">경기도</button>
                <button class="incheon-btn" onclick="selectRegion(this)" value="${regionList[2]}">인천</button>
                <button class="gangwon-btn" onclick="selectRegion(this)" value="${regionList[3]}">강원도</button>
                <button class="chungnam-btn" onclick="selectRegion(this)" value="${regionList[4]}">충청남도</button>
                <button class="daejeon-btn" onclick="selectRegion(this)" value="${regionList[5]}">대전</button>
                <button class="chungbuk-btn" onclick="selectRegion(this)" value="${regionList[6]}">충청북도</button>
                <button class="sejong-btn" onclick="selectRegion(this)" value="${regionList[7]}">세종</button>
                <button class="busan-btn" onclick="selectRegion(this)" value="${regionList[8]}">부산</button>
                <button class="ulsan-btn" onclick="selectRegion(this)" value="${regionList[9]}">울산</button>
                <button class="daegu-btn" onclick="selectRegion(this)" value="${regionList[10]}">대구</button>
                <button class="gyeongbuk-btn" onclick="selectRegion(this)" value="${regionList[11]}">경상북도</button>
                <button class="gyeonggnam-btn" onclick="selectRegion(this)" value="${regionList[12]}"> 경상남도</button>
                <button class="jeollanam-btn" onclick="selectRegion(this)" value="${regionList[13]}">전라남도</button>
                <button class="gwangju-btn" onclick="selectRegion(this)" value="${regionList[14]}">광주</button>
                <button class="jeollabuk-btn" onclick="selectRegion(this)" value="${regionList[15]}">전라북도</button>
                <button class="jejudo-btn" onclick="selectRegion(this)" value="${regionList[16]}">제주도</button>
            </span>
            <div id="time" class="time-category">
                <a style="font-size: 20px">시간 선택</a>
                <div class="time-select">
                    <input type="number" class="inputBox1" name="inputBox1">
                    <p>시 ~ </p>
                    <input type="number" class="inputBox2" name="inputBox2">
                    <p>시 차단 </p>
                </div>
            </div>

            <div id="category" class="category-select">
                <a style="font-size: 20px">업종 선택</a>
                <div class="grid-container">
                    <c:forEach var="entry" items="${categoryMap}">
                        <div class="grid-item" onmouseover="showDropdown(this)">
                            <c:set var="imgIndex" value="${loop.index % imgList.size()}"/>
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
        </div>
    </div>
    <button class="okBtn"><a href="#">등록</a></button>
</div>
</body>
</html>
