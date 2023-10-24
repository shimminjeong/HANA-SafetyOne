<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/chart.js@3.5.1/dist/chart.min.js"></script>
    <link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
    <link href="../../../resources/css/member/safetyCardCommon.css" rel="stylesheet">
    <link href="../../../resources/css/member/safetySettingNew.css" rel="stylesheet">
    <link href="../../../resources/css/member/lostcard.css" rel="stylesheet">
    <link rel="stylesheet" href="http://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">


</head>
<body>
<%@ include file="../include/header.jsp" %>
<div class="container">
    <div class="main">
        <h3>안심카드일시정지</h3>
        <h4>대상카드</h4>
        <hr>
        <div class="card-info">
            <div class="card-details">
                <span>본인 | </span>
                <span>${safetyInfo[0].cardId}</span>
            </div>
            <div class="card-type">
                <span>${cardInfo.cardName}</span>
            </div>
        </div>
        <div class="car">
            <span>서비스 이용 기간</span><span>${safetyInfo[0].safetyStartDate.split(" ")[0]} ~ 카드유효기간(${safetyInfo[0].safetyEndDate.split(" ")[0]})</span>
        </div>
        <div class="car">
            <div>특정 기간동안 안심서비스를 일시정지할 조합을 선택하세요</div>
            <div>※ 특정 기간동안선택한 조합의 결제가 허용됩니다.</div>
        </div>
        <div class="table-div">
            <table border="1">
                <thead>
                <tr>
                    <th>차단한 지역</th>
                    <th>차단한 시간</th>
                    <th>차단한 업종</th>
                    <th>일시정지</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${safetyInfo}" var="info">
                    <tr>
                        <td>${info.regionName}</td>
                        <td>${info.time}</td>
                        <td>${info.categorySmall}</td>
                        <td>
                            <button type="button"
                                    data-seq-id="${info.safetyIdSeq}"
                                    data-card-id="${info.cardId}"
                                    data-region-name="${info.regionName}"
                                    data-time="${info.time}"
                                    data-category="${info.categorySmall}"
                                    onclick="pauseCard(this)">
                                일시정지
                            </button>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</div>
<div id="pauseModal"
     style="display:none; position: fixed; top: 50%; left: 50%; transform: translate(-50%, -50%); padding: 20px; background-color: white; border: 1px solid #ccc; z-index: 1000;">
    <h2>일시정지 기간 설정</h2>
    <div id="cardIdDisplay"></div>
    <div id="rule">
        <div hidden>번호: <span id="seqId"></span></div>
        <div>지역 <span id="modalRegionName"></span></div>
        <div>시간: <span id="modalTime"></span></div>
        <div>업종: <span id="modalCategory"></span></div>
    </div>
    <div class="pause-date">
        <input type="text" id="startdatepicker" name="startStopDate">
        <span> <strong>~</strong> </span>
        <input type="text" id="enddatepicker" name="endStopDate">
    </div>
    <div>해당기간동안 <span id="modalRegionNameForPayment"></span>지역의 결제를 허용합니다.</div>
    <button onclick="confirmPause()">확인</button>
    <button onclick="closeModal()">취소</button>
</div>


<script>
    function pauseCard(buttonElement) {
        var seqId = buttonElement.getAttribute('data-seq-id');
        var cardId = buttonElement.getAttribute('data-card-id');
        var regionName = buttonElement.getAttribute('data-region-name');
        var time = buttonElement.getAttribute('data-time');
        var category = buttonElement.getAttribute('data-category');

        document.getElementById("seqId").innerText = seqId;

        document.getElementById("cardIdDisplay").innerText = cardId;

        if(regionName && regionName.trim() !== '') {
            document.getElementById("modalRegionName").innerText = regionName;
            document.getElementById("modalRegionNameForPayment").innerText = regionName;
            document.getElementById("modalRegionName").parentElement.style.display = "block";
        } else {
            document.getElementById("modalRegionName").parentElement.style.display = "none";
        }

        if(time && time.trim() !== '') {
            document.getElementById("modalTime").innerText = time;
            document.getElementById("modalTime").parentElement.style.display = "block";
        } else {
            document.getElementById("modalTime").parentElement.style.display = "none";
        }

        if(category && category.trim() !== '') {
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
        console.log("startStopDate"+startStopDate);
        console.log("endStopDate"+endStopDate);
        console.log("safetyIdSeq"+safetyIdSeq);
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
            success: function(response) {
                closeModal();
                if (response === "일시정지업데이트") {
                    window.location.href = "/safetyCard/safetySettingOk";
                } else {
                    alert(response);
                }},
            error: function(error) {
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
