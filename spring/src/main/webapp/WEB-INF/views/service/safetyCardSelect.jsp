<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<html>
<head>
    <title>Title</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <link href="../../../resources/css/common.css" rel="stylesheet">
    <%--    <link href="../../../resources/css/cardSelectCommon.css" rel="stylesheet">--%>
    <link href="../../../resources/css/fdsCardSelect.css" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
</head>
<body>
<%@ include file="../include/header.jsp" %>
<div class="container">
    <div class="content-div">
        <div class="content-header">
            <h2>안심서비스 카드 선택</h2>
<%--            <h3>선택한 카드의 거래 지역, 시간 , 업종 등 허용하거나 차단할 나만의 Rule을 설정할 수 있습니다.</h3>--%>
        </div>
        <span class="sub-container-hearder">보유카드 목록</span><span class="fds-info-text hidden">사용기간이 6개월 이상 지난 카드만 신청 가능합니다.</span>
        <hr class="sub-hr">
        <div class="cardAll-div">
            <div class="cardAll-img-div"><img src="../../../resources/img/circle.png" onclick="AllCard()"></div>
            <div class="all-text">전체선택</div>
        </div>
        <hr>
        <c:forEach items="${cards}" var="card" varStatus="loop">
            <div class="lostcard-list">
                    <%--                <div class="card-list-info" id="${card.cardId}">--%>
                    <%--                    <div class="card-list-info-img-div">--%>
                    <%--                        <img src="../../../resources/img/circle.png" onclick="changeImage(this, '${card.cardId}')">--%>
                    <%--                    </div>--%>
                    <%--                    <div class="card-list-info-cardid">본인 | ${card.cardId}</div>--%>
                    <%--                    <div class="card-list-info-cardname">${card.cardName}</div>--%>
                    <%--                    <img class="card-img" src="../../../resources/img/${card.cardName}.png">--%>
                    <%--                    <c:if test="${card.selffdsSerStatus eq 'Y'}">--%>
                    <%--                        <img class="lock-img" src="../../../resources/img/shield.png">--%>
                    <%--                    </c:if>--%>
                    <%--                    <c:if test="${card.selffdsSerStatus eq 'N'}">--%>
                    <%--                        <img class="lock-img" src="../../../resources/img/unlock.png">--%>
                    <%--                    </c:if>--%>
                    <%--                </div>--%>
                <div class="card-list-info" id="${card.cardId}">
                    <div class="card-list-info-img-div">
                        <img src="../../../resources/img/circle.png" onclick="changeImage(this, '${card.cardId}')">
                    </div>
                    <img class="card-img" src="../../../resources/img/${card.cardName}.png">
                    <div class="card-info-text">
                        <div class="card-info-text1">
                            <div class="safetycard-info-cardname">${card.cardName}</div>

                            <div class="card-info-name">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[본인]
                            </div>
                        </div>
                        <div class="card-info-text2">
                            <span class="card-info-cardid">${fn:substring(card.cardId, 0, 4)}-****-****-${fn:substring(card.cardId, 15,20)}</span>
                            <span class="card-info-regDate">[유효 기간] ${fn:substring(card.cardRegDate, 0,10)}&nbsp;~&nbsp;${fn:substring(card.validDate, 0, 10)}</span>
                        </div>
                    </div>
                    <c:if test="${card.selffdsSerStatus eq 'Y'}">
                        <img class="service-status-img" src="../../../resources/img/padlock.png">
                    </c:if>
                </div>
<%--                <div class="panel">--%>
<%--                    <div id="cardInfo-${card.cardId}">--%>
<%--                        <!-- 서버로부터 받아온 정보가 이곳에 추가될 것입니다. -->--%>
<%--                    </div>--%>
<%--                </div>--%>

            </div>
            <hr>
        </c:forEach>
        <div class="reg-btn-div">
            <button class="fds-can-Btn" onclick="cancleCard()">해제</button>
            <button class="fds-reg-Btn" onclick="registerCard()">신청</button>
        </div>
    </div>
