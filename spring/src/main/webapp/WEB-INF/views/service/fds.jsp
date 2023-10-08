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

<%@ include file="../include/header.jsp" %>
<div class="container">
    <div id="service">
        <div class="serviceTitle"><img src="../../../resources/img/bell.png"/><div>이상소비 알림서비스</div></div>
        <div class="service-content2">
            <div class="text_div">
                <p><div class="sub-tit">실시간 금융 보호를 위한 알림 서비스</div><br>
                <div class="sub-txt">기존의 소비 패턴과 다른 이상한 거래를 즉시 감지하여 알림을 보내드립니다.</div></p>
            </div>
            <a href="/fds/fdsCardSelect">
                <button class="regBtn" style="background-color:#9385d7;">신청/해제</button>
            </a>
        </div>
        <div class="service_wrap">
            <div class="h_wrap">이상소비 알림서비스란?</div>
            <ul class="marker_dot">
                <li>이 서비스는 사용자의 일반적인 소비 패턴과 다른 의심스러운 거래를 즉시 감지하여 알림을 제공하는 서비스입니다. <br>
                    사용자의 카드 사용 패턴과 다른 업종, 지역, 시간대에서 발생하는 거래를 중심으로, 이상소비를 즉시 탐지하고 사용자에게 알려줍니다.
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
