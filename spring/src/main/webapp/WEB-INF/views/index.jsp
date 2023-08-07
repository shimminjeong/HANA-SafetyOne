<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Document</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <link href="../../resources/css/style.css" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
</head>
<body>
<h2>로그인</h2>
<form id="loginForm" method="post">
    <div>
        <label for="username">아이디</label>
        <input type="text" id="username" name="id">
    </div>
    <div>
        <label for="password">비밀번호</label>
        <input type="password" id="password" name="password">
    </div>
    <input type="button" class="button" value="로그인" onclick="loginFormFunc(); return false;">
    <input type="button" class="button" value="회원가입" onclick="joinFunc(); return false;">
    <a href="/selectAll">회원목록</a>
</form>
</body>
<script>
    function loginFormFunc() {
        var formData = $("#loginForm").serialize();
        var id = $("#username").val();
        var password = $("#password").val();

        $.ajax({
            type: "POST",
            url: "/loginMember",
            data: JSON.stringify({
                id: id,
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
                    link.href = "/mypage";
                    link.click();
                } else {
                    console.error("로그인 실패");
                }
            }
        });
    }

    function joinFunc(){
        var link = document.createElement("a");
        link.href = "/join";
        link.click();
    }

    // function selectAllFunc(){
    //     var link = document.createElement("a");
    //     link.href = "selectmember";
    //     link.click();
    // }

</script>
</html>