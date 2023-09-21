<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
    <link href="../../../resources/css/lostcard.css" rel="stylesheet">
    <link href="../../../resources/css/cardSelectCommon.css" rel="stylesheet">
</head>
<style>

</style>
<body>
<%@ include file="../include/header.jsp" %>
<div class="active-container">
    <div class="cont_box_area">
        <nav class="tab_ty02">
            <li class="on"><a href="/customCenter/lostCardSelect" title="현재 선택 탭">카드분실/도난신고</a></li>
            <li><a href="#">카드분실신고해제</a></li>
            <li><a href="/customCenter/lostCardInfo">카드분실신고내역</a></li>
        </nav>
        <div class="lost-header"><h2>카드를 선택해주세요</h2></div>
        <c:forEach items="${cards}" var="card" varStatus="loop">
            <div class="lostcard-list">
                <div class="card-list-info" id="${card.cardId}" onclick="confirmCardHistory(this)">
                    <div class="card-list-info-img-div">
                        <img src="../../../resources/img/circle.png" onclick="changeImage(this, '${card.cardId}')">
                    </div>
                    <div class="card-list-info-cardid">${card.cardId}</div>
                    <div class="card-list-info-name">본인&nbsp;&nbsp;|&nbsp;&nbsp;<%= name %>&nbsp;&nbsp;|&nbsp;&nbsp;
                    </div>
                    <div class="card-list-info-cardname">${card.cardName}</div>
                    <img class="card-img" src="../../../resources/img/cardImg${loop.index + 1}.png">
                </div>
                <div class="history-panel">
                    <div id="cardInfo-${card.cardId}">
                        <!-- 서버로부터 받아온 정보가 이곳에 추가될 것입니다. -->
                    </div>
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
            selectedCardId = cardId;
        } else { // 이미지 경로가 circle2.png인 경우 circle.png로 변경
            imgElement.src = "../../../resources/img/circle.png";
            selectedCardId = ''
        }
        console.log("selectedCardId", selectedCardId);
    }

    let reissued = 'n';

    function setReissued(value, btnElement) {
        reissued = value;

        // 모든 버튼의 활성화 스타일 제거
        let btnOk = document.getElementById('btn-ok');
        let btnNo = document.getElementById('btn-no');

        btnOk.classList.remove('active');
        btnNo.classList.remove('active');

        // 클릭된 버튼에 활성화 스타일 추가
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

    function confirmCardHistory(element) {
        const cardId = element.id;

        $.ajax({
            type: "POST",
            url: "/customCenter/confirmCardHistory",
            data: JSON.stringify({cardId: cardId}),
            contentType: 'application/json',
            dataType: 'json',
            success: function (response) {
                displayCardHistory(cardId, response);
            },
            error: function (error) {
                console.error("Error fetching card history:", error);
            }
        });
    }

    function formatCurrency(amount) {
        return amount.toLocaleString('ko-KR') + "원";
    }


    var acc = document.getElementsByClassName("card-list-info");
    for (var i = 0; i < acc.length; i++) {
        acc[i].addEventListener("click", function () {
            this.classList.toggle("active");
            var panel = this.nextElementSibling;
            if (panel.style.display === "block") {
                panel.style.display = "none";
            } else {
                panel.style.display = "block";
                var cardId = this.id; // 클릭한 accordion의 id를 가져옵니다.
                var cardInfoList = $("#cardInfo-" + cardId); // 이 부분이 추가되었습니다.
                console.log("cardid", cardId);
                // 클릭한 accordion의 cardId를 서버에 전달하고 정보를 가져오는 Ajax 요청
                $.ajax({
                    url: "/customCenter/confirmCardHistory",
                    type: 'POST',
                    data: JSON.stringify({cardId: cardId}),
                    contentType: 'application/json',
                    success: function (data) {

                        cardInfoList.empty();
                        cardInfoList.append("<h4>최근 거래내역</h4>");

                        // var cardInfoListContent = "";
                        // for (let i = 0; i < 3 && i < data.length; i++) {
                        //     cardInfoListContent += "<div class='info-list'>" +
                        //         "<span class='cardhistory-date'>" + data[i].cardHisDate + "</span>" +
                        //         "<span class='cardhistory-regionName'>" + data[i].regionName + "</span>" +
                        //         "<span class='cardhistory-store'>" + data[i].store + "</span>" +
                        //         "<span class='cardhistory-amount'>" + data[i].amount + "</span></div>";
                        // }
                        //
                        // cardInfoList.append(cardInfoListContent);

                        var cardInfoListContent = "<table class='info-list-table'>";

// 테이블 헤더 추가
                        cardInfoListContent += "<thead><tr>" +
                            "<th class='cardhistory-date'>Date</th>" +
                            "<th class='cardhistory-regionName'>Region</th>" +
                            "<th class='cardhistory-store'>Store</th>" +
                            "<th class='cardhistory-amount'>Amount</th>" +
                            "</tr></thead><tbody>";

// 테이블 본문에 데이터 추가
                        for (let i = 0; i < 3 && i < data.length; i++) {
                            cardInfoListContent += "<tr>" +
                                "<td class='cardhistory-date'>" + data[i].cardHisDate + "</td>" +
                                "<td class='cardhistory-regionName'>" + data[i].regionName + "</td>" +
                                "<td class='cardhistory-store'>" + data[i].store + "</td>" +
                                "<td class='cardhistory-amount'>" + formatCurrency(data[i].amount) + "</td>"
                                +
                                "</tr>";
                        }

                        cardInfoListContent += "</tbody></table>";

// 변수에 저장된 테이블 HTML을 원하는 위치에 추가합니다.
                        cardInfoList.append(cardInfoListContent);


                    }
                });
            }
        })
    }



</script>
</html>