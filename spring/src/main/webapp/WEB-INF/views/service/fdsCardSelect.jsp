<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
    <title>Title</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <link href="../../../resources/css/common.css" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
    <link href="../../../resources/css/cardSelectCommon.css" rel="stylesheet">
</head>
<body>
<%@ include file="../include/header.jsp" %>
<div class="container">
    <div class="content-div">
        <div class="content-div-header">
            <h2>이상소비 알림서비스</h2>
            <h3>이상소비 알림서비스 이용현황</h3>
            <h4>설정할 카드를 선택 후 [등록] 또는 [해제]를 선택해주세요</h4></ㅗ4>
        </div>
        <c:forEach items="${cards}" var="card" varStatus="loop">
            <div class="lostcard-list">
                <div class="card-list-info" id="${card.cardId}">
                    <div class="card-list-info-img-div">
                        <img src="../../../resources/img/circle.png" onclick="changeImage(this, '${card.cardId}')">
                    </div>
                    <div class="card-list-info-cardid">${card.cardId}</div>
                    <div class="card-list-info-name">본인&nbsp;&nbsp;|&nbsp;&nbsp;<%= name %>&nbsp;&nbsp;|&nbsp;&nbsp;
                    </div>
                    <div class="card-list-info-cardname">yolo</div>
                    <img class="card-img" src="../../../resources/img/cardImg${loop.index + 1}.png">
                    <c:if test="${card.fdsSerStatus eq 'Y'}">
                        <img class="lock-img" src="../../../resources/img/notification.png">
                    </c:if>
                    <c:if test="${card.fdsSerStatus eq 'N'}">
                        <img class="lock-img" src="../../../resources/img/silent.png">
                    </c:if>
                </div>
            </div>
        </c:forEach>
    </div>
    <div class="ajax-content"></div>
    <div class="reg-cancle-btn">
        <button class="cancle-Btn" onclick="cancleCard()">해제</button>
        <button class="reg-Btn" onclick="registerCard()">등록</button>
    </div>
</div>
</body>
<script>

    let selectedCardId = '';

    function changeImage(imgElement, cardId) {
        // 이미지 경로가 circle.png인 경우 circle2.png로 변경
        if (imgElement.src.endsWith('circle.png')) {
            imgElement.src = "../../../resources/img/check-mark.png";
            // cardId를 selectedCardIds에 추가
            selectedCardId = cardId;
        } else { // 이미지 경로가 circle2.png인 경우 circle.png로 변경
            imgElement.src = "../../../resources/img/circle.png";
            selectedCardId = ''
        }
        console.log("selectedCardId", selectedCardId);
    }

    function registerCard() {

        console.log("Selected card ID:", selectedCardId);
        $.ajax({
            url: '/fds/registerCard',
            type: 'POST',
            data: selectedCardId,
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

        console.log("Selected card ID:", selectedCardId); // cardId 출력
        $.ajax({
            url: '/fds/cancleCard',
            type: 'POST',
            data: selectedCardId,
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


