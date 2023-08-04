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
<h2> 회원가입</h2>
<form id="joinForm" method="post">
    <div>
        <label for="id">아이디</label>
        <input type="text" id="id" name="id">
    </div>
    <div>
        <label for="password">비밀번호</label>
        <input type="password" id="password" name="password">
    </div>
    <div>
        <label for="name">이름</label>
        <input type="text" id="name" name="name">
    </div>
    <div>
        <label for="email">이메일</label>
        <input type="text" id="email" name="email">
    </div>
    <div>
        <label for="phone">핸드폰</label>
        <input type="text" id="phone" name="phone">
    </div>
    <input type="submit" class="button" value="회원가입신청">

</form>
</body>
<script>

    function joinForm(){
    $(document).ready(function() {
        $("#joinForm").submit(function (event) {

        const formData = $("#joinForm").serialize();
        const id = $("#id").val();
        const password = $("#password").val();
        const name = $("#name").val();
        const email = $("#email").val();
        const phone = $("#phone").val();

        const data = {
            id: id,
            password: password,
            name: name,
            email: email,
            phone: phone
        }

        $.ajax({
            type: "POST",
            url: "/joinMember",
            data: JSON.stringify(data),
            contentType: 'application/json',
            error: function (xhr, status, error) {
                alert(error + "error");
            },
            success: function (response) {
                if (response === "회원가입 성공") {
                    alert("회원가입 성공");
                    var link = document.createElement("a");
                    link.href = "/";
                    link.click();
                } else {
                    console.error("회원가입 실패");
                }

            }
        });
    });
    });
    }
</script>
</html>
