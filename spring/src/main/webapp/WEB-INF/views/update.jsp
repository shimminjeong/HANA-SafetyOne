<%--
  Created by IntelliJ IDEA.
  User: pooh5
  Date: 2023-08-08
  Time: 오전 1:13
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head>
    <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
    <title>Title</title>
</head>
<body>
<h2>회원정보수정</h2>
<form id="updateForm" method="post">
    <p>아이디 : ${member.id}</p>
    <input type="hidden" name="id" value="${member.id}">
    <p>이름 : <input type="text" name="name" value="${member.name}"></p>
    <p>비밀번호 : <input type="text" name="password" value="${member.password}"></p>
    <p>이메일 : <input type="text" name="email" value="${member.email}"></p>
    <p>전화번호 : <input type="text" name="phone" value="${member.phone}"></p>
    <input type="button" class="button" value="수정완료" onclick="updateFormFunc(); return false;">
</form>
</body>
<script>
    function updateFormFunc(){
        const form = document.getElementById('updateForm');
        const formData = new FormData(form);
        const jsonData = {};

        //input으로 넘기는것만 가능
        formData.forEach((value, key) => {
            jsonData[key] = value;
        });

        // jsonData를 JSON 문자열로 변환
        const jsonString = JSON.stringify(jsonData);

        // AJAX 요청으로 데이터를 서버로 전송
        $.ajax({
            type: 'POST', // 요청 방식 (POST, GET 등)
            url: '/updateMember', // 요청을 보낼 서버의 URL
            data: jsonString, // 변환된 JSON 데이터를 전송
            contentType: 'application/json', // 전송 데이터 타입을 JSON으로 지정
            success: function (response) {
                if (response === "회원 수정 성공") {
                    alert("회원 수정 성공");
                    var link = document.createElement("a");
                    link.href = "/mypage";
                    link.click();
                } else {
                    console.error("회원 수정 실패");
                }
            }
        });

    }
</script>
</html>
