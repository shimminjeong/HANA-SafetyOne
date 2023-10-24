<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
    <link href="../../../resources/css/member/lostcard.css" rel="stylesheet">
    <link href="../../../resources/css/member/cardSelectCommon.css" rel="stylesheet">
    <link href="../../../resources/css/common.css" rel="stylesheet">
</head>


<body>
<%@ include file="../include/header.jsp" %>
<div class="active-container">
    <div class="cont_box_area">
        <div class="title">분실신고/재발급</div>
        <div class="lost-header"><h3>카드 선택</h3></div>
        <hr class="sub-hr">
        <div class="cardAll-div">
            <div class="cardAll-img-div"><img src="../../../resources/img/circle.png" onclick="AllCard()"></div>
            <div class="all-text">전체선택</div>
        </div>
        <c:forEach items="${cards}" var="card" varStatus="loop">
            <div class="lostcard-list">
                <div class="card-list-info" id="${card.cardId}">
                    <div class="card-list-info-img-div">
                        <img src="../../../resources/img/circle.png" onclick="changeImage(this, '${card.cardId}')">
                    </div>
                    <img class="card-img" src="../../../resources/img/${card.cardName}.png">
                    <div class="card-list-info-cardid">${card.cardId}</div>
                    <div class="card-list-info-name">본인&nbsp;&nbsp;|&nbsp;&nbsp;</div>
                    <div class="card-list-info-cardname">${card.cardName}</div>
                    <img class="down-img" src="../../../resources/img/down-arrow.png"
                         onclick="showCardInfo('${card.cardId}', this)">
                </div>
                <hr class="tmp-hr">
                <div class="history-panel">
                    <div id="cardInfo-${card.cardId}">

                    </div>
                </div>

                <div class="reissued">
                    <span>재발급 신청 여부</span>
                    <button id="btn-ok" class="reissued-ok" onclick="setReissued('Y', this)">신청</button>
                    <button id="btn-no" class="reissued-no" onclick="setReissued('N', this)">신청 안 함</button>
                </div>
            </div>
        </c:forEach>
    </div>
    <button class="registerLostBtn" style="margin-bottom: 30px;" onclick="registerLostCard()">다음</button>
</div>

</body>
<script>

    let selectedCardId = '';

    function changeImage(imgElement, cardId) {

        if (imgElement.src.endsWith('circle.png')) {
            imgElement.src = "../../../resources/img/check-mark.png";

            selectedCardId = cardId;
        } else {
            imgElement.src = "../../../resources/img/circle.png";
            selectedCardId = ''
        }
        console.log("selectedCardId", selectedCardId);
    }

    let reissued = 'n';

    function setReissued(value, btnElement) {
        reissued = value;


        let btnOk = document.getElementById('btn-ok');
        let btnNo = document.getElementById('btn-no');

        btnOk.classList.remove('active');
        btnNo.classList.remove('active');


        btnElement.classList.add('active');

        console.log("reissued", reissued);
    }


    function registerLostCard() {
        const params = 'cardId=' + selectedCardId + '&reissued=' + reissued;
        console.log("params" + params);
        window.location.href = '/customCenter/lostCardRegister?' + params;
    }

    function toggleAccordion(accordionId) {
        const accordion = document.getElementById(accordionId);
        const content = accordion.querySelector('.accordion-content');
        if (content.style.display === "none" || content.style.display === "") {
            content.style.display = "block";
        } else {
            content.style.display = "none";
        }
    }


    function formatCurrency(amount) {
        return amount.toLocaleString('ko-KR') + "원";
    }


    function showCardInfo(cardId) {
        var clickedElement = document.getElementById(cardId);
        clickedElement.classList.toggle("active");


        var panel = clickedElement.nextElementSibling.nextElementSibling;
        if (panel.style.display === "block") {
            panel.style.display = "none";
        } else {
            panel.style.display = "block";

            var cardInfoList = $("#cardInfo-" + cardId);
            console.log("cardid", cardId);

            $.ajax({
                url: "/customCenter/confirmCardHistory",
                type: 'POST',
                data: JSON.stringify({cardId: cardId}),
                contentType: 'application/json',
                success: function (data) {
                    cardInfoList.empty();
                    var cardInfoListContent = "<table class='info-list-table'>";
                    cardInfoListContent += "<thead><tr>" +
                        "<th class='cardhistory-date'>거래일시</th>" +
                        "<th class='cardhistory-category'>카테고리</th>" +
                        "<th class='cardhistory-regionName'>가맹점주소</th>" +
                        "<th class='cardhistory-store'>가맹점명</th>" +
                        "<th class='cardhistory-amount'>금액</th>" +
                        "</tr></thead><tbody>";

                    for (let i = 0; i < 3 && i < data.length; i++) {
                        var formattedDate = data[i].cardHisDate.substring(0, data[i].cardHisDate.length - 3);
                        cardInfoListContent += "<tr>" +
                            "<td class='cardhistory-date'>" + formattedDate + "</td>" +
                            "<td class='cardhistory-category'>" + data[i].categorySmall + "</td>" +
                            "<td class='cardhistory-regionName'>" + data[i].regionName + "</td>" +
                            "<td class='cardhistory-store'>" + data[i].store + "</td>" +
                            "<td class='cardhistory-amount'>" + formatCurrency(data[i].amount) + "</td>" +
                            "</tr>";
                    }

                    cardInfoListContent += "</tbody></table>";
                    cardInfoList.append(cardInfoListContent);
                }
            });
        }
    }

</script>
</html>