<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>


<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
    <link href="../../../resources/css/member/safetyCardCommon.css" rel="stylesheet">
    <link href="../../../resources/css/member/fdsCardSelect.css" rel="stylesheet">
    <link href="../../../resources/css/member/safetyStop.css" rel="stylesheet">
    <link rel="stylesheet" href="http://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
    <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

</head>
<body>
<%@ include file="../include/header.jsp" %>
<div class="container">
    <div class="content-div" style="margin-right: 50px;margin-left: 50px;">
        <div class="content-header">
            <h2>안심서비스 일시정지</h2>
            <h3 style="margin-bottom: 0px;">일정 기간동안 안심서비스를 정지할 항목을 선택하세요</h3>
            <h4>※ 선택한 항목의 거래는 일정 기간동안 거래가 허용됩니다.</h4>
        </div>
        <div class="left-text">선택카드</div>
        <div class="div-card-list">
            <div class="card-list-info">
                <img class="card-img" src="../../../resources/img/${cardInfo.cardName}.png">
                <div class="card-list-info-cardid">${fn:substring(cardInfo.cardId, 0, 4)}-****-****-${fn:substring(cardInfo.cardId, 15,20)}</div>
                <div class="card-list-info-cardname">본인 | ${cardInfo.cardName}</div>
                <img class="down-img" src="../../../resources/img/down-arrow.png"
                     onclick="showSafetyInfo('${cardInfo.cardId}', this)">
            </div>
            <div class="panel">
                <div id="cardInfo-${cardInfo.cardId}">
                    <!-- 이용현황-->
                </div>
            </div>
        </div>
        <div class="region-div">
            <div class="region-no-div">
                <div class="div-header">거래 차단 지역</div>
                <div class="region-no">
                    <c:forEach var="region" items="${safetyRegionList}">
                        <div class="checkbox-container">
                            <input type="checkbox" id="checkbox-${region.safetyIdSeq}"
                                   data-seq-id="${region.safetyIdSeq}"
                                   data-card-id="${region.cardId}"
                                   data-region-name="${region.regionName}"
                                   data-time="${region.time}"
                                   data-category="${region.categorySmall}"/>
                            <label for="checkbox-${region.safetyIdSeq}" class="checkbox-design"></label>
                            <span class="checkbox-label">${region.regionName}</span>
                        </div>
                    </c:forEach>
                </div>
            </div>
            <div class="region-ok-div">
                <div class="div-header">거래 허용 지역</div>
                <div class="region-ok">
                    <c:forEach var="region" items="${regionAllList}">
                        <span class="text-box">${region}</span>
                    </c:forEach>
                </div>
            </div>
        </div>
        <br>
        <div class="div-header">거래 차단 조합</div>
        <div class="rule-div">
            <table>
                <thead>
                <tr>
                    <th></th>
                    <th>지역</th>
                    <th>업종</th>
                </tr>
                </thead>
                <tbody>

                <c:forEach var="rule" items="${safetyRuleList}">
                    <tr>
                        <td>
                            <input type="checkbox" id="checkbox-${rule.safetyIdSeq}" data-seq-id="${rule.safetyIdSeq}" data-card-id="${rule.cardId}"
                                   data-region-name="${rule.regionName}"
                                   data-category="${rule.categorySmall}"/>
                            <label for="checkbox-${rule.safetyIdSeq}" class="checkbox-design"></label>
                        </td>
                        <td style="text-align: center">${rule.regionName}</td>
                        <td style="text-align: center">${rule.categorySmall}</td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
    <div class="btn-div">
        <button type="button"
                data-seq-id="${info.safetyIdSeq}"
                data-card-id="${info.cardId}"
                data-region-name="${info.regionName}"
                data-time="${info.time}"
                data-category="${info.categorySmall}"
                onclick="pauseCard(this)">
            확인
        </button>
    </div>
</div>
<div id="pauseModal" class="modal">
    <div class="pause-container">
        <span class="close-btn" onclick="closeModal()">&#10006;</span>
        <div class="modal-header">기간 설정</div>
        카드 번호&nbsp;&nbsp;:&nbsp;&nbsp;<span id="cardIdDisplay"></span>
        <div id="rule">
            <div hidden><span id="seqId"></span></div>
            <div>선택 지역&nbsp;&nbsp;:&nbsp;&nbsp;<span id="modalRegionName"></span></div>
            <div>선택 시간&nbsp;&nbsp;:&nbsp;&nbsp;<span id="modalTime"></span></div>
            <div>선택 업종&nbsp;&nbsp;:&nbsp;&nbsp;<span id="modalCategory"></span></div>
        </div>
        <div class="pause-date">
            <span>기간 선택&nbsp;&nbsp;:&nbsp;&nbsp;</span>
            <input type="text" id="startdatepicker" name="startStopDate">
            <span> <strong>~</strong> </span>
            <input type="text" id="enddatepicker" name="endStopDate">
        </div>
        <div class="confirm-text">해당 기간동안 &nbsp;<span id="modalRegionNameForPayment"></span>&nbsp;지역의 거래를 허용합니다.</div>
        <div class="btn-div">
            <button class="confirm-btn" onclick="confirmPause()">확인</button>
        </div>
    </div>

