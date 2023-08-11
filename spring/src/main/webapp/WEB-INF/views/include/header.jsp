<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>header</title>
    <style>
        .nav-list {
            list-style: none;
            padding: 0;
            margin: 0;
            background-color: #00857F;
            overflow: hidden;
        }

        .nav-item {
            float: left;
        }

        .nav-menu {
            display: block;
            color: white; /* 글자색 설정 */
            text-align: center;
            padding: 14px 16px;
            text-decoration: none;
        }

    </style>
</head>
<body>
<header>

    <div>
        <img src="../../resources/img/logo.png" height="50">
        <span>하나카드</span>
        <a href="/login">로그인</a>
        <a href="/logout">로그아웃</a>
        <a href="/join">회원가입</a>

    </div>
    <nav>
        <ul class="nav-list">

            <li class="nav-item">
                <a href="main" class="nav-menu">서비스안내</a>
            </li>
            <li class="nav-item">
                <a href="selffds" class="nav-menu">안심결제서비스</a>
            </li>
            <li class="nav-item">
                <a href="customerservice" class="nav-menu">고객센터</a>
            </li>
            <li class="nav-item">
                <a href="/mypage" class="nav-menu">마이페이지</a>
            </li>
        </ul>
    </nav>

</header>

</body>
</html>
