<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Document</title>
    <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
    <link rel="stylesheet" href="../../../resources/css/member/modalStyle.css"/>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
</head>
<body>
<div class="auth-container">
    <div class="auth-header">본인인증</div>
    <div class="auth-content">
        <div class="content-row">
            <div class="content-div-header" style="margin: auto 0;">이름</div>
            <div class="content-div-input"><input type="text" placeholder="이름 입력"></div>
        </div>
        <div class="content-row">
            <div class="content-div-header">휴대전화</div>
            <div class="content-div-phone">
                <div class="agree-form">
                    <div class="accordion-header">
                        <span class="toggle-icon">V</span>
                        본인인증 약관 전체동의
                        <span class="accordion-indicator">▼</span>
                    </div>

                    <div class="accordion-content">
                        <hr>
                        <div><span class="toggle-icon">v</span> 개인정보 제공 및 이용</div>
                        <div><span class="toggle-icon">v</span> 고유식별 정보처리</div>
                        <div><span class="toggle-icon">v</span> 통신사 이용약관</div>
                    </div>
                </div>
                <div class="phone-div">
                    <div class="company-select">
                        <select>
                            <option value="skt" selected>SKT</option>
                            <option value="lg">LG</option>
                            <option value="kt">KT</option>
                        </select>
                    </div>
                    <div class="phone-select">
                        <select>
                            <option value="010" selected>010</option>
                            <option value="070">070</option>
                            <option value="012">012</option>
                            <option value="031">031</option>
                        </select>
                    </div>
                    <div class="number"><input type="text" placeholder="'-' 제외하고 입력"></div>
                    <div class="btn-div">
                        <button class="send-authNumber">인증번호 받기</button>
                    </div>
                </div>
                <div class="auth-number-input"><input type="text" placeholder="인증번호 숫자만 6자리 입력"></div>
            </div>
        </div>
    </div>
    <button class="auth-confirm">확인</button>
</div>
<script>
    document.querySelector('.accordion-header').addEventListener('click', function() {
        const content = document.querySelector('.accordion-content');
        const indicator = document.querySelector('.accordion-indicator');
        if (content.style.display === "none" || !content.style.display) {
            content.style.display = "block";
            indicator.style.transform = "rotate(180deg)";
        } else {
            content.style.display = "none";
            indicator.style.transform = "rotate(0deg)";
        }
    });

</script>
</body>

</html>
