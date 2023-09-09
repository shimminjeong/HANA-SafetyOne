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
    <%--    <script src="../../../resources/js/service.js" type="text/javascript"></script>--%>
    <link href="../../../resources/css/region.css" rel="stylesheet">
</head>
<style>
    .container {
        display: flex;
        flex-direction: row;
    }
    .sidebar {
        position: relative;
        width: 250px;
        top: 0px;
        left: -100px;
        padding: 80px 0px 80px 80px;
        overflow-y: auto;
        float: left;
    }

    li {
        list-style: none;
    }

    #lnb {
        position: relative;
        width: 200px;
    }

    #lnb > ul {
        padding: 0px;
        margin: 0px;
    }

    #lnb > ul > li {
        border-bottom: 1px solid #dcdcdc;
    }

    #lnb > ul > li > a {
        display: block;
        padding: 14px 35px 14px 15px;
        color: inherit;
        font-size: 18px;
        text-decoration: none;
    }

    #lnb > ul > li a:hover {
        color: #00b19a;
        text-decoration: none;
    }

    #lnb > ul > li ul {
        display: block;
    }

    #lnb > ul > li > ul > li > a {
        display: block;
        padding: 14px 25px 14px 14px;
        font-size: 16px;
        text-decoration: none;
    }

    #lnb > ul > li > ul > li > a {
        color: black;
        text-decoration: none;
    }

    #lnb > ul > li > ul li ul {
        display: block;
        padding-bottom: 8px;
        text-decoration: none;
    }

    #lnb > ul > li > ul li li a {
        display: block;
        padding: 14px 25px 10px 22px;
        color: #666;
        font-size: 12px;
        text-decoration: none;
    }

    #lnb > ul > li > ul > li li a:hover {
        color: #00b19a;
    }

    #lnb > ul li.noDepth a {
        background-image: none !important;
    }
</style>
<body>
<%@ include file="../include/header.jsp" %>
<div class="container">
<%--    <div class="sidebar">--%>
<%--        <div id="lnb">--%>
<%--            <ul>--%>
<%--                <li><a href="#none">안심카드서비스</a>--%>
<%--                    <ul style="border-top: 1px solid #dcdcdc;">--%>
<%--                        <li><a href="#none">카드 등록 및 해제</a></li>--%>
<%--                        <li><a href="#none">서비스 일시정지></a></li>--%>
<%--                        <li><a href="#none">이용현황</a></li>--%>
<%--                    </ul>--%>
<%--                </li>--%>
<%--                <li><a href="#none">이상소비알림서비스</a>--%>
<%--                    <ul style="border-top: 1px solid #dcdcdc;">--%>
<%--                        <li><a href="#none">카드 등록 및 해제</a></li>--%>
<%--                        <li><a href="#none">이용현황</a></li>--%>
<%--                    </ul>--%>
<%--                </li>--%>
<%--                <li><a href="#none">고객센터</a></li>--%>
<%--                <ul style="border-top: 1px solid #dcdcdc;">--%>
<%--                    <li><a href="#none">분실/도난신고</a></li>--%>
<%--                    <li><a href="#none">카드재발급</a></li>--%>
<%--                    <li><a href="#none">문의</a></li>--%>
<%--                </ul>--%>
<%--            </ul>--%>
<%--        </div>--%>
<%--    </div>--%>
    <div class="main">
        <h2>안심카드설정</h2>
        <h3>대상카드</h3>
        <hr>
        <div class="card-info">
            <div class="card-details">
                <span>본인 | </span>
                <span><%=session.getAttribute("cardId")%></span>
            </div>
            <div class="card-type">
                <span>알뜰교통 S20(체크)</span>
            </div>
        </div>
        <div class="sub-container">
            <ol class="c-stepper">
                <li class="c-stepper__item">
                    <h3 class="c-stepper__title">위치</h3>
                    <p class="c-stepper__desc">Some desc text</p>
                </li>
                <li class="c-stepper__item">
                    <h3 class="c-stepper__title">시간</h3>
                    <p class="c-stepper__desc">Some desc text</p>
                </li>
                <li class="c-stepper__item">
                    <h3 class="c-stepper__title">업종</h3>
                    <p class="c-stepper__desc">Some desc text</p>
                </li>
            </ol>
            <div class="formsize">
                지역
            </div>
        </div>
    </div>
</div>
</body>
</html>
