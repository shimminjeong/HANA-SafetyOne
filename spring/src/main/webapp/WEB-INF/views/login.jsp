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
        margin-top: 120px;
        display: inline-block;
        color: black; /* 글자색 변경 */
        padding: 7px 20px; /* 패딩 */
        border: none; /* 테두리 없음 */
        border-radius: 5px; /* 둥근 모서리 */
        text-align: center;
        text-decoration: none;
        font-size: 12px; /* 폰트 크기 변경 */
        cursor: pointer;
        background-color: #ffffff; /* 배경색 추가 */
        transition: background-color 0.3s, transform 0.3s; /* 부드러운 전환 효과 추가 */
        box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1); /* 그림자 추가 */
        display: flex;
        flex-direction: row;
        justify-content: space-between;
        align-items: center;
    }

    .login > * {
        margin-right: 20px; /* 각 요소의 오른쪽에 마진 추가 */
    }

    #loginForm {

        width: 250px;
        margin: 50px auto;
        padding: 20px;
        border: 1px solid #ddd;
        border-radius: 5px;
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    }

    #loginForm div {
        margin-bottom: 20px;
    }

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



</style>

<body>
<%@ include file="include/header.jsp" %>
<div class="container">
    <div class="formsize">
        <img src="../../resources/img/payment.gif" height="250" class="imgLoginForm">
        <form id="loginForm" method="post">
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
