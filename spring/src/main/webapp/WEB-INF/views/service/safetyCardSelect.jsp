<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
    <title>Title</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <link href="../../../resources/css/common.css" rel="stylesheet">
    <link href="../../../resources/css/cardSelectCommon.css" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
</head>
<body>
<%@ include file="../include/header.jsp" %>
<div class="container">
    <div class="content-div">
        <div class="content-div-header">
            <h2>안심카드설정</h2>
            <h3>안심카드서비스 이용현황</h3>
            <h4>설정카드를 선택 후 [등록] 또는 [해제]를 선택해주세요</h4>
        </div>
        <c:forEach items="${cards}" var="card" varStatus="loop">
            <div class="lostcard-list">
                <div class="card-list-info" id="${card.cardId}">
                    <div class="card-list-info-img-div">
                        <img src="../../../resources/img/circle.png" onclick="changeImage(this, '${card.cardId}')">
                    </div>
                    <div class="card-list-info-cardid">본인 | ${card.cardId}</div>
                    <div class="card-list-info-cardname">yolo</div>
                    <img class="card-img" src="../../../resources/img/cardImg${loop.index + 1}.png">
                    <c:if test="${card.selffdsSerStatus eq 'Y'}">
                        <img class="lock-img" src="../../../resources/img/padlock.png">
                    </c:if>
                    <c:if test="${card.selffdsSerStatus eq 'N'}">
                        <img class="lock-img" src="../../../resources/img/unlock.png">
                    </c:if>
                </div>
                <div class="panel">
                    <div id="cardInfo-${card.cardId}">
                        <!-- 서버로부터 받아온 정보가 이곳에 추가될 것입니다. -->
                    </div>
                </div>
            </div>
        </c:forEach>
        <div class="ajax-content"></div>
        <div class="reg-cancle-btn">
            <button class="cancle-Btn" onclick="cancleCard()">해제</button>
            <button class="reg-Btn" onclick="registerCard()">등록</button>
        </div>
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
            url: '/safetyCard/registerCard',
            type: 'POST',
            data: selectedCardId,
            contentType: 'application/json',
            success: function (response) {
                const ajaxContent = document.querySelector('.ajax-content');
                if (response === "안심카드 서비스 신청 성공") {
                    // openSelectModal();
                    // window.location.href = "/safetyCard/safetySetting";
                    window.location.href = "/safetyCard/safetySettingNew";
                }
                ;

                // else
                //     ajaxContent.textContent = "선택하신 카드는 안심카드설정이 이미 신청이 완료된 카드입니다.";
                // ajaxContent.style.color = "red";
                // selectedCards.forEach(card => {
                //         card.checked = false; // 이미 체크된 카드 체크 해제
                //
                //     }
                // )

            }
        });
    }


    function cancleCard() {

        console.log("Selected card ID:", selectedCardId); // cardId 출력
        $.ajax({
            url: '/safetyCard/cancleCard',
            type: 'POST',
            data: selectedCardId,
            contentType: 'application/json',
            success: function (response) {
                const ajaxContent = document.querySelector('.ajax-content');
                if (response === "안심카드 서비스 해제 성공") {
                    ajaxContent.textContent = "안심카드 서비스가 해제되었습니다.";
                    ajaxContent.style.color = "green";
                } else

                    ajaxContent.textContent = "선택하신 카드는 해당 서비스 등록내역이 존재하지 않습니다.";
                ajaxContent.style.color = "red";
                selectedCards.forEach(card => {
                    card.checked = false; // 이미 체크된 카드 체크 해제
                });
            }
        });
    }

    // var acc = document.getElementsByClassName("card-list-info");
    // var i;
    // for (i = 0; i < acc.length; i++) {
    //     acc[i].addEventListener("click", function () {
    //             this.classList.toggle("active");
    //             var panel = this.nextElementSibling;
    //             if (panel.style.display === "block") {
    //                 panel.style.display = "none";
    //             } else {
    //                 panel.style.display = "block";
    //                 var cardId = this.id; // 클릭한 accordion의 id를 가져옵니다.
    //                 console.log("cardid", cardId);
    //                 // 클릭한 accordion의 cardId를 서버에 전달하고 정보를 가져오는 Ajax 요청
    //                 $.ajax({
    //                     url: "/safetyCard/selectSafetyInfo",
    //                     type: 'POST',
    //                     data: JSON.stringify({cardId: cardId}),
    //                     contentType: 'application/json',
    //                     success: function (data) {
    //                         console.log("Data",data);
    //                         var cardInfoList = $("#cardInfo-" + cardId);
    //                         cardInfoList.empty();
    //                         cardInfoList.append("<h2>안심카드 맞춤설정 이용중입니다.</h2>");
    //                         data.forEach(function (item) {
    //                             cardInfoList.append("<hr><div class='info-list'><div class='info-header'>선택카드</div><span class='info-content'>" + item.cardId + "</span></div>" +
    //                                 "<div class='info-list'><div class='info-header'>사용가능기간 </div><span class='info-content'>" + item.safetyStartDate + " ~ " +item.safetyEndDate+"</span></div>");
    //                             if (item.regionName!== null) {
    //                                 cardInfoList.append("<div class='info-list'><div class='info-header'>결제차단지역 </div><span class='info-content'>" + item.regionName + "</span></div>");
    //                             }
    //
    //                             if (item.startTime !== null) {
    //                                 cardInfoList.append("<div class='info-list'><div class='info-header'>결제차단시간 </div><span class='info-content'>" + item.startTime + " ~ " +item.endTime+"</span></div>");
    //                             }
    //
    //                             if (item.categorySmall!== null) {
    //                                 cardInfoList.append("<div class='info-list'><div class='info-header'>결제차단업종 </div><span class='info-content'>" + item.categorySmall + "</span></div>");
    //                             }
    //
    //                         });
    //                     }
    //                 });
    //             }
    //         }
    //     )
    // }

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
                    url: "/safetyCard/selectSafetyInfo",
                    type: 'POST',
                    data: JSON.stringify({cardId: cardId}),
                    contentType: 'application/json',
                    success: function (data) {
                        console.log("data"+data);
                        console.log("data[0].safetyStringInfo"+data[0].safetyStringInfo);
                        splitInfo=data[0].safetyStringInfo.split('.')
                        console.log(splitInfo[0])
                        console.log(splitInfo[1])
                        console.log(splitInfo[2])

                        cardInfoList.empty();
                        cardInfoList.append("<h3>안심카드 맞춤설정 이용중입니다.</h3>");
                        var cardInfoListContent = "<hr><div class='info-list'><div class='info-header'>사용가능기간 </div><div class='info-content'>" + data[0].safetyStartDate + " ~ 카드유효기간(" + data[0].safetyEndDate + ")</div></div>" +
                            "<div class='info-list'><div class='info-header'>차단된 조합 </div><div class='info-content'>" + splitInfo[0] + "</div></div>";

                        if (splitInfo[1]) { // splitInfo[1]이 null이 아닌 경우에만 추가
                            cardInfoListContent += "<div class='info-list'><div class='info-header'> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div><div class='info-content'>" + splitInfo[1] + "</div></div>";
                        }

                        cardInfoList.append(cardInfoListContent);


                    }
                });
            }
        })
    }


</script>
</html>


