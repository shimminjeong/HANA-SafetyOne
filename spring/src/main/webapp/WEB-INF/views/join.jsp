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
        <label for="email">이메일</label>
        <input type="text" id="email" name="email">
    </div>
    <div>
        <label for="name">이름</label>
        <input type="text" id="name" name="name">
    </div>
    <div>
        <label for="password">비밀번호</label>
        <input type="password" id="password" name="password">
    </div>
    <div>
        <label for="phone">핸드폰</label>
        <input type="text" id="phone" name="phone">
    </div>
    <div>
        <label for="sex">성별</label>
        <input type="text" id="sex" name="sex">
    </div>
    <div>
        <label for="address">주소</label>
        <input type="text" id="address" name="address">
    </div>
    <div>
        <label for="identityNum">주민등록번호</label>
        <input type="text" id="identityNum" name="identityNum">
    </div>
    <input type="button" class="button" value="회원가입신청" onclick="joinFormFunc(); return false;">
</form>
</body>
<script>
    function joinFormFunc(){
        const form = document.getElementById('joinForm');
        const formData = new FormData(form);
        const jsonData = {};

        formData.forEach((value, key) => {
            jsonData[key] = value;
        });

        // jsonData를 JSON 문자열로 변환
        const jsonString = JSON.stringify(jsonData);

        // AJAX 요청으로 데이터를 서버로 전송
        $.ajax({
            type: 'POST', // 요청 방식 (POST, GET 등)
            url: '/joinMember', // 요청을 보낼 서버의 URL
            data: jsonString, // 변환된 JSON 데이터를 전송
            contentType: 'application/json', // 전송 데이터 타입을 JSON으로 지정
            success: function (response) {
                if (response === "회원 등록 성공") {
                    alert("회원 등록 성공");
                    var link = document.createElement("a");
                    link.href = "/";
                    link.click();
                } else {
                    console.error("회원 등록 실패");
                }
            }
        });
    }
</script>
<%--<script>--%>

<%--    function joinForm(){--%>
<%--    $(document).ready(function() {--%>
<%--        $("#joinForm").submit(function (event) {--%>

<%--        const id = $("#id").val();--%>
<%--        const password = $("#password").val();--%>
<%--        const name = $("#name").val();--%>
<%--        const email = $("#email").val();--%>
<%--        const phone = $("#phone").val();--%>

<%--        const data = {--%>
<%--            id: id,--%>
<%--            password: password,--%>
<%--            name: name,--%>
<%--            email: email,--%>
<%--            phone: phone--%>
<%--        }--%>

<%--        $.ajax({--%>
<%--            type: "POST",--%>
<%--            url: "/joinMember",--%>
<%--            data: JSON.stringify(data),--%>
<%--            contentType: 'application/json',--%>
<%--            success: function (response) {--%>
<%--                if (response === "회원등록성공") {--%>
<%--                    alert("회원가입 성공");--%>
<%--                    var link = document.createElement("a");--%>
<%--                    link.href = "/";--%>
<%--                    link.click();--%>
<%--                } else {--%>
<%--                    console.error("회원가입 실패");--%>
<%--                }--%>

<%--            }--%>
<%--        });--%>
<%--    });--%>
<%--    });--%>
<%--    }--%>
<%--</script>--%>
</html>
