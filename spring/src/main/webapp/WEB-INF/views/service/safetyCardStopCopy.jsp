<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>



<html>
<head>
    <title>Title</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <link href="../../../resources/css/common.css" rel="stylesheet">
    <link href="../../../resources/css/cardSelectCommon.css" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
</head>
<style>
    .stopcard-div {
        display: flex;
        flex-direction: row;
    }

    .stopcard-list {
        flex: 1;
        margin-right: 5%;

    }


    .stopcard-list img {
        width: 60%;
        margin: 0 auto;
    }

    .info-list {
        display: flex;
        flex-direction: column;
    }

    .stopcard-list {
        margin-bottom: 2%;
        display: flex;
        flex-direction: column;
        /*border: 1px solid #ccc; !* 회색 테두리 *!*/
        /*box-shadow: 0px 2px 5px rgba(0, 0, 0, 0.2); !* 그림자 효과 *!*/
        /*border-radius: 5px; !* 둥근 테두리 *!*/
    }

    .selected-card {
        background-color: #e0e0e0; /* Grey color. Adjust as needed. */
    }


</style>
<body>
<%@ include file="../include/header.jsp" %>
<div class="container">
    <div class="content-div">
        <div class="content-div-header">
            <h2>안심카드 일시정지</h2>
            <h3>안심서비스 이용현황</h3>
            <h4>카드를 선택 후 일시정지를 선택해주세요</h4>
        </div>
        <div class="stopcard-div">
            <c:forEach items="${safetyInfoList}" var="safetyInfo" varStatus="loop">
                <div class="stopcard-list" data-cardId="${safetyInfo.cardId}" onclick="selectCard(this)"><img
                        class="card-img" src="../../../resources/img/cardImg${loop.index + 1}.png">
                    <hr>
                    <div class='info-list'>
                        <div class='info-header'>카드번호</div>
                        <div class='info-content'>${safetyInfo.cardId} | ${safetyInfo.cardName}
                        </div>
                    </div>
                    <div class='info-list'>
                        <div class='info-header'>사용가능기간</div>
                        <div class='info-content'>${safetyInfo.safetyStartDate.split(" ")[0]}
                            ~ 카드유효기간(${safetyInfo.safetyEndDate.split(" ")[0]})
                        </div>
                    </div>
                    <c:set var="splitInfo" value="${fn:split(safetyInfo.safetyStringInfo, '.')}"/>
                    <div class='info-list'>
                        <div class='info-header'>차단된 조합</div>
                        <div class='info-content'>${splitInfo[0]}</div>
                    </div>
                    <c:if test="${fn:length(splitInfo) > 1}">
                        <div class='info-list'>
                            <div class='info-header'>&nbsp&nbsp&nbsp&nbsp&nbsp</div>
                            <div class='info-content'>${splitInfo[1]}</div>
                        </div>
                    </c:if>
                </div>
            </c:forEach>
        </div>
        <div class="ajax-content"></div>
        <div class="reg-cancle-btn">
            <button class="reg-Btn" onclick="stopCard()">일시정지</button>
        </div>
    </div>
</div>
</body>
<script>

    var selectedCardId = null;

    function selectCard(element) {
        // Remove the class from previously selected cards
        var cards = document.querySelectorAll('.stopcard-list');
        for (var i = 0; i < cards.length; i++) {
            cards[i].classList.remove('selected-card');
        }

        // Add the class to the current card and set the selectedCardId
        element.classList.add('selected-card');
        selectedCardId = element.getAttribute('data-cardId');
    }

    function stopCard() {
        if (!selectedCardId) {
            alert("No card selected!");
            return;
        }

        console.log("selectedCardId: " + selectedCardId);

        // Redirecting to the URL with the selected cardId as a query parameter
        window.location.href = '/safetyCard/stopCardPage?cardId=' + selectedCardId;
    }


</script>
</html>


