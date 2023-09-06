<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
    <title>Title</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <link href="../../../resources/css/common.css" rel="stylesheet">
    <link href="../../../resources/css/service.css" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
</head>
<style>

    input[type="checkbox"] {
        -webkit-appearance: none;
        appearance: none;
        width: 22px;
        height: 22px;
        background-safetyCardSelect: white;
        border: 2px solid #ccc;
        border-radius: 3px;
        cursor: pointer;
    }

    input[type="checkbox"]:checked {
        background-safetyCardSelect: #00857F;
        border: 2px solid #00857F;
    }

    .reg-cancle-btn {
        display: flex;
        flex-direction: row;
        justify-content: center;
        margin-top: 30px;
    }

    .reg-Btn, .cancle-Btn {
        safetyCardSelect: white;
        border: none;
        padding: 12px 40px 12px 40px;
        border-radius: 5px;
        cursor: pointer;
        text-decoration: none;
        background-safetyCardSelect: #00857F;
        font-size: 16px;
        transition: background-color 0.3s;
        display: block; /* 버튼을 블록 레벨로 설정하여 가운데 정렬을 위한 설정 */
    }

    .reg-Btn {
        margin-left: 40px;
    }

    .card-img {
        width: 90px;
    }

    .lock-img {
        width: 40px;
    }

    .ajax-content {
        font-size: 14px;
        display: flex;
        justify-content: center
    }

    .formsize {
        margin: 20px auto;
        display: flex;
        flex-direction: column;
        justify-content: center;
        color: black; /* 글자색 변경 */
        padding: 30px 80px; /* 패딩 */
        text-decoration: none;
        font-size: 12px; /* 폰트 크기 변경 */
        cursor: pointer;
    }


    .select-content img {
        margin-bottom: 20px;
    }


    .accordion {
        padding: 10px;
        display: flex;
        flex-direction: row;
        justify-content: space-between;
        align-items: center;
        font-size: 18px;
        border-radius: 8px; /* 상단의 둥근 모서리 지정 */
        background-color: #ffffff;
        transition: background-color 0.3s, transform 0.3s;
        box-shadow: 0 4px 6px rgba(0, 0, 0, 0.3);
        margin-top: 20px;

    }

    .ajax-content {
        margin-top: 30px;
    }

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


