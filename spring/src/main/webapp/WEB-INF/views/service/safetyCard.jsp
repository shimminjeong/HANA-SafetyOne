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
        <div class="serviceTitle"><h3>안심카드</h3></div>
        <div class="service-content">
            <div class="text_div">
                <p><div class="sub-tit">안전한 결제를 위한 안심카드설정 서비스</div><br>
                    <div class="sub-txt">결제 차단 지역, 시간, 업종 등 나만의 Rule을 간편하게 설정</div></p>
            </div>
            <a href="/safetyCard/safetyCardSelect">
                <button class="regBtn">등록/해제</button>
            </a>
        </div>
        <div class="service_wrap">
            <div class="h_wrap">안심 카드 서비스란?</div>
            <ul class="marker_dot">
                <li>안전한 카드 사용을 위한 통합 서비스로서, 카드별로 간편하게 설정(맞춤 사용)하여 업종, 지역, 시간 등의 거래를 차단해 <br>
                    카드 위조, 도난, 분실 등 부정사용으로부터 카드를 더 안전하게 관리할 수 있도록 돕는 서비스입니다.
                </li>
                <li>서비스 등록 시점부터 고객이 직접 설정한 Rule에 따라 (업종, 지역, 시간 등) 거래가 차단되며 <br>
                    필요시 특정 기간동안 거래를 허용하는 서비스를 제공함. 이외의 거래는 부정사용 예방을 위해 안전하게 차단됨
                </li>
            </ul>
            <%--            <p class="marker_refer">--%>
            <%--                ※ 해외부정거래 차단서비스 등록을 해주시면 해외를 가실 때 마다 Self FDS설정할 필요 없이 로밍 정보를 활용해 자동으로 해외 현지(MS)거래를 ON/OFF시켜드립니다.--%>
            <%--            </p>--%>
        </div>
    </div>
</div>
</body>
</html>
