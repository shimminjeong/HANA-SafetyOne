<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Title</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <link href="../../../resources/css/common.css" rel="stylesheet">
    <link href="../../../resources/css/service.css" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
</head>
<body>
<%@ include file="../include/header.jsp" %>
<div class="container">
    <div id="service">
        <div class="serviceTitle"><img src="../../../resources/img/secure-payment.png"/>
            <div>안심서비스</div>
        </div>
        <div class="service-content1">
            <div class="text_div">
                <p>
                <div class="sub-tit">안전한 결제를 위한 안심설정 서비스</div>
                <br>
                <div class="sub-txt">거래를 차단하거나 허용할 지역, 시간, 업종 등 나만의 Rule을 간편하게 설정</div>
                </p>
            </div>
            <a href="/safetyCard/safetyCardSelect">
                <button class="regBtn" style="background-color: #60a3de;">등록/해제</button>
            </a>
        </div>
        <div class="service_wrap">
            <div class="h_wrap">안심서비스란?</div>
            <ul class="marker_dot">
                <li>안전한 카드 사용을 위한 통합 서비스로서, 카드별로 간편하게 설정(맞춤 사용)하여 지역, 시간 업종 등에 대한 거래를 <br>
                    차단하거나 허용하여 카드 도난, 분실 등 부정사용으로부터 카드를 더 안전하게 관리할 수 있도록 돕는 서비스입니다.
                </li>
                <li>서비스 등록 시점부터 고객이 직접 설정한 Rule에 따라 거래가 차단되며 필요시 특정 기간동안<br>
                    서비스를 일시정지하여 거래를 허용하고 이외의 거래는 부정사용 예방을 위해 안전하게 차단됩니다.
                </li>

            </ul>
        </div>
    </div>
</div>
</body>
</html>

