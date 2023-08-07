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
<style>
    .container {
        margin: 20px;
    }

    table {
        width: 100%;
        border-collapse: collapse;
    }

    thead th {
        background-color: #f2f2f2;
        border: 1px solid #ccc;
        padding: 8px;
        text-align: left;
    }

    tbody td {
        border: 1px solid #ccc;
        padding: 8px;
    }

    /* Apply alternating row colors for better readability */
    tbody tr:nth-child(even) {
        background-color: #f2f2f2;
    }

    /* Add hover effect to the table rows */
    tbody tr:hover {
        background-color: #ddd;
    }
</style>
<body>
<div class="container">
    <div>
        <table>
            <thead>
            <tr>
                <th>아이디</th>
                <th>비밀번호</th>
                <th>이름</th>
                <th>이메일</th>
                <th>핸드폰</th>
                <th>삭제</th>

            </tr>
            </thead>
            <tbody>
            <c:forEach items="${members}" var="member">
                <tr>
                    <td>${member.id}</td>
                    <td>${member.password}</td>
                    <td>${member.name}</td>
                    <td>${member.email}</td>
                    <td>${member.phone}</td>
                    <td>
                        <button class="delete-button" onclick="deleteMember('${member.id}')">삭제</button>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
</div>
</body>
<script>
    function deleteMember(memberId){
        $.ajax({
            url: '/deleteMember',
            type: 'POST',
            data: memberId,
            contentType: 'application/json',
            success: function(response) {
                if (response === "회원 삭제 성공") {
                    alert("회원 삭제 성공");
                    window.location.href = '/selectAll';
                } else
                console.error('회원 삭제 실패');
            }
        });
    }


</script>

</html>
