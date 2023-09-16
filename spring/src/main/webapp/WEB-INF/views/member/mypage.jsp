<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Document</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <link href="../../../resources/css/common.css" rel="stylesheet">
    <link href="../../../resources/css/admin/adminCommon.css" rel="stylesheet">
    <link href="../../../resources/css/member/mypage.css" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
    <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/chart.js@3.5.1/dist/chart.min.js"></script>
</head>

<body>
<%@ include file="../include/header.jsp" %>
<div class="details">
    <div class="details__left">
        <ul class="menu">
            <li class="menu__item">
                <a href="/admin/safetyCard" class="menu__link">
                    <div class="menu__icon"><img src="../../../resources/img/bell%20(1).png"></div>
                    나의 소비 관리
                </a>
            </li>
            <li class="menu__item">
                <a href="/admin/fds" class="menu__link">
                    <div class="menu__icon"><img src="../../../resources/img/bell%20(1).png"></div>
                    서비스 이용현황
                </a>
            </li>
        </ul>
    </div>
    <div class="detail__right">
        <div class="sub-container">
            <div class="who" style="font-size: 25px; margin-top:30px"><%= name %>님의 카드정보</div>
            <div class="slideshow-container">
                <c:forEach items="${cards}" var="card" varStatus="loop">
                    <div class="mySlides fade">
                        <img src="../../resources/img/cardImg${loop.index + 1}.png"
                             alt="Card Image"
                             onclick="imageClicked(this);"
                             data-card-id="${cardId}">
                        <div class="cardIdtext">${card.cardId}</div>
                    </div>
                </c:forEach>
                <!-- Next and previous buttons -->
                <a class="prev" onclick="plusSlides(-1)">&#10094;</a>
                <a class="next" onclick="plusSlides(1)">&#10095;</a>
            </div>
        </div>
        <div class="month-info">
            <div class="month-info-1">
                <div>지난달보다 소비액이 <span id="totalAmount"></span>하였습니다.</div>
            </div>
            <div class="info">이번달 눈에 띄는 소비 영역은 어디?</div>
            <div class="month-info-2">
                <div class="month-box">
                    <div id="increase"></div>
                    <div>here</div>
                </div>
                <div class="month-box">
                    <div id="decrease"></div>
                    <div>here</div>
                </div>
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
                var differenceValue = data.difference;
                var increase = data.increaseList;
                var decrease = data.decreaseList;
                var increaseChart = data.increaseData;
                var decreaseChart = data.decreaseData;

                console.log("increase" + increaseChart);
                console.log("increase" + decreaseChart);

                var increasedOrDecreased = "<span class='increased'>증가</span>";

                if (differenceValue < 0) {
                    increasedOrDecreased = "<span class='decreased'>감소</span>";
                    differenceValue = Math.abs(differenceValue); // 음수 기호를 제거
                }

                $("#totalAmount").html("<strong>" + differenceValue + "</strong>" + "원 " + increasedOrDecreased);

                $("#increase").html("<strong>" + increase.categorySmall + "</strong>" + " 지출이 지날달 보다 <strong>" + increase.diffAmount + "</strong>원 늘었어요!");
                $("#decrease").html("<strong>" + decrease.categorySmall + "</strong>" + " 지출이 지날달 보다 <strong>" + Math.abs(decrease.diffAmount) + "</strong>원 줄었어요!");


                // 서버에서 받은 카드 히스토리 정보를 테이블에 추가
                var tableBody = $("#cardHistoryTable tbody");
                tableBody.empty(); // 기존 내용 삭제

                data.cardHistoryList.forEach(function (history) {
                    var row = "<tr><td>" + history.cardId + "<td>" + history.categorySmall + "</td><td>" + history.store + "</td><td>" + history.cardHisDate + "</td><td>" + history.amount + "</td></tr>";
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
