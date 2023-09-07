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
    <link href="../../../resources/css/safetySetting.css" rel="stylesheet">
    <link href="../../../resources/css/common.css" rel="stylesheet">

</head>
<body>
<%@ include file="../include/header.jsp" %>
<div class="container">
    <div class="ok-head">선택하신 카드의 안심카츠 Self Rule 이 등록되었습니다.</div>
    <div class="ok-content">고객님께서 선택하신 카드는 안심카츠사용 Self Rule이 등록되어,</div>
    <div class="ok-content">설정하신 내용의 거래는 안전하게 차단됩니다.</div>
    <div class="ok-content">(오프라인 거래)</div>
    <button class="info-btn" onclick="window.location.href='/safetyCard/safetyCardStatus'"> 이용현황</button>

</div>
</body>
</html>
