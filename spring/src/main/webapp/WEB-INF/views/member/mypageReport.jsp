<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<html>
<head>
    <title>Document</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <link href="../../../resources/css/admin/adminCommon.css" rel="stylesheet">
    <link href="../../../resources/css/member/mypage.css" rel="stylesheet">
    <link href="../../../resources/css/member/mypageReport.css" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/chart.js/dist/Chart.js"></script>

</head>

<body>
<%@ include file="../include/header.jsp" %>
<div class="details">
    <%@ include file="../include/mypageSideBar.jsp" %>
    <hr style="border:1px solid #00857F">
    <div class="detail__right">
        <div class="sub-container">
            <div class="sub-container-hearder">소비레포트</div>
            <div class="card-select-div">
                <div class="card-select-text">카드선택</div>
                <select id="cardSelect">
                    <option value="전체이용내역" selected>전체이용내역</option>
                    <c:forEach items="${cards}" var="card" varStatus="loop">
                        <option value="${card.cardId}">${card.cardName}</option>
                    </c:forEach>
                </select>
            </div>
            <div class="lostcard-list hidden">
                <div class="card-list-info">
                    <div class="card-list-info-cardid"><%=request.getAttribute("cardId")%>
                    </div>
                    <div class="card-list-info-name">본인&nbsp;&nbsp;|&nbsp;&nbsp;<%= name %>&nbsp;&nbsp;|&nbsp;&nbsp;
                    </div>
                    <div class="card-list-info-cardname">yolo</div>
                    <img class="card-img" src="../../../resources/img/cardImg${loop.index + 1}.png">
                </div>
            </div>
            <div class="table-div">

            </div>
        </div>
    </div>
</div>
    <script>

        $(document).ready(function () {

            $('#cardSelect').on('change', function () {
                if ($(this).val() !== "전체이용내역") {
                    $('.lostcard-list').removeClass('hidden'); // hidden 클래스 제거
                } else {
                    $('.lostcard-list').addClass('hidden'); // hidden 클래스 추가
                }
            });

            // 함수 정의
            function sendCardIdToServer(cardId) {
                console.log("cardId" + cardId)
                $.ajax({
                    type: "POST",
                    url: "/cardHistoryDetail",
                    contentType: "application/json",
                    data: JSON.stringify({cardId: cardId}),
                    success: function (response) {
                        console.log("Response" + response.paymentLogList)
                        $('.card-list-info-cardid').text(response.cardInfo.cardId);

                        // cardName 업데이트
                        $('.card-list-info-cardname').text(response.cardInfo.cardName);
                        var rows = $('tbody tr');

                        $.each(response.paymentLogList, function (index, history) {
                            // 각 행의 td 요소들을 가져온다.
                            var tds = $(rows[index]).find('td');
                            console.log("history.cardId+" + history.cardId);
                            console.log("history.cardHisDate+" + history.paymentDate);
                            console.log("history.store+" + history.store);

                            var addressParts = history.address.split(' ');

                            // 각 td의 텍스트를 바꿔준다.
                            $(tds[0]).text(history.cardId);
                            $(tds[1]).text(history.paymentDate.substring(0, 16));
                            $(tds[2]).text(history.store);
                            if (addressParts.length >= 2) {
                                var shortenedAddress = addressParts[0] + ' ' + addressParts[1];
                                $(tds[3]).text(shortenedAddress);
                            } else {
                                $(tds[3]).text(history.address); // Fallback to the full address if splitting didn't work as expected
                            }
                            $(tds[4]).text(Number(history.amount).toLocaleString() + "원");
                            if (history.paymentApprovalStatus === 'Y') {
                                $(tds[5]).text('정상승인');
                            } else {
                                $(tds[5]).text('미승인');
                            }

                        });
                    },
                    error: function (error) {
                        // 실패 시 수행할 작업 (예: 오류 메시지 표시)
                        console.error("Error sending data:", error);
                    }
                });
            }

            // select 요소 값 변경 감지
            $("#cardSelect").change(function () {
                var selectedCardId = $(this).val();
                sendCardIdToServer(selectedCardId);
            });

        });


    </script>

</body>
</html>
