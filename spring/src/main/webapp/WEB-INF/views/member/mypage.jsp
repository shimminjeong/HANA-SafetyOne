<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Document</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <link href="../../../resources/css/common.css" rel="stylesheet">
    <link href="../../../resources/css/mypage.css" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
    <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/chart.js@3.5.1/dist/chart.min.js"></script>
</head>
<%@ include file="../include/header.jsp" %>
<body>
<style>
    * {
        box-sizing: border-box
    }

    /* Slideshow container */
    .slideshow-container {
        display: flex;
        align-items: center;
        max-width: 300px;
        position: relative;
        margin: auto;
        margin-top: 30px;
    }

    /* Hide the images by default */
    .mySlides {
        display: none;
    }

    /* Next & previous buttons */
    .prev, .next {
        cursor: pointer;
        position: absolute;
        top: 50%;
        width: auto;
        margin-top: -22px;
        padding: 16px;
        safetyCardSelect: white;
        font-weight: bold;
        font-size: 18px;
        transition: 0.6s ease;
        border-radius: 0 3px 3px 0;
        user-select: none;
    }

    /* Position the "next button" to the right */
    .next {
        right: 0;
        border-radius: 3px 0 0 3px;
    }

    /* On hover, add a black background safetyCardSelect with a little bit see-through */
    .prev:hover, .next:hover {
        background-safetyCardSelect: rgba(0, 0, 0, 0.8);
    }

    /* Caption text */
    .cardIdtext {
        font-size: 15px;
        padding: 20px 12px;
        text-align: center;
    }


    /* The dots/bullets/indicators */
    .dot {
        cursor: pointer;
        height: 15px;
        width: 15px;
        margin: 0 2px;
        background-safetyCardSelect: #bbb;
        border-radius: 50%;
        display: inline-block;
        transition: background-safetyCardSelect 0.6s ease;
    }

    .active, .dot:hover {
        background-safetyCardSelect: #717171;
    }

    /* Fading animation */
    .fade {
        animation-name: fade;
        animation-duration: 1.5s;
    }

    @keyframes fade {
        from {
            opacity: .4
        }
        to {
            opacity: 1
        }
    }

    .sub-container {
        display: flex;
        align-items: center;
        flex-direction: column;
        width: 100%;
        margin: 0 auto;

    }

    .month-info-1, .month-info-2 {
        display: flex;
        width: 100%;
        text-align: center;
        /* 부모 요소에 추가적인 스타일링이 필요한 경우 여기에 추가 */
    }

    .month-info-1 > div, .month-info-2 > div {
        flex: 1; /* 같은 크기로 나누기 위해 flex 설정 */
        margin: 0 5px; /* 요소 사이 간격 조절 */
        padding: 10px;
        border: 1px solid #ccc;
    }

    .info {
        text-align: center;
        font-size: 20px;
        margin: 10px auto;
    }

    .month-info, .history {
        width: 80%;
        margin: 0 auto;

    }

    table {
        border-collapse: collapse;
        width: 100%;
    }

    th, td {
        border: 1px solid black;
        padding: 8px;
        text-align: left;
    }


</style>
<div class="container">
    <div class="vertical-menu">
        <a href="#" class="active">마이페이지</a>
        <a href="#">안심카드설정</a>
        <a href="#">나의소비현황</a>
    </div>
<%--    <c:forEach items="${cards}" var="card">--%>
<%--        ${card.cardId}--%>
<%--    </c:forEach>--%>
    <div class="sub-container">
        <div class="who" style="font-size: 25px; margin-top:30px"><%= name %>님의 카드정보</div>
        <div class="slideshow-container">
            <c:forEach items="${cards}" var="card" varStatus="loop">
                <div class="mySlides fade">
                    <img src="../../resources/img/cardImg${loop.index + 1}.png" style="width:100%">
                    <div class="cardIdtext">${card.cardId}</div>
                </div>
            </c:forEach>
            <!-- Next and previous buttons -->
            <a class="prev" onclick="plusSlides(-1)">&#10094;</a>
            <a class="next" onclick="plusSlides(1)">&#10095;</a>
        </div>
    </div>
    <div class="month-info">
        <div class="info">최신 한달 사용 현황</div>
        <div class="month-info-1">
            <div>현재까지 사용금액</div>
            <div>저번달 대비 얼마나 늘었어요</div>
        </div>
        <div class="info">이번달 가장 많이 소비한 항목</div>
        <div class="month-info-2">
            <div>시간</div>
            <div>업종</div>
            <div>지역</div>
        </div>
    </div>
    <div class="history">
        <h2>거래내역</h2>
        <table id="cardHistoryTable">
            <thead>
            <tr>
                <th>카드번호</th>
                <th>카테고리</th>
                <th>가맹점명</th>
                <th>거래일자</th>
                <th>거래일시</th>
                <th>거래금액</th>

            </tr>
            </thead>
            <tbody>
            <!-- 여기에 서버에서 받아온 카드 히스토리 정보를 추가할 예정 -->
            </tbody>
        </table>


    </div>
</div>

</body>
<script>
    let slideIndex = 1;
    showSlides(slideIndex);

    // Next/previous controls
    function plusSlides(n) {
        showSlides(slideIndex += n);
    }

    // Thumbnail image controls
    function currentSlide(n) {
        showSlides(slideIndex = n);
    }

    function showSlides(n) {
        let i;
        let slides = document.getElementsByClassName("mySlides");

        if (n > slides.length) {
            slideIndex = 1
        }
        if (n < 1) {
            slideIndex = slides.length
        }
        for (i = 0; i < slides.length; i++) {
            slides[i].style.display = "none";
        }
        slides[slideIndex - 1].style.display = "block";

        let currentSlide = slides[slideIndex - 1];
        let currentCardId = currentSlide.querySelector(".cardIdtext").textContent;

        sendCardIdToServer(currentCardId);
        console.log(currentCardId)

    }

    function sendCardIdToServer(cardId) {
        console.log(cardId);
        $.ajax({
            type: "POST",
            url: "/cardinfo",
            data: JSON.stringify({cardId: cardId}),
            contentType: 'application/json',
            success: function (data) {
                // 서버에서 받은 카드 히스토리 정보를 테이블에 추가
                var tableBody = $("#cardHistoryTable tbody");
                tableBody.empty(); // 기존 내용 삭제

                data.forEach(function (history) {
                    var row = "<tr><td>" + history.cardId + "<td>" + history.categoryBig + "</td><td>" + history.store + "</td><td>" + history.cardHisDate + "</td><td>" + history.cardHisTime + "</td><td>" + history.amount + "</td></tr>";
                    tableBody.append(row);
                });
            },
            error: function (error) {
                console.log(error);
            }
        });
    }


</script>
</html>