</div>
</body>
<script>

    // var acc = document.getElementsByClassName("card-list-info");
    // for (var i = 0; i < acc.length; i++) {
    //     acc[i].addEventListener("click", function () {
    //         this.classList.toggle("active");
    //         var panel = this.nextElementSibling;
    //         if (panel.style.display === "block") {
    //             panel.style.display = "none";
    //         } else {
    //             panel.style.display = "block";
    //             var cardId = this.id; // 클릭한 accordion의 id를 가져옵니다.
    //             var cardInfoList = $("#cardInfo-" + cardId); // 이 부분이 추가되었습니다.
    //             console.log("cardid", cardId);
    //             // 클릭한 accordion의 cardId를 서버에 전달하고 정보를 가져오는 Ajax 요청
    //             $.ajax({
    //                 url: "/safetyCard/selectSafetyInfo",
    //                 type: 'POST',
    //                 data: JSON.stringify({cardId: cardId}),
    //                 contentType: 'application/json',
    //                 success: function (data) {
    //                     console.log("data" + data);
    //                     console.log("data[0].safetyStringInfo" + data[0].safetyStringInfo);
    //                     splitInfo = data[0].safetyStringInfo.split('.')
    //                     console.log(splitInfo[0])
    //                     console.log(splitInfo[1])
    //                     console.log(splitInfo[2])
    //
    //                     cardInfoList.empty();
    //                     cardInfoList.append("<h3>안심서비스 이용현황</h3>");
    //                     var cardInfoListContent = "<hr><div class='info-list'><div class='info-header'>서비스이용기간 </div><div class='info-content'>" + data[0].safetyEndDate.split(" ")[0] + " ~ " + data[0].safetyEndDate.split(" ")[0] + "</div></div>" +
    //                         "<div class='info-list'><div class='info-header'>허용된 지역</div><div class='info-content'>" + splitInfo[0] + "</div></div>";
    //
    //                     if (splitInfo[1]) { // splitInfo[1]이 null이 아닌 경우에만 추가
    //                         cardInfoListContent += "<div class='info-list'><div class='info-header'>차단된 조합</div><div class='info-content'>" + splitInfo[1] + "</div></div>";
    //                     }
    //
    //                     cardInfoList.append(cardInfoListContent);
    //
    //
    //                 }
    //             });
    //         }
    //     })
    // }


    let selectedCardIds = [];

    function AllCard() {
        // 'cardAll-img-div' 클래스를 가진 div의 이미지와
        // 'card-list-info-img-div' 클래스를 가진 모든 div의 이미지를 선택합니다.
        let allImages = document.querySelectorAll('.cardAll-img-div img, .card-list-info-img-div img');

        // 각 이미지 요소에 대해 changeImage() 함수를 호출합니다.
        allImages.forEach(function (img) {
            // 이미지가 전체 선택 이미지인 경우와 카드 이미지인 경우를 구분합니다.
            if (img.parentElement.classList.contains('cardAll-img-div')) {
                changeImage(img, null); // 전체 선택 이미지의 경우 cardId는 null로 처리합니다.
            } else {
                let cardId = img.parentElement.parentElement.id; // 카드 ID를 가져옵니다.
                changeImage(img, cardId);
            }
        });
    }

    function changeImage(imgElement, cardId) {
        if (imgElement.src.endsWith('circle.png')) {
            imgElement.src = "../../../resources/img/check-mark.png";
            if (cardId) { // cardId가 있는 경우만 배열에 추가
                selectedCardIds.push(cardId);
            }
        } else {
            imgElement.src = "../../../resources/img/circle.png";
            if (cardId) { // cardId가 있는 경우만 배열에서 제거
                const index = selectedCardIds.indexOf(cardId);
                if (index > -1) {
                    selectedCardIds.splice(index, 1);
                }
            }
        }

    }

    function registerCard() {

        console.log("selectedCardIds", selectedCardIds);
        $.ajax({
                url: '/safetyCard/registerCard',
                type: 'POST',
                data: JSON.stringify(selectedCardIds),
                contentType: 'application/json',
                success: function (response) {
                    const ajaxContent = document.querySelector('.ajax-content');
                    if (response === "안심서비스 신청 성공") {
                        // openSelectModal();
                        // window.location.href = "/safetyCard/safetySetting";
                        window.location.href = "/safetyCard/safetySettingNew";
                    } else {
                        ajaxContent.textContent = "선택하신 카드는 안심카드로 이미 신청이 완료된 카드입니다.";
                        ajaxContent.style.color = "red";
                        selectedCards.forEach(card => {
                                card.checked = false; // 이미 체크된 카드 체크 해제

                            }
                        )
                    }
                    ;
                }
            }
        )
        ;
    }

    function cancleCard() {
        $.ajax({
            url: '/safetyCard/cancleCard',
            type: 'POST',
            data: JSON.stringify(selectedCardIds),
            contentType: 'application/json',
            success: function (response) {
                const ajaxContent = document.querySelector('.ajax-content');
                if (response === "안심서비스 해제 성공") {
                    // ajaxContent.textContent = "안심서비스가 해제되었습니다.";
                    // ajaxContent.style.color = "green";
                    window.location.href = "/";
                } else {

                    ajaxContent.textContent = "선택하신 카드는 해당 서비스 등록내역이 존재하지 않습니다.";
                    ajaxContent.style.color = "red";
                    selectedCards.forEach(card => {
                        card.checked = false; // 이미 체크된 카드 체크 해제
                    })
                }
                ;
            }
        });
    }


</script>
</html>


