<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Title</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <link href="../../resources/css/common.css" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
</head>
<style>




</style>

<body>
<%@ include file="include/header.jsp" %>
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
<%--<%@ include file="include/footer.jsp" %>--%>
</body>
<script>
    function loginFormFunc() {
        var email = $("#email").val();
        var password = $("#password").val();

        console.log("email:", email); // 아이디 확인
        console.log("Password:", password); // 비밀번호 확인

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
</html>
