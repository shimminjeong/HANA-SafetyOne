<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"
          name="viewport" content="width=device-width, initial-scale=1"/>
    <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
    <link href="../../../resources/css/common.css" rel="stylesheet">
    <link href="../../../resources/css/lostcard.css" rel="stylesheet">
</head>
<body>
<%@ include file="../include/header.jsp" %>

<div class="active-container">
    <div class="cont_box_area">
        <nav class="tab_ty02">
            <li class="on"><a href="#" title="현재 선택 탭">카드분실/도난신고</a></li>
            <li><a href="#">카드분실신고해제</a></li>
            <li><a href="#">카드분실신고내역</a></li>
        </nav>
        <div class="lost-header"><h2>카드를 선택해주세요</h2></div>
        <c:forEach items="${cards}" var="card" varStatus="loop">
            <div class="lostcard-list">
                <div class="card-list-info" id="${card.cardId}">
                    <div class="card-list-info-img-div">
                            <%--                        <input type="checkbox" name="selectedCards" value="${card.cardId}">--%>
                        <img src="../../../resources/img/circle.png" onclick="changeImage(this, '${card.cardId}')">
                    </div>
                    <div class="card-list-info-cardid">${card.cardId}</div>
                    <div class="card-list-info-name">본인&nbsp;&nbsp;|&nbsp;&nbsp;<%= name %>&nbsp;&nbsp;|&nbsp;&nbsp;
                    </div>
                    <div class="card-list-info-cardname">yolo</div>
                    <img class="card-img" src="../../../resources/img/cardImg${loop.index + 1}.png">
                </div>
                <hr>
                <div class="reissued">
                    <span>재발급 신청 여부</span>
                    <button id="btn-ok" class="reissued-ok" onclick="setReissued('Y', this)">신청</button>
                    <button id="btn-no" class="reissued-no" onclick="setReissued('N', this)">신청 안 함</button>
                </div>
            </div>
        </c:forEach>
    </div>
    <button class="registerLostBtn" onclick="registerLostCard()">다음</button>
</div>
</body>
<script>

    let selectedCardId = '';
    function changeImage(imgElement, cardId) {
        // 이미지 경로가 circle.png인 경우 circle2.png로 변경
        if (imgElement.src.endsWith('circle.png')) {
            imgElement.src = "../../../resources/img/check-mark.png";
            // cardId를 selectedCardIds에 추가
            selectedCardId=cardId;
        } else { // 이미지 경로가 circle2.png인 경우 circle.png로 변경
            imgElement.src = "../../../resources/img/circle.png";
            selectedCardId=''
        }
        console.log("selectedCardId", selectedCardId);
    }

    let reissued = 'n';
    function setReissued(value,btnElement) {
        reissued = value;

        let btnOk = document.getElementById('btn-ok');
        let btnNo = document.getElementById('btn-no');

        btnOk.style.backgroundColor = ""; // default color
        btnNo.style.backgroundColor = ""; // default color
        btnOk.style.color = ""; // default text color
        btnNo.style.color = ""; // default text color

        btnElement.style.backgroundColor = "#00857F"; // Example color for the background
        btnElement.style.color = "white"; // Set the text color to white
        console.log("reissued",reissued);
    }


    function registerLostCard() {
        const params = 'cardId=' + selectedCardId + '&reissued=' + reissued;
        console.log("params"+params);
        window.location.href = '/customCenter/lostCardRegister?'+ params;
    }



</script>
</html>