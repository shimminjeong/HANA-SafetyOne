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
        <div id="logo" style="margin-top: 5px;">
            <a href="/">
                <img class="imgLogo" src="../../resources/img/SafetyOneLogo.svg">
            </a>
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
            <button id="loginBtn" onclick="toggleModal()">로그인</button>
            <button id="joinBtn" onclick="window.location.href='/join'">회원가입</button>
        </div>
        <%}%>
        <%--        <a href="/join">회원가입</a>--%>
    </div>
    <nav>
        <div class="navbar">
            <div class="dropdown">
                <button class="dropbtn" onclick="window.location.href='/safetyCard/'">안심서비스
                </button>
                <div class="dropdown-content">
                    <a href="/safetyCard/">서비스 등록 및 해제</a>
                    <a href="/safetyCard/">서비스 이용현황</a>
                    <a href="/safetyCard/safetyCardStop">서비스 일시정지</a>
                </div>
            </div>
            <div class="dropdown">
                <button class="dropbtn" onclick="window.location.href='/fds/'">이상소비알림서비스
                </button>

            </div>
            <div class="dropdown">
                <button class="dropbtn" onclick="window.location.href='/customCenter/lostCardSelect'">고객센터
                </button>
                <div class="dropdown-content">
                    <a href="/customCenter/lostCardSelect">분실/도난신고</a>
                    <a href="#">분실신고내역</a>
                </div>
            </div>
            <div class="dropdown">
                <button class="dropbtn" onclick="window.location.href='/mypage'">마이페이지
                </button>
                <div class="dropdown-content">
                    <a href="/mypageCardHistory/">카드이용내역</a>
                    <a href="/mypageReport">소비레포트</a>
                </div>
            </div>
        </div>
    </nav>
    <hr style="border:1px solid #00857F; margin: 0px;"/>
</header>
<div class="login-modal">
    <div class="login-container">
        <div class="loginForm">
            <div class="login-img-div">
                <img class="logo" src="../../resources/img/SafetyOneLogo.svg">
                <img class="cardImg" src="../../resources/img/SatetyOneCard.svg">
            </div>
            <div class="login-input-div">
                <div id="rowinput">
                    <label for="email">이메일</label>
                    <input type="text" id="email" name="email">
                </div>
                <div id="rowinput">
                    <label for="password">비밀번호</label>
                    <input type="password" id="password" name="password">
                </div>
                <button class="loginBtn" onclick="loginFormFunc()">로그인</button>
                <%--            <button class="joinBtn">회원가입</button>--%>
                <div class="passdiv">비밀번호 찾기 | 회원가입</div>
            </div>
        </div>
    </div>
</div>
<script>
    function toggleModal() {
        var modal = document.querySelector(".login-modal");
        modal.style.display = modal.style.display === "block" ? "none" : "block";
    }

    function loginFormFunc() {
        var email = $("#email").val();
        var password = $("#password").val();

        console.log("email:", email);
        console.log("Password:", password);

        $.ajax({
            type: "POST",
            url: "/loginMember",
            data: JSON.stringify({
                email: email,
                password: password
            }),
            contentType: 'application/json',
            error: function (xhr, status, error) {
                alert(error + "error");
            },
            success: function (response) {
                if (response === "로그인 성공") {
                    location.href = "/";
                } else {
                    console.error("로그인 실패");
                }
            }
        });
    }

</script>

</body>
</html>