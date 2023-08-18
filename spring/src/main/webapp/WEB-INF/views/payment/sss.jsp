<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
    <title>Title</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <link href="../../../resources/css/common.css" rel="stylesheet">
    <%--    <link href="../../../resources/css/service.css" rel="stylesheet">--%>
    <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
    <style>
        * {
            box-sizing: border-box
        }

        /* Slideshow container */
        .slideshow-container {
            max-width: 1000px;
            position: relative;
            margin: auto;
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
            color: white;
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

        /* On hover, add a black background color with a little bit see-through */
        .prev:hover, .next:hover {
            background-color: rgba(0, 0, 0, 0.8);
        }

        /* Caption text */
        .text {
            color: #f2f2f2;
            font-size: 15px;
            padding: 8px 12px;
            position: absolute;
            bottom: 8px;
            width: 100%;
            text-align: center;
        }

        /* Number text (1/3 etc) */
        .numbertext {
            color: #f2f2f2;
            font-size: 12px;
            padding: 8px 12px;
            position: absolute;
            top: 0;
        }

        /* The dots/bullets/indicators */
        .dot {
            cursor: pointer;
            height: 15px;
            width: 15px;
            margin: 0 2px;
            background-color: #bbb;
            border-radius: 50%;
            display: inline-block;
            transition: background-color 0.6s ease;
        }

        .active, .dot:hover {
            background-color: #717171;
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

        .reg-cancle-btn {
            display: flex;
            flex-direction: row;
            justify-content: center;

        }

        .reg-Btn, .cancle-Btn {
            color: white;
            border: none;
            padding: 12px 40px 12px 40px;
            border-radius: 5px;
            cursor: pointer;
            text-decoration: none;
            background-color: #00857F;
            font-size: 16px;
            transition: background-color 0.3s;
            display: block; /* 버튼을 블록 레벨로 설정하여 가운데 정렬을 위한 설정 */
        }

        .reg-Btn {
            margin-left: 40px;
        }


    </style>
</head>

<body>
<%@ include file="../include/header.jsp" %>
<div class="slideshow-container">
    <c:forEach items="${cards}" var="card" varStatus="loop">
        <div class="mySlides fade">
            <div class="numbertext">${loop.index + 1}/3</div>
            <img src="../../../resources/img/cardImg${loop.index + 1}.png" style="width:50%">
            <div class="text">${card.card_id}</div>
        </div>
    </c:forEach>

    <!-- Next and previous buttons -->
    <a class="prev" onclick="plusSlides(-1)">&#10094;</a>
    <a class="next" onclick="plusSlides(1)">&#10095;</a>
</div>
<br>

<!-- The dots/circles -->
<div style="text-align:center">
    <span class="dot" onclick="currentSlide(1)"></span>
    <span class="dot" onclick="currentSlide(2)"></span>
    <span class="dot" onclick="currentSlide(3)"></span>
</div>
<div class="reg-cancle-btn">
    <button class="cancle-Btn" onclick="cancleCard()">해제</button>
    <button class="reg-Btn" onclick="registerCard()">등록</button>
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
        let dots = document.getElementsByClassName("dot");
        if (n > slides.length) {
            slideIndex = 1
        }
        if (n < 1) {
            slideIndex = slides.length
        }
        for (i = 0; i < slides.length; i++) {
            slides[i].style.display = "none";
        }
        for (i = 0; i < dots.length; i++) {
            dots[i].className = dots[i].className.replace(" active", "");
        }
        slides[slideIndex - 1].style.display = "block";
        dots[slideIndex - 1].className += " active";
    }


    // function registerCard() {
    //
    //     const selectedSlideIndex = showSlides(slideIndex); // slideIndex 가져오기
    //
    //     const selectedCardSlide = document.querySelector('.mySlides.fade.active');
    //     const selectedCardId = selectedCardSlide.dataset.cardId;
    //
    //     console.log("Selected slide index:", selectedSlideIndex);
    //     console.log("Selected card ID:", selectedCardId);
    //
    //     $.ajax({
    //         url: '/service/registerCard',
    //         type: 'POST',
    //         data: selectedCardId,
    //         contentType: 'application/json',
    //         success: function (response) {
    //             if (response === "selffds 서비스 신청 성공") {
    //                 alert("selffds 서비스 신청 성공");
    //                 window.location.href = '/service/selffdsRegion';
    //             } else
    //                 alert("이미 신청이 완료된 카드입니다.");
    //         }
    //     });
    // }
    //
    //
    // function cancleCard(card_id) {
    //     const selectedCards = document.querySelectorAll('input[name="selectedCards"]:checked');
    //     const selectedIds = Array.from(selectedCards).map(card => card.value).join(',');
    //     console.log("Selected card ID:", selectedIds); // cardId 출력
    //     $.ajax({
    //         url: '/service/cancleCard',
    //         type: 'POST',
    //         data: selectedIds,
    //         contentType: 'application/json',
    //         success: function (response) {
    //             if (response === "selffds 서비스 해제 성공") {
    //                 alert("selffds 서비스 해제 성공");
    //                 window.location.href = '/service/serviceInfo';
    //             } else
    //                 alert("해당 서비스 신청안된 카드입니다.");
    //         }
    //     });
    // }

</script>
<%--</script>--%>
</html>
