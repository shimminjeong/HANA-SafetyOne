<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Title</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <link href="../../../resources/css/common.css" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
</head>
<style>


    .serviceTitle {
        font-size: 24px;
        font-weight: bold;
        margin-bottom: 20px;
    }

    .container {

    }

    .selffds {
        border: 1px solid #ccc;
        padding: 20px;
        border-radius: 10px;
        background-color: #f5f5f5;
        text-align: center;
    }


    .sub-tit {
        font-size: 18px;
        font-weight: bold;
        margin-bottom: 10px;
    }


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
<div class="container">
    <div class="serviceTitle">이상소비패턴탐지(FDS)</div>
    <div class="selffds">
        <div class="sub-tit">이상소비패턴 탐지 서비스</div>
        <div class="sub-txt">나와 비슷한 소비패턴을 가진 사람들과 함께 알림 서비스</div>
        <div class="btn_wrap">
            <button type="button" class="regBtn" onclick="FdsReg()">등록/해제</button>
        </div>
    </div>
    <div class="service_wrap">
        <div class="h_wrap">FDS 서비스란?</div>
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
<script>
    function fdsreg() {
        window.location.href = "/cardSelect.jsp";
    }
</script>

</body>
</html>