</div>

<script>

    var aa = document.querySelector('input[type="checkbox"]:checked');
    console.log("aa", aa);

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


    function pauseCard(buttonElement) {
        var selectedCheckbox = document.querySelector('input[type="checkbox"]:checked');

        if (selectedCheckbox) {
            var seqId = selectedCheckbox.getAttribute('data-seq-id');
            var cardId = selectedCheckbox.getAttribute('data-card-id');
            var regionName = selectedCheckbox.getAttribute('data-region-name');
            var time = selectedCheckbox.getAttribute('data-time');
            var category = selectedCheckbox.getAttribute('data-category');

            console.log('seqId: ' + seqId);
            console.log('cardId: ' + cardId);
            console.log('regionName: ' + regionName);
            console.log('time: ' + time);
            console.log('category: ' + category);

        } else {
            console.log('체크된 항목이 없습니다.');
        }

        document.getElementById("seqId").innerText = seqId;
        document.getElementById("cardIdDisplay").innerText = cardId;

        if (regionName && regionName.trim() !== '') {
            document.getElementById("modalRegionName").innerText = regionName;
            document.getElementById("modalRegionNameForPayment").innerText = regionName;
            document.getElementById("modalRegionName").parentElement.style.display = "block";
        } else {
            document.getElementById("modalRegionName").parentElement.style.display = "none";
        }


        if (time && time.trim() !== '') {
            document.getElementById("modalTime").innerText = time;
            document.getElementById("modalTime").parentElement.style.display = "block";
        } else {
            document.getElementById("modalTime").parentElement.style.display = "none";
        }


        if (category && category.trim() !== '') {
            document.getElementById("modalCategory").innerText = category;
            document.getElementById("modalCategory").parentElement.style.display = "block";
        } else {
            document.getElementById("modalCategory").parentElement.style.display = "none";
        }

        document.getElementById("pauseModal").style.display = "block";


    }


    function closeModal() {
        document.getElementById("pauseModal").style.display = "none";
    }

    function confirmPause() {
        var safetyIdSeq = parseInt(document.getElementById("seqId").innerText, 10);
        var startStopDate = $("#startdatepicker").val();
        var endStopDate = $("#enddatepicker").val();
        console.log("startStopDate" + startStopDate);
        console.log("endStopDate" + endStopDate);
        console.log("safetyIdSeq" + safetyIdSeq);
        console.log("Type of safetyIdSeq:", typeof safetyIdSeq);


        $.ajax({
            type: "POST",
            url: "/safetyCard/updateStopDate",
            data: JSON.stringify({
                safetyIdSeq: safetyIdSeq,
                stopStartDate: startStopDate,
                stopEndDate: endStopDate
            }),
            contentType: "application/json",
            success: function (response) {
                closeModal();
                if (response === "일시정지업데이트") {
                    window.location.href = "/safetyCard/safetySettingStopOk";
                } else {
                    alert(response);
                }
            },
            error: function (error) {
                alert("Something went wrong: " + error.statusText);
            }
        });
    }


    $("#startdatepicker").datepicker({
        dateFormat: 'yy-mm-dd'
        , showOtherMonths: true
        , showMonthAfterYear: true
        , changeYear: true
        , changeMonth: true
        , yearSuffix: "년"
        , monthNamesShort: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월']
        , monthNames: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월']
        , dayNamesMin: ['일', '월', '화', '수', '목', '금', '토']
        , dayNames: ['일요일', '월요일', '화요일', '수요일', '목요일', '금요일', '토요일']
        , minDate: "-5Y"
        , maxDate: "+5y"
    });

    $("#enddatepicker").datepicker({
        dateFormat: 'yy-mm-dd'
        , showOtherMonths: true
        , showMonthAfterYear: true
        , changeYear: true
        , changeMonth: true
        , yearSuffix: "년"
        , monthNamesShort: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월']
        , monthNames: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월']
        , dayNamesMin: ['일', '월', '화', '수', '목', '금', '토']
        , dayNames: ['일요일', '월요일', '화요일', '수요일', '목요일', '금요일', '토요일']
        , minDate: "-5Y"
        , maxDate: "+5y"
    });

</script>
</body>
</html>
