<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<header class="header">
    <div id="headerLogo">
        <div id="logo">
            <img class="imgLogo" src="../../resources/img/logo.png" height="60">
            <a class="nameLogo" href="/admin/">SafetyOne</a>
        </div>
        <%
            String email = (String) session.getAttribute("email");
            String name = (String) session.getAttribute("name");
            if (email != null) {%>
        <span class="welcomeMessage">
            <img src="../../../resources/img/admin.png">
            <span><%= name %> 관리자님 환영합니다</span>
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
</header>