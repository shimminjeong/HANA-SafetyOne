<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Document</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <link href="../../resources/css/common.css" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
    <link href="../../resources/css/index.css" rel="stylesheet">
</head>

<body>
<%@ include file="include/header.jsp" %>
<div class="main-section">
    <div class="sub-main1" onclick="window.location.href='/safetyCard/'">
        <div class="sub-main1-word">
            <div>안심서비스</div>
            <div style="margin-top:20px; font-size: 20px">사용하지 않는 거래를 차단해보세요</div>
            <div class="sub-main1-img">
                <div class="img-div1"><img src="../../resources/img/pin.png"/></div>
                <div class="img-div1"><img src="../../resources/img/clock1.png"/></div>
                <div class="img-div1"><img src="../../resources/img/categories.png"/></div>
            </div>
        </div>
    </div>
    <div class="sub-main2" onclick="window.location.href='/fds/'">
        <div class="sub-main2-word">
            <div>이상소비알림서비스</div>
            <div style="margin-top:20px; font-size: 20px">본인의 소비패턴과 다른 거래내역은 알림을 드립니다</div>
            <div class="sub-main2-img">
                <div class="img-div2"><img src="../../resources/img/credit.png"/></div>
                <div class="img-div2"><img src="../../resources/img/search.png"/></div>
                <div class="img-div2"><img src="../../resources/img/bellcolor.png"/></div>
            </div>
        </div>
    </div>
</div>
<div class="main-section3">
    <div class="submain-div">
        <a href="/mypageReport">마이페이지</a>
        <hr>
        <a href="/mypageReport">카드이용내역</a>
        <hr>
        <a href="/mypageReport">소비레포트</a>
        <hr>
        <a href="/mypageReport">안심서비스</a>
        <hr>
        <a href="/mypageReport">이상소비알림서비스</a>

    </div>

</div>

<div class="main-section2">
    <div>
        <div class="ex-main"> 서비스 등록 후 부정사용 예방 사례</div>
        <div class="ex-main-word">지금 SafetyOne 서비스를 이용해보세요.<br>
            안전한 카드 사용은 하나카드가 책임지겠습니다.
        </div>
        <button class="ex-main-button">사례보기</button>
        <%--        <div class="slideshow-container">--%>
        <%--            <div class="mySlides fade">--%>
        <%--                <div class="ex">[사례1] 국내에서 사용하거나 국내에서 해외직구만 이용하는 경우</div>--%>
        <%--                <div class="ex-content">김OO 고객님<br>--%>
        <%--                    "제가 해외여행을 하지는 않지만, 해외직구를 위해 신한카드를 사용하고 있거든요, Self FDS 홍보를 보고 최근 휴대폰에서 신한카드 앱을 이용해 온라인 거래만 가능하도록 해외사용--%>
        <%--                    Self--%>
        <%--                    Rule을 등록했습니다. 다음 해외에서 누군가가 제 카드를 사용하려고 시도했지만 제가 설정한 Self Rule이 막아줬어요."--%>
        <%--                </div>--%>
        <%--            </div>--%>

        <%--            <div class="mySlides fade">--%>
        <%--                <div class="ex">[사례2] 해외 출장을 가는 경우</div>--%>
        <%--                <div class="ex-content">이OO 고객님<br>--%>
        <%--                    "저는 해외 출장이 많아 여러 국가에서 카드를 사용하고 있는데, 홈페이지에서 Self FDS 서비스가 있다는 것을 알게 되었습니다. 그리고 해외에서 카드복제가 많이 이루어진다는--%>
        <%--                    것도 알고--%>
        <%--                    있어,--%>
        <%--                    홈페이지에서 직접 제가 사용하는 국가만 등록했습니다. 2주 후 과거에 출장을 가지 않았던 국가에서 카드가 불법 복제되어 사용 시도가 있었지만 Self FDS 서비스 덕분에 다행히--%>
        <%--                    승인이--%>
        <%--                    거절되었습니다."--%>
        <%--                </div>--%>
        <%--            </div>--%>

        <%--            <div class="mySlides fade">--%>
        <%--                <div class="ex">[사례3] 해외에서 카드를 분실했을 경우</div>--%>
        <%--                <div class="ex-content">최OO 고객님<br>--%>
        <%--                    "저는 유럽여행을 가기 전 핸드폰에서 신한카드 앱을 이용해 여행기간, 국가, 1회 사용가능금액 등 해외사용 Self Rule을 등록했습니다. 다음 여행기간 중 이탈리아에서--%>
        <%--                    소매치기를--%>
        <%--                    당했지만,--%>
        <%--                    카드를 훔친 범인이 1회 사용가능금액보다 큰 금액을 사용하려고 시도하다가 승인 거절되자 포기했더라구요."--%>
        <%--                </div>--%>
        <%--            </div>--%>
        <%--        </div>--%>
    </div>
    <img class="main-section2-img" src="../../resources/img/cardmain.png">
</div>


<!-- The dots/circles -->
<div style="text-align:center">
    <span class="dot" onclick="currentSlide(1)"></span>
    <span class="dot" onclick="currentSlide(2)"></span>
    <span class="dot" onclick="currentSlide(3)"></span>
</div>

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
</script>
</body>
</html>