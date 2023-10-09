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
                    서비스를 정지할 수 있으며제공함. 이외의 거래는 부정사용 예방을 위해 안전하게 차단됨
                </li>
                <li>
                    서비스 등록 시점부터 고객이 직접 설정한 Rule에 따라 (업종, 지역, 시간 등) 거래가 차단되며
                    필요시 특정 기간동안 거래를 허용하는 서비스를 제공함. 이외의 거래는 부정사용 예방을 위해 안전하게 차단됨
                </li>
                <li>사용자는 서비스에 등록하면서 개인의 소비 습관에 맞는 규칙(Rule)을 설정할 수 있습니다. <br>
                    특정 업종이나 지역, 시간대에 대한 거래를 차단하거나 허용하는 등의 세부 설정이 가능합니다. 이렇게 설정된 규칙에 따라 정상적인 거래는 원활히 이루어지며, 규칙과 다른 이상한 거래는 즉시 차단되어 사용자의 자산을 보호
                </li>
            </ul>
        </div>
    </div>
</div>
</body>
</html>

