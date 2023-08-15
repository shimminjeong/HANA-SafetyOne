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
    .login{
        display: flex;
        justify-content: space-between;
        align-items: center;
    }
</style>

<body>
<%@ include file="include/header.jsp" %>
<div class="container">
    <div class="login">
        <img src="../../resources/img/payment.gif" height="200" class="imgLoginForm">
        <form id="loginForm" method="post">
            <div>
                <label for="email">이메일</label>
                <input type="text" id="email" name="email">
            </div>
            <div>
                <label for="password">비밀번호</label>
                <input type="password" id="password" name="password">
            </div>
            <input type="button" class="button" value="로그인" onclick="loginFormFunc(); return false;">
            <%--    <input type="button" class="button" value="회원가입" onclick="joinFunc(); return false;">--%>
            <a href="/selectAll">회원목록</a>
        </form>
    </div>
</div>
<%--<%@ include file="include/footer.jsp" %>--%>
</body>
<script>
    function loginFormFunc() {
        var formData = $("#loginForm").serialize();
        var email = $("#email").val();
        var password = $("#password").val();

        console.log("FormData:", formData); // 전체 폼 데이터 확인
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
                    alert("로그인 성공");
                    var link = document.createElement("a");
                    link.href = "/";
                    link.click();
                } else {
                    console.error("로그인 실패");
                }
            }
        });
    }

</script>
</html>
