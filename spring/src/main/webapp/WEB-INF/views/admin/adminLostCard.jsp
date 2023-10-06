<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Document</title>
    <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
    <link rel="stylesheet" href="../../../resources/css/admin/adminCommon.css"/>
    <link rel="stylesheet" href="../../../resources/css/admin/adminLostCard.css"/>

</head>
<body>
<jsp:include page="adminHeader.jsp"/>
<div class="back-container">
    <div class="details">
        <div class="details__left">
            <ul class="menu">
                <li class="menu__item">
                    <a href="/admin/" class="menu__link">
                        <div class="menu__icon"><img src="../../../resources/img/dashboard.png"></div>
                        대시보드
                    </a>
                </li>
                <li class="menu__item">
                    <a href="/admin/safety" class="menu__link">
                        <div class="menu__icon"><img src="../../../resources/img/credit-card.png"></div>
                        안심카드서비스
                    </a>
                </li>
                <li class="menu__item">
                    <a href="/admin/fds" class="menu__link">
                        <div class="menu__icon"><img src="../../../resources/img/bellcolor.png"></div>
                        이상거래서비스
                    </a>
                </li>
                <li class="menu__item">
                    <a href="/admin/cluster" class="menu__link">
                        <div class="menu__icon"><img src="../../../resources/img/networking.png"></div>
                        군집분석
                    </a>
                </li>
                <li class="menu__item">
                    <a href="/admin/email" class="menu__link">
                        <div class="menu__icon"><img src="../../../resources/img/gmail.png"></div>
                        이메일전송
                    </a>
                </li>
                <li class="menu__item">
                    <a href="/admin/lostCard" class="menu__link active">
                        <div class="menu__icon"><img src="../../../resources/img/lostcard.png"></div>
                        분실카드관리
                    </a>
                </li>
                <li class="menu__item">
                    <a href="/admin/paymentLogData" class="menu__link">
                        <div class="menu__icon"><img src="../../../resources/img/log.png"></div>
                        결제로그
                    </a>
                </li>
            </ul>
        </div>
        <div class="detail__right">
            <h2 class="details____title">카드분실내역관리</h2>
            <div class="sub-container">
                <div class="lost-info">
                    <div class="lostReason-select-div">
                        <div class="lostReason-select-text">분실사유</div>
                        <div class="lostReason-select">
                            <select id="lostReasonSelect">
                                <c:forEach items="${reasonList}" var="reason" varStatus="loop">
                                    <option value="${reason}">${reason.lostReason}</option>
                                </c:forEach>
                            </select>
                        </div>
                    </div>
                    <div class="lostCard-table">
                        <table>
                            <thead>
                            <tr>
                                <th>카드번호</th>
                                <th>분실일자</th>
                                <th>분실장소</th>
                                <th>분실사유</th>
                                <th>재발급여부</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach items="${lostCardList}" var="lostCard">
                                <tr>
                                    <td>${lostCard.cardId}</td>
                                    <td>${fn:substring(lostCard.lostDate, 0, 10)}</td>
                                    <td>${lostCard.lostPlace}</td>
                                    <td>${lostCard.lostReason}</td>
                                    <td>${lostCard.reissued}</td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script>

    $(document).ready(function () {
        $("#lostReasonSelect").on("change", function () {
            var selectedReason = $(this).val();

            var regex = /lostReason='(.*?)'/;
            var match = selectedReason.match(regex);

            if (match && match[1]) {
                var lostReasonValue = match[1];
                filterTableByLostReason(lostReasonValue);
            }
        });
    });

    function filterTableByLostReason(lostReasonValue) {
        // 모든 행을 숨깁니다.
        $(".lostCard-table tbody tr").hide();

        // 선택된 분실사유와 일치하는 행만 표시합니다.
        $(".lostCard-table tbody tr").each(function () {
            var reasonInRow = $(this).find("td:nth-child(4)").text(); // 4번째 열 (Lost Reason)의 값 가져오기
            if (reasonInRow === lostReasonValue) {
                $(this).show();
            }
        });
    }


    // $(document).ready(function () {
    //
    //     // 함수 정의
    //     function sendReasonToServer(reason) {
    //         $.ajax({
    //             type: "POST",
    //             url: "/admin/lostReason",
    //             contentType: "application/json",
    //             data: JSON.stringify({cardId: cardId}),
    //             success: function (response) {
    //                 console.log("Response" + response.paymentLogList)
    //                 $('.card-list-info-cardid').text(response.cardInfo.cardId);
    //
    //                 // cardName 업데이트
    //                 $('.card-list-info-cardname').text(response.cardInfo.cardName);
    //                 var rows = $('tbody tr');
    //
    //
    //             },
    //             error: function (error) {
    //                 // 실패 시 수행할 작업 (예: 오류 메시지 표시)
    //                 console.error("Error sending data:", error);
    //             }
    //         });
    //     }
    //
    //     // select 요소 값 변경 감지
    //     $("#lostReasonSelect").change(function () {
    //         var selectedCardId = $(this).val();
    //         sendCardIdToServer(selectedCardId);
    //     });
    //
    // });

</script>
</body>
</html>
