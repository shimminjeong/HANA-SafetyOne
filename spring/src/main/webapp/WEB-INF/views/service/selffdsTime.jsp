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

<%@ include file="../include/header.jsp" %>

<style>

    #timeForm {
        margin: 50px auto;
        display: flex;
        align-items: center;
    }

    .inputBox1, .inputBox2 {
        padding: 10px;
        border: 1px solid #ccc;
        border-radius: 4px;
        background-color: #f5f5f5;
        width: 120px;
        height: 50px;
        font-size: 18px;
        text-align: center;
        margin-right: 10px;
    }

    p {
        font-size: 20px;
        margin-right: 30px;
    }

    .time-reg{
        color: black; /* 글자색 변경 */
        padding: 12px 40px 12px 40px;
        border: none; /* 테두리 없음 */
        border-radius: 5px; /* 둥근 모서리 */
        text-align: center;
        text-decoration: none;
        font-size: 16px; /* 폰트 크기 변경 */
        cursor: pointer;
        background-color: #ffffff; /* 배경색 추가 */
        transition: background-color 0.3s, transform 0.3s; /* 부드러운 전환 효과 추가 */
        box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1); /* 그림자 추가 */
    }

    .time-reg:hover {
        background-color: #00857F; /* 마우스 오버 시 배경색 변경 */
        color: white; /* 마우스 오버 시 글자색 변경 */
    }

    .selected-time-button {
        background-color: #00857F;
        color: white;
        border: none;
        border-radius: 5px;
        /*padding: 5px 10px;*/
        margin-right: 7px;
        cursor: pointer;
        font-size: 15px;
        width: 50px;
        height: 30px;
        margin-bottom: 80px;
    }


</style>
<body>
<div class="container">
    <div class="setting-container">
        <div class="setting-nav">
            <a href="/service/selffdsRegion">지역설정</a>
            <a href="/service/selffdsCategory">업종설정</a>
            <a href="/service/selffdsTime" style="color: #00857F">시간설정</a>
            <a href="/service/selffdsTotal">통합설정</a>
        </div>
        <div class="setting-form">
            <div class="info">
                <h1>안심결제서비스</h1>
                <h2>결제를 차단할 시간을 선택해주세요</h2>
            </div>
            <div class="info-content">
                <div id="timeForm">
                    <input type="number" class="inputBox1" name="inputBox1" placeholder="시작시간">
                    <p>시 부터 </p>
                    <input type="number" class="inputBox2" name="inputBox2" placeholder="끝시간">
                    <p>시 까지 차단 </p>
                    <button class="time-reg" type="button" onclick="registerTime()">등록</button>
                </div>
                <div class="selected-time"></div>
            </div>
            <button class="okBtn"><a href="/service/selffdsTotal">다음</a></button>
        </div>
    </div>
</div>

</body>
<script>
    function selectNumber(number) {
        document.querySelector(".inputBox1").value = number;
        document.querySelector(".inputBox2").value = number;

    }

    function registerTime() {
        var startHour = parseInt(document.querySelector(".inputBox1").value);
        var endHour = parseInt(document.querySelector(".inputBox2").value);
        var selectedTimeDiv = document.querySelector(".selected-time");

        if (!isNaN(startHour) && !isNaN(endHour)) {
            selectedTimeDiv.innerHTML = ""; // Clear existing content

            for (var i = startHour; i <= endHour; i++) {
                var button = document.createElement("button");
                button.innerText = i + "시";
                button.className = "selected-time-button";
                selectedTimeDiv.appendChild(button);
            }
        }
    }
</script>
</html>
