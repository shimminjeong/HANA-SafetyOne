<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
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
<%@ include file="include/header.jsp" %>
<h2>main</h2>
<%
    String name = (String) session.getAttribute("name");
    String id = (String) session.getAttribute("id");
    if (name != null) { %>
<span><%= name %> 님 환영합니다</span>
<span><%= id %> 님 환영합니다</span>
<% } %>
<%@ include file="include/footer.jsp" %>
</body>
</html>