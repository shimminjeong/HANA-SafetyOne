<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>header</title>
    <link href="../../../resources/css/common.css" rel="stylesheet">
</head>
<body>
<header>
    <div id="headerLogo">
        <div id="logo">
            <img class="imgLogo" src="../../resources/img/logo.png" height="60">
            <a class="nameLogo" href="/">하나카드</a>
        </div>
        <%
            String email = (String) session.getAttribute("email");
            String name = (String) session.getAttribute("name");
            if (email != null) {%>
        <span id="welcomeMessage">
            <span><%= name %> 님 환영합니다</span>
            <a href="/logout"><button id="logoutBtn">로그아웃</button></a>
        </span>
        <% } else { %>
        <div id="loginout">
            <button id="loginBtn" onclick="window.location.href='/login'">로그인</button>
            <button id="joinBtn" onclick="window.location.href='/join'">회원가입</button>
        </div>
        <%}%>
        <%--        <a href="/join">회원가입</a>--%>
    </div>
    <nav>
        <div class="navbar">
            <a href="/safetyCard/">안심카드서비스</a>
            <a href="#">이상소비알림서비스</a>

            <%--            <a href="/service/fds">FDS</a>--%>


            <div class="dropdown">
                <button class="dropbtn">고객센터
                    <i class="fa fa-caret-down"></i>
                </button>
                <div class="dropdown-content">
                    <a href="/lostcard">분실/도난 신고</a>
                    <a href="#">부정사용신고</a>
                    <a href="#">카드재발급</a>
                </div>
            </div>
            <a href="/mypage">마이페이지</a>
<%--            <a href="/payment/paymentPage">결제</a>--%>
<%--            <a href="/payment/drawChartex">차트</a>--%>
        </div>
    </nav>
</header>

</body>
</html>
