<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Title</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <link href="../../../resources/css/common.css" rel="stylesheet">
    <link href="../../../resources/css/subnav.css" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
</head>
<style>


    /* Service Title styles */
    .serviceTitle {
        font-size: 24px;
        font-weight: bold;
        margin-bottom: 20px;
    }

    .container {

    }

    /* Self FDS (안심설정) styles */
    .selffds {
        border: 1px solid #ccc;
        padding: 20px;
        border-radius: 10px;
        background-color: #f5f5f5;
        text-align: center;
    }

    /* Sub Title styles */
    .sub-tit {
        font-size: 18px;
        font-weight: bold;
        margin-bottom: 10px;
    }

    /* Sub Text styles */
    .sub-txt {
        font-size: 14px;
        color: #555;
        margin-bottom: 20px;
    }

    /* Button styles */
    .regBtn {
        background-color: #00857F;
        color: #fff;
        border: none;
        padding: 10px 20px;
        border-radius: 5px;
        cursor: pointer;
        font-size: 16px;
        transition: background-color 0.3s;
    }

</style>

<body>
<%@ include file="../include/header.jsp" %>
<%--<div class="subnav-container">--%>
<%--    <ul class="subnav">--%>
<%--        <li>--%>
<%--            <a href="/service/selffds">SELFFDS서비스</a>--%>
<%--        </li>--%>
<%--        <li>--%>
<%--            <a href="/service/fds">FDS서비스</a>--%>
<%--        </li>--%>
<%--    </ul>--%>
<%--</div>--%>
<div class="container">

    <div class="serviceTitle">카드사용안심설정(Self FDS)</div>
    <div class="selffds">
        <div class="sub-tit">안전한 결제를 위한 안심설정 서비스</div>
        <div class="sub-txt">결제 차단 지역, 시간, 업종 등 나만의 Rule을 간편하게 설정</div>
        <div class="btn_wrap">
            <a href="/service/cardSelect"><button type="button" class="regBtn">등록/해제</button></a>
        </div>
    </div>
    <div class="service_wrap">
        <div class="h_wrap">Self FDS 서비스란?</div>
        <ul class="marker_dot">
            <li>안전한 카드 사용을 위한 통합 서비스로서, 카드별로 해외거래를 일시적으로 차단(해외 일시정지)하거나, 사용가능기간, 국가, 금액 등을 간편하게 설정(맞춤 사용)하여 카드 위조, 도난,
                분실 등 해외 부정사용으로부터 카드를 더 안전하게 관리할 수 있도록 돕는 서비스입니다.
            </li>
            <li>서비스 등록 시점부터 고객이 직접 설정한 Rule에 따라(선택카드, 사용가능기간, 국가, 1회 결제가능금액 등) 해외사용이 가능하며, 그 이외의 해외거래는 부정사용 예방을 위해 안전하게
                차단됨
            </li>
        </ul>
        <p class="marker_refer">
            ※ 해외부정거래 차단서비스 등록을 해주시면 해외를 가실 때 마다 Self FDS설정할 필요 없이 로밍 정보를 활용해 자동으로 해외 현지(MS)거래를 ON/OFF시켜드립니다.
        </p>
    </div>
</div>
<%--<%@ include file="include/footer.jsp" %>--%>
</body>
</html>
