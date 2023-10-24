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
<%@ include file="include/header.jsp" %>
<body>

<div class="main-section">
    <div class="sub-main1" onclick="window.location.href='/safetyCard/'">
        <div class="sub-main1-word">
            <div>안심서비스</div>
            <div style="margin-top:20px; font-size: 20px">안전한 결제를 위한 안심설정 서비스</div>
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
            <div style="margin-top:20px; font-size: 20px">본인의 소비패턴과 다른 거래 시 실시간 알림 서비스</div>
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
    </div>
    <img class="main-section2-img" src="../../resources/img/HANACARD.png">
</div>
<img src="../../../resources/img/footer.png" style="width: 100%; margin-top: 70px; bottom:0;" >

</body>
</html>