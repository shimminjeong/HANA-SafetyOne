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

    label {
        display: block;
        margin-bottom: 5px;
        font-weight: bold;
    }

    input[type="text"],
    input[type="password"] {
        width: 100%;
        padding: 10px;
        border: 1px solid #ccc;
        border-radius: 4px;
        font-size: 14px;
    }


    #rowinput {
        display: flex;
        flex-direction: column;
        align-items: flex-start; /* 아이템을 왼쪽으로 정렬 */
        margin-bottom: 20px;
    }

    .login-container {
        position: fixed; /* fixed positioning makes the container cover the entire viewport */
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        background-color: rgba(0, 0, 0, 0.7); /* semi-transparent black background */
        display: flex; /* flex display to center the formsize */
        align-items: center; /* center vertically */
        justify-content: center; /* center horizontally */
    }

    .loginForm {
        width: 40%;
        height: 50%;
        background-color: #ffffff; /* white background for the form */
        /*padding: 20px; !* spacing around the form content *!*/
        border-radius: 8px; /* rounded corners */
        box-shadow: 0 0 15px rgba(0, 0, 0, 0.3); /* subtle shadow for a lifted appearance */
        display: flex;
        flex-direction: row;
        align-items: center;
        justify-content: center;
    }

    .login-img-div{
        width: 50%;
        height: 100%;
        background-color: #00857F;
        margin: 0 auto;
        padding-right: 5%;
        border-radius:  8px 0px 0px 8px;
        display: flex;
        justify-content: center;
        align-items: center;

    }

    .login-input-div{
        width: 50%;
        padding-left: 5%;
        padding-right: 5%;

    }

    .login-img-div img{
        /*width: 100%;*/
        height: 50%;
        margin: 0 auto;
    }


</style>

<body>
<%@ include file="include/header.jsp" %>
<div class="login-container">
    <div class="loginForm">
        <div class="login-img-div">
            <img src="../../resources/img/payment.png">
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
            <button id="loginBtn" onclick="loginFormFunc()">로그인</button>
            <%--    <input type="button" class="button" value="회원가입" onclick="joinFunc(); return false;">--%>
            <button id="joinBtn">회원가입</button>
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
                    alert("로그인 성공");
                    location.href = "/";
                } else {
                    console.error("로그인 실패");
                }
            }
        });
    }

</script>
</html>
