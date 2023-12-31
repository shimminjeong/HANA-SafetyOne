<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Title</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <link href="../../../resources/css/common.css" rel="stylesheet">
    <link href="../../../resources/css/member/service.css" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
</head>

<%@ include file="../include/header.jsp" %>
<div class="container">
    <div id="service">
        <div class="serviceTitle"><img src="../../../resources/img/bellcolor.png" style="width: 34px; height: 34px;"/><div>이상소비알림서비스</div></div>
        <div class="service-content2">
            <div class="text_div">
                <p><div class="sub-tit">실시간 금융 보호를 위한 알림 서비스</div><br>
                <div class="sub-txt">평소의 소비 패턴과 다른 거래를 즉시 감지하여 알림을 보내드립니다.</div></p>
            </div>
            <a href="/fds/fdsCardSelect">
                <button class="regBtn" style="background-color:#e7ac3e;">신청/해제</button>
            </a>
        </div>
        <div class="service_wrap">
            <div class="h_wrap">이상소비알림서비스란?</div>
            <ul class="marker_dot">
                <li>이 서비스는 사용자의 일반적인 소비 패턴과 다른 의심스러운 거래를 즉시 감지하여 알림을 제공하는 서비스입니다. <br>
                    사용자의 카드 사용 패턴과 금액 그리고 다른 업종, 지역, 시간대에서 발생하는 거래를 중심으로, 이상소비를 신속하게 <br>
                    탐지하여 사용자에게 알림을 제공합니다.
                </li>
                <li>이로써 사용자는 거래 내역을 신속하게 확인하고 필요한 조치를 취하여 더 큰 금융사고를 예방할 수 있습니다.<br>

                </li>
            </ul>
        </div>
    </div>
</div>
</body>
<img src="../../../resources/img/footer.png" style="width: 100%; margin-top: 70px; bottom:0;" >

</html>
