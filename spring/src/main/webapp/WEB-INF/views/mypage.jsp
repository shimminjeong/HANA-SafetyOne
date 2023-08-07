<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Document</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
</head>
<body>
<p>아이디 : <%=session.getAttribute("id")%></p>
<p>이름 :${member.name}</p>
<p>이메일 : ${member.email}</p>
<p>전화번호 : ${member.phone}</p>
<a href="update">회원정보수정</a>
</body>
</html>
