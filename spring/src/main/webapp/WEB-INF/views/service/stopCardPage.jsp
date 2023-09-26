<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/chart.js@3.5.1/dist/chart.min.js"></script>
    <link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
    <link href="../../../resources/css/safetyCardCommon.css" rel="stylesheet">
    <link href="../../../resources/css/safetySettingNew.css" rel="stylesheet">
    <link href="../../../resources/css/lostcard.css" rel="stylesheet">
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
            <div>특정 기간동안 안심카드서비스를 일시정지할 조합을 선택하세요</div>
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
                    <!-- 추가로 다른 칼럼도 포함시킬 수 있습니다. -->
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

        // 지역 체크
        if(regionName && regionName.trim() !== '') {
            document.getElementById("modalRegionName").innerText = regionName;
            document.getElementById("modalRegionNameForPayment").innerText = regionName;
            document.getElementById("modalRegionName").parentElement.style.display = "block";
        } else {
            document.getElementById("modalRegionName").parentElement.style.display = "none";
        }

        // 시간 체크
        if(time && time.trim() !== '') {
            document.getElementById("modalTime").innerText = time;
            document.getElementById("modalTime").parentElement.style.display = "block";
        } else {
            document.getElementById("modalTime").parentElement.style.display = "none";
        }

        // 업종 체크
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
            data: JSON.stringify({            // <--- 수정
                safetyIdSeq: safetyIdSeq,
                stopStartDate: startStopDate,
                stopEndDate: endStopDate
            }),
            contentType: "application/json", // <-- 추가
            success: function(response) {
                closeModal();
                if (response === "일시정지업데이트") {
                    window.location.href = "/safetyCard/safetySettingOk"; // 페이지 리다이렉트
                } else {
                    alert(response); // 그렇지 않으면 서버의 응답을 그대로 경고로 표시합니다.
                }},
            error: function(error) {
                alert("Something went wrong: " + error.statusText);
            }
        });
    }



    $("#startdatepicker").datepicker({
        dateFormat: 'yy-mm-dd' //달력 날짜 형태
        , showOtherMonths: true //빈 공간에 현재월의 앞뒤월의 날짜를 표시
        , showMonthAfterYear: true // 월- 년 순서가아닌 년도 - 월 순서
        , changeYear: true //option값 년 선택 가능
        , changeMonth: true //option값  월 선택 가능
        , yearSuffix: "년" //달력의 년도 부분 뒤 텍스트
        , monthNamesShort: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'] //달력의 월 부분 텍스트
        , monthNames: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'] //달력의 월 부분 Tooltip
        , dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'] //달력의 요일 텍스트
        , dayNames: ['일요일', '월요일', '화요일', '수요일', '목요일', '금요일', '토요일'] //달력의 요일 Tooltip
        , minDate: "-5Y" //최소 선택일자(-1D:하루전, -1M:한달전, -1Y:일년전)
        , maxDate: "+5y" //최대 선택일자(+1D:하루후, -1M:한달후, -1Y:일년후)
    });

    $("#enddatepicker").datepicker({
        dateFormat: 'yy-mm-dd' //달력 날짜 형태
        , showOtherMonths: true //빈 공간에 현재월의 앞뒤월의 날짜를 표시
        , showMonthAfterYear: true // 월- 년 순서가아닌 년도 - 월 순서
        , changeYear: true //option값 년 선택 가능
        , changeMonth: true //option값  월 선택 가능
        , yearSuffix: "년" //달력의 년도 부분 뒤 텍스트
        , monthNamesShort: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'] //달력의 월 부분 텍스트
        , monthNames: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'] //달력의 월 부분 Tooltip
        , dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'] //달력의 요일 텍스트
        , dayNames: ['일요일', '월요일', '화요일', '수요일', '목요일', '금요일', '토요일'] //달력의 요일 Tooltip
        , minDate: "-5Y" //최소 선택일자(-1D:하루전, -1M:한달전, -1Y:일년전)
        , maxDate: "+5y" //최대 선택일자(+1D:하루후, -1M:한달후, -1Y:일년후)
    });

</script>
</body>
</html>
