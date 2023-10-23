<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <%--    <link href="../../../resources/css/regionspot.css" rel="stylesheet">--%>
    <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/chart.js@3.5.1/dist/chart.min.js"></script>
    <link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
    <link href="../../../resources/css/member/safetySetting.css" rel="stylesheet">
    <link href="../../../resources/css/common.css" rel="stylesheet">

</head>
<style>
    .container{
        display: flex;
        flex-direction: column;
        align-items: center;
        margin-top:7%;
    }
    .container > img{
        width: 5%;
    }

    .ok-head {
        margin-top: 38px;
        margin-bottom: 20px; /* 제목 아래의 마진을 추가합니다. */
        font-size:25px;
    }

    .ok-content {
        margin-bottom: 10px; /* 각 내용 아래의 마진을 추가합니다. */
    }

    .info-btn {
        margin-top: 20px; /* 버튼 위의 마진을 추가합니다. */
    }

    .info-btn{
        border: none;
        padding: 12px 40px 12px 40px;
        border-radius: 5px;
        cursor: pointer;
        text-decoration: none;
        background-color: #00857F;
        color: white;
        font-size: 16px;
        transition: background-color 0.3s;
        display: block; /* 버튼을 블록 레벨로 설정하여 가운데 정렬을 위한 설정 */
    }

</style>
<body>
<%@ include file="../include/header.jsp" %>
<div class="container">
        <img src="../../../resources/img/ico_mybenefit.png" alt="Checkmark">
    <div class="ok-head">선택하신 카드의 안심설정이 등록되었습니다.</div>
    <div class="ok-content">고객님께서 선택하신 카드는 안심서비스로 등록되어,</div>
    <div class="ok-content">설정하신 내용의 거래는 안전하게 차단됩니다.</div>
<%--    <div class="ok-content">(오프라인 거래)</div>--%>
<%--    <button class="info-btn" onclick="window.location.href='/safetyCard/safetyCardSelect'"> 이용현황</button>--%>
</div>
</body>
</html>
