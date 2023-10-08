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
    <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
    <link href="../../../resources/css/common.css" rel="stylesheet">
    <link href="../../../resources/css/member/mypageCardHistory.css" rel="stylesheet">
    <link href="../../../resources/css/member/safetyCardStop.css" rel="stylesheet">
    <link rel="stylesheet" href="http://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
    <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
</head>

<body>
<%@ include file="../include/header.jsp" %>
<div class="stopCardContainer">
    <div class="sub-container-hearder">안심서비스 변경</div>

    <div class="card-select-div">
        <div class="card-select-text">카드선택</div>
        <select id="cardSelect">
            <option value="카드선택" selected>카드선택</option>
            <c:forEach items="${safetyCardList}" var="safetyCard" varStatus="loop">
                <option value="${safetyCard.cardId}">${safetyCard.cardName}</option>
            </c:forEach>
        </select>
    </div>
    <div class="lostcard-list hidden">
        <div class="card-list-info">
            <div class="card-list-info-cardid">
            </div>
            <div class="card-list-info-name">
            </div>
            <div class="card-list-info-cardname"></div>
            <img class="card-img" src="../../../resources/img/cardImg${loop.index + 1}.png">
        </div>
    </div>
    <div class="serviceDate1 hidden">
        <h4>해당서비스는 결제를 차단한 나만의 rule 중에서 일정기간동안 결제를 허용하는 서비스입니다.</h4>
        <div style="margin-bottom: 3%;">특정 기간동안 안심서비스를 일시정지할 조합을 선택하세요</div>
        <div style="color:red;">※ 특정 기간동안 선택한 조합의 결제가 허용됩니다.</div>
    </div>
    <div class="table-div hidden">
        <div style="margin-top: 3%; font-size: 20px;"> 차단한 나만의 rule</div>
        <table>
            <thead>
            <tr>
                <th><input type="checkbox" id="selectAllCheckbox" /></th>
                <th>지역</th>
                <th>시간</th>
                <th>업종</th>
            </tr>
            </thead>
            <tbody>
            </tbody>
        </table>
    </div>
    <div class="map-div hidden">
        <div style="margin-top: 3%; font-size: 20px;"> 차단한 지역 한눈에 보기</div>
<%--        <div class="img-div">--%>
<%--            <img src="../../../resources/img/map_3.png">--%>
<%--        </div>--%>
        <div class="region"></div>
    </div>
    <div class="reg-cancle-btn hidden">
        <button class="reg-Btn" onclick="stopCard()">일시정지</button>
    </div>
</div>
<div id="pauseModal">
    <h2>결제를 허용할 기간 설정</h2>
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
    <div>해당기간동안 <span id="modalRegionNameForPayment"></span>지역의 결제를 허용하시겠습니까?</div>
    <button onclick="confirmPause()">확인</button>
    <button onclick="closeModal()">취소</button>
