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
            <a href="/logout"><button>로그아웃</button></a>
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
        <ul class="nav-list">
            <li class="nav-item">
                <a href="/service/serviceInfo" class="nav-menu">안심결제서비스</a>
            </li>
            <li class="nav-item">
                <a href="/lostcard" class="nav-menu">고객센터</a>
            </li>
            <li class="nav-item">
                <a href="/mypage" class="nav-menu">마이페이지</a>
            </li>
        </ul>
    </nav>

</header>

</body>
</html>
