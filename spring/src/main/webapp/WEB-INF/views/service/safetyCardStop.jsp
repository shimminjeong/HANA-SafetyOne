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
    <link href="../../../resources/css/member/fdsCardSelect.css" rel="stylesheet">
    <link href="../../../resources/css/member/modalStyle.css" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
</head>
<body>
<%@ include file="../include/header.jsp" %>
<div class="container">
    <div class="content-div" style="margin-right: 50px;margin-left: 50px;">
        <div class="content-header">
            <h2>안심서비스 일시정지</h2>
            <h3>일시정지란 안심서비스를 일정기간동안 중지하는 서비스입니다.</h3>
        </div>
        <span class="sub-container-hearder">서비스 이용 중인 카드 목록</span>
        <c:forEach items="${safetyCardList}" var="card" varStatus="loop">
            <div class="div-card-list" style="margin-top: 20px">
                <div class="card-list-info" id="${card.cardId}">
                    <div class="card-list-info-img-div">
                        <img src="../../../resources/img/circle.png" onclick="changeImage(this, '${card.cardId}')">
                    </div>
                    <img class="card-img" src="../../../resources/img/${card.cardName}.png">
                    <div class="card-list-info-cardid">${fn:substring(card.cardId, 0, 4)}-****-****-${fn:substring(card.cardId, 15,20)}</div>
                    <div class="card-list-info-cardname">본인 | ${card.cardName}</div>
                    <img class="down-img" src="../../../resources/img/down-arrow.png"
                         onclick="showSafetyInfo('${card.cardId}', this)">
                </div>
                <div class="panel">
                    <div id="cardInfo-${card.cardId}">
                            <%--                        이용현황--%>
                    </div>
                </div>
            </div>
        </c:forEach>
        <div class="reg-confirm-div">
            <button class="fds-back-Btn" onclick="window.location.href='/'">취소</button>
            <button class="fds-agree-Btn" onclick="stopCard()">일시정지</button>
        </div>
    </div>
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

    function stopCard() {

        window.location.href = "/safetyCard/stopCardDetail?cardId=" + selectedCardId;
    }

    function showSafetyInfo(cardId, element) {
        var panel = element.closest('.div-card-list').querySelector('.panel');
        if (panel.style.display === "block") {
            panel.style.display = "none";
        } else {
            panel.style.display = "block";
            var cardInfoList = $("#cardInfo-" + cardId);
            $.ajax({
                url: "/safetyCard/selectSafetyInfo",
                type: 'POST',
                data: JSON.stringify({cardId: cardId}),
                contentType: 'application/json',
                success: function (data) {
                    console.log("data", data)

                    let regionNameAllList = data.regionList.map(item => item);
                    let regionNames = data.safetyCardList.map(item => item.regionName);


                    let allowedRegions = [];
                    let blockStr = "";
                    let timeStr="";
                    let regionStr="";
                    let categoryStr="";


                    const regionsSet = new Set();
                    const timesSet = new Set();
                    const categoriesSet = new Set();

                    data.safetyCardList.forEach(item => {
                        console.log("item",item)
                        if (item.regionName !== null && item.time === null && item.categorySmall === null) {
                            allowedRegions.push(item.regionName);
                            console.log("1")
                        }

                        if (item.regionName !== null && item.time !== null && item.categorySmall !== null) {
                            regionsSet.add(item.regionName);
                            timesSet.add(item.time);
                            categoriesSet.add(item.categorySmall);
                            console.log("2")
                        }
                        if (item.regionName !== null && item.time === null && item.categorySmall !== null) {
                            regionsSet.add(item.regionName);
                            categoriesSet.add(item.categorySmall);
                        }

                        if (item.regionName !== null && item.time !== null && item.categorySmall === null) {
                            regionsSet.add(item.regionName);
                            timesSet.add(item.time);
                        }

                        if (item.regionName === null && item.time === null && item.categorySmall !== null) {
                            categoriesSet.add(item.categorySmall);
                        }

                        if (item.regionName === null && item.time !== null && item.categorySmall === null) {
                            timesSet.add(item.time);
                        }

                        if (item.regionName === null && item.time !== null && item.categorySmall !== null) {
                            timesSet.add(item.time);
                            categoriesSet.add(item.categorySmall);
                        }

                    });


                    data.regionList = data.regionList.filter(region => !allowedRegions.includes(region));
                    let allowedRegionsString = data.regionList.join(", ");

                    const regionsStr = Array.from(regionsSet).join(", ");
                    const timesStr = Array.from(timesSet).join(", ");
                    const categoriesStr = Array.from(categoriesSet).join(", ");
                    console.log("timesSet",timesSet);
                    console.log("regionsSet",regionsSet);
                    console.log("categoriesSet",categoriesSet);

                    var resultRegionStr=""
                    var resultTimeStr=""
                    var resultCategoryStr=""
                    if (regionsSet.size!==0){
                        resultRegionStr=regionsStr+"에서 ";
                    }
                    if (timesSet.size !==0){
                        resultTimeStr=timesStr+"까지 ";
                    }
                    if (categoriesSet.size !== 0) {
                        resultCategoryStr=categoriesStr+" 업종을 ";
                    }
                    let noStr="차단"

                    const resultStr = resultRegionStr+resultTimeStr+resultCategoryStr+noStr;


                    if (data.safetyCardList[0].regionName !==null) {

                        cardInfoList.empty();
                        cardInfoList.append("<h4>안심서비스 이용현황</h4>");
                        var cardInfoListContent = "<hr><div class='info-list'><div class='info-header'>서비스시작일시 </div><div class='info-content'>" + data.safetyCardList[0].safetyStartDate.split(":").slice(0, 2).join(":")+"</div></div>";
                        cardInfoListContent += "<div class='info-list'><div class='info-header'>허용 지역</div><div class='info-content'>" + allowedRegionsString + "</div></div>";
                        cardInfoListContent += "<div class='info-list'><div class='info-header'>차단 조합</div><div class='info-content'>" + resultStr + "</div></div>";

                        cardInfoList.append(cardInfoListContent);
                    }

                    if (data.safetyCardList[0].regionName ===null) {

                        cardInfoList.empty();
                        cardInfoList.append("<h4>안심서비스 이용현황</h4>");
                        var cardInfoListContent = "<hr><div class='info-list'><div class='info-header'>서비스시작일시 </div><div class='info-content'>" + data.safetyCardList[0].safetyStartDate.split(":").slice(0, 2).join(":")+"</div></div>";
                        cardInfoListContent += "<div class='info-list'><div class='info-header'>차단 조합</div><div class='info-content'>" + resultStr + "</div></div>";

                        cardInfoList.append(cardInfoListContent);
                    }

                }
            });
        }
    }


</script>
</html>