</div>
</body>
<script>

    $(document).ready(function() {
        // "모두 선택" 체크박스 클릭 이벤트
        $('#selectAllCheckbox').on('change', function() {
            if ($(this).prop('checked')) {
                $('.table-div tbody input[type="checkbox"]').prop('checked', true); // 모든 체크박스 선택
            } else {
                $('.table-div tbody input[type="checkbox"]').prop('checked', false); // 모든 체크박스 선택 해제
            }
        });

        // 개별 체크박스 클릭 시 "모두 선택" 체크박스의 상태를 확인/변경하는 이벤트
        $('.table-div tbody').on('change', 'input[type="checkbox"]', function() {
            if ($('.table-div tbody input[type="checkbox"]').length == $('.table-div tbody input[type="checkbox"]:checked').length) {
                $('#selectAllCheckbox').prop('checked', true); // 모든 체크박스가 선택되면 "모두 선택"도 선택
            } else {
                $('#selectAllCheckbox').prop('checked', false); // 아니면 선택 해제
            }
        });
    });


    $(document).ready(function () {

        $('#cardSelect').on('change', function () {
            if ($(this).val() !== "카드선택") {
                $('.lostcard-list').removeClass('hidden'); // hidden 클래스 제거
                $('.table-div').removeClass('hidden'); // hidden 클래스 제거
                $('.reg-cancle-btn').removeClass('hidden'); // hidden 클래스 제거
                $('.serviceDate1').removeClass('hidden');
                $('.map-div').removeClass('hidden');
            } else {
                $('.lostcard-list').addClass('hidden'); // hidden 클래스 추가
                $('.table-div').addClass('hidden'); // hidden 클래스 추가
                $('.serviceDate1').addClass('hidden'); // hidden 클래스 추가
                $('.map-div').addClass('hidden'); // hidden 클래스 추가
            }
        });

        // 함수 정의
        function sendSafetyCardIdToServer(cardId) {
            console.log("cardId" + cardId)
            $.ajax({
                type: "POST",
                url: "/safetyCard/stopCardDetail",
                contentType: "application/json",
                data: JSON.stringify({cardId: cardId}),
                success: function (response) {
                    console.log(response);

                    // Update card details
                    $('.card-list-info-cardid').text(response.cardInfo.cardId);
                    $('.card-list-info-name').text("본인 | " + response.cardInfo.cardName);

                    var startDate = response.safetyInfo[0].safetyStartDate.split(" ")[0];
                    var endDate = response.safetyInfo[0].safetyEndDate.split(" ")[0];
                    $('.serviceDate').text("서비스유효기간 | " + startDate + " ~ 카드유효기간(" + endDate + ")");

                    // Clear existing rows from the tbody
                    $('.table-div tbody').empty();

                    // Add new rows from the response data
                    $.each(response.safetyRuleList, function (index, info) {
                        var newRow = $("<tr>");
                        var pauseCheckbox = $("<input>")
                            .attr('type', 'checkbox')
                            .attr('data-seq-id', info.safetyIdSeq)
                            .attr('data-card-id', info.cardId)
                            .attr('data-region-name', info.regionName)
                            .attr('data-time', info.time)
                            .attr('data-category', info.categorySmall);

                        newRow.append($("<td>").append(pauseCheckbox));
                        newRow.append($("<td>").text(info.regionName || "")); // null check
                        newRow.append($("<td>").text(info.time || "")); // null check
                        newRow.append($("<td>").text(info.categorySmall || ""));

                        $('.table-div tbody').append(newRow);
                    });

                    $.each(response.safetyRegionList, function(index, info) {
                        var buttonElement = $("<button>")
                            .attr('data-seq-id', info.safetyIdSeq)
                            .attr('data-card-id', info.cardId)
                            .attr('data-region-name', info.regionName)
                            .attr('data-time', info.time)
                            .attr('data-category', info.categorySmall)
                            .text(info.regionName || "") // null check
                            .addClass("custom-button-style"); // 추가 스타일을 적용하려면 클래스를 추가

                        $(".region").append(buttonElement);
                    });

                },
                error: function (error) {
                    console.error("Error sending data:", error);
                }
            });
        }

        // select 요소 값 변경 감지
        $("#cardSelect").change(function () {
            var selectedCardId = $(this).val();
            sendSafetyCardIdToServer(selectedCardId);
        });

    });


    function stopCard() {
        // 선택된 체크박스를 가져옵니다.
        var checkedBoxes = $("input[type='checkbox']:checked");

        // 체크박스가 선택되지 않았다면 경고를 표시하십시오.
        if (checkedBoxes.length === 0) {
            alert("일시정지할 카드를 선택하십시오.");
            return;
        }

        // 선택된 체크박스를 순회하며 데이터를 가져옵니다.
        checkedBoxes.each(function () {
            var checkbox = $(this);

            var seqId = checkbox.attr('data-seq-id');
            var cardId = checkbox.attr('data-card-id');
            var regionName = checkbox.attr('data-region-name');
            var time = checkbox.attr('data-time');
            var category = checkbox.attr('data-category');

            // 데이터를 모달에 설정합니다.
            // (참고: 이 예제에서는 첫 번째 선택된 체크박스의 데이터만 모달에 표시됩니다.
            // 여러 행의 데이터를 동시에 모달에 표시하려면 이 로직을 수정해야 합니다.)
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
        });

        // 모달을 표시합니다.
        document.getElementById("pauseModal").style.display = "block";
    }

    // 버튼 클릭시 호출할 함수
    function toggleButtonState(button) {
        $(button).toggleClass('active'); // 활성화된 버튼에 'active' 클래스 추가
        if ($(button).hasClass('active')) {
            $(button).css('background-color', 'your_selected_color'); // 원하는 선택된 배경색으로 변경
        } else {
            $(button).css('background-color', 'your_default_color'); // 기본 배경색으로 변경
        }
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
            data: JSON.stringify({            // <--- 수정
                safetyIdSeq: safetyIdSeq,
                stopStartDate: startStopDate,
                stopEndDate: endStopDate
            }),
            contentType: "application/json", // <-- 추가
            success: function (response) {
                closeModal();
                if (response === "일시정지업데이트") {
                    window.location.href = "/safetyCard/safetySettingOk"; // 페이지 리다이렉트
                } else {
                    alert(response); // 그렇지 않으면 서버의 응답을 그대로 경고로 표시합니다.
                }
            },
            error: function (error) {
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
</html>


