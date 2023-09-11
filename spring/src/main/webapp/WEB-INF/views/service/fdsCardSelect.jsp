<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
    <title>Title</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <link href="../../../resources/css/common.css" rel="stylesheet">
    <link href="../../../resources/css/fdsCardSelect.css" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
</head>
<style>



</style>

<body>
<%@ include file="../include/header.jsp" %>
<div class="container">
    <div class="formsize">
        <div class="content-div">
            <h1>이상소비알림서비스</h1>
            <h2>이상소비알림서비스 이용현황</h2>
            <h3>설정할 카드를 선택 후 [등록] 또는 [해제]를 선택해주세요</h3></ㅗ4>
        </div>
        <div class="card-list">
            <c:forEach items="${cards}" var="card" varStatus="loop">
                <div class="accordion" id="${card.cardId}">
                    <div>
                        <input type="checkbox" name="selectedCards" value="${card.cardId}">
                    </div>
                    <div>본인 | ${card.cardId}</div>
                    <img class="card-img" src="../../../resources/img/cardImg${loop.index + 1}.png">
                    <c:if test="${card.fdsSerStatus eq 'Y'}">
                        <img class="lock-img" src="../../../resources/img/padlock.png">
                    </c:if>
                    <c:if test="${card.fdsSerStatus eq 'N'}">
                        <img class="lock-img" src="../../../resources/img/unlock.png">
                    </c:if>
                </div>
            </c:forEach>
        </div>
        <div class="ajax-content"></div>
        <div class="reg-cancle-btn">
            <button class="cancle-Btn" onclick="cancleCard()">해제</button>
            <button class="reg-Btn" onclick="registerCard()">등록</button>
        </div>
    </div>
</div>
</body>
<script>

    function registerCard() {
        const selectedCards = document.querySelectorAll('input[name="selectedCards"]:checked');
        const selectedIds = Array.from(selectedCards).map(card => card.value).join(',');

        console.log("Selected card ID:", selectedIds);
        $.ajax({
            url: '/fds/registerCard',
            type: 'POST',
            data: selectedIds,
            contentType: 'application/json',
            success: function (response) {
                const ajaxContent = document.querySelector('.ajax-content');
                if (response === "이상 소비 알림 서비스 신청 성공") {
                    openSelectModal();
                } else
                    ajaxContent.textContent = "이미 신청이 완료된 카드입니다.";
                ajaxContent.style.color = "red";
                selectedCards.forEach(card => {
                        card.checked = false; // 이미 체크된 카드 체크 해제
                    }
                )
                ;
            }
        });
    }


    function cancleCard(cardId) {
        const selectedCards = document.querySelectorAll('input[name="selectedCards"]:checked');
        const selectedIds = Array.from(selectedCards).map(card => card.value).join(',');
        console.log("Selected card ID:", selectedIds); // cardId 출력
        $.ajax({
            url: '/fds/cancleCard',
            type: 'POST',
            data: selectedIds,
            contentType: 'application/json',
            success: function (response) {
                const ajaxContent = document.querySelector('.ajax-content');
                if (response === "이상 소비 알림 서비스 해제 성공") {
                    ajaxContent.textContent = "이상 소비 알림 서비스가 해제되었습니다.";
                    ajaxContent.style.color = "green";
                } else

                    ajaxContent.textContent = "이 카드는 해당 서비스 신청내역이 존재하지 않습니다.";
                ajaxContent.style.color = "red";
                selectedCards.forEach(card => {
                    card.checked = false; // 이미 체크된 카드 체크 해제
                });
            }
        });
    }

</script>
</html>


