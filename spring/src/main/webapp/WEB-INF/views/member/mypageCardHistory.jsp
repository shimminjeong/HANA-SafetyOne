<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<html>
<head>
    <title>Document</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<%--    <link href="../../../resources/css/admin/adminCommon.css" rel="stylesheet">--%>
    <link href="../../../resources/css/member/mypage.css" rel="stylesheet">
    <link href="../../../resources/css/member/mypageCardHistory.css" rel="stylesheet">
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
            <div class="sub-container-hearder">이용내역</div>
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
                    <img class="card-img">
                    <div class="card-list-info-cardid"><%=request.getAttribute("cardId")%>
                    </div>
                    <div class="card-list-info-name">본인&nbsp;&nbsp;|&nbsp;&nbsp;<%= name %>&nbsp;&nbsp;|&nbsp;&nbsp;
                    </div>
                    <div class="card-list-info-cardname"></div>
                </div>
            </div>
            <div class="table-div">
                <%--                <div class="menu-tab">--%>
                <%--                    <button class="tab-button" onclick="showApprovedTransactions()">거래승인내역</button>--%>
                <%--                    <button class="tab-button" onclick="showUnapprovedTransactions()">거래 미승인내역</button>--%>
                <%--                </div>--%>
                <table class="card-history-table">
                    <thead>
                    <tr>
                        <th>카드번호</th>
                        <th>거래일시</th>
                        <th>카테고리</th>
                        <th>가맹점주소</th>
                        <th>금액</th>
                        <th>승인여부</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${paymentLogList}" var="paymentLog">
                        <tr>
                            <td>${paymentLog.cardId}</td>
                            <td>${fn:substring(paymentLog.paymentDate, 0, 16)}</td>
                            <td>${paymentLog.categorySmall}</td>
                            <c:set var="addressParts" value="${fn:split(paymentLog.address, ' ')}"/>
                            <c:choose>
                                <c:when test="${fn:length(addressParts) >= 2}">
                                    <td>${addressParts[0]} ${addressParts[1]}</td>
                                </c:when>
                                <c:otherwise>
                                    <td>${paymentLog.address}</td>
                                </c:otherwise>
                            </c:choose>
                            <td><fmt:formatNumber value="${paymentLog.amount}" type="number" pattern="#,###"/>원</td>
                            <c:choose>
                                <c:when test="${paymentLog.paymentApprovalStatus == 'Y'}">
                                    <td>정상승인</td>
                                </c:when>
                                <c:otherwise>
                                    <td>미승인</td>
                                </c:otherwise>
                            </c:choose>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
                <div class="pagination">
                    <button id="prev">이전</button>
                    <div id="pageNumbers"></div>
                    <button id="next">이후</button>
                </div>
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

            var selectedCardName = $(this).find('option:selected').text();

            // cardName을 해당 div에 적용
            $('.card-list-info-cardname').text(selectedCardName);

            // 선택된 cardName을 기반으로 이미지 URL 변경
            $('.card-img').attr('src', '../../../resources/img/cardImg/' + selectedCardName + '.png');
            console.log("selectedCardName",selectedCardName)
        });

        $('#cardSelect').change(function() {
            var selectedCardName = $(this).find('option:selected').text();

            // cardName을 해당 div에 적용
            $('.card-list-info-cardname').text(selectedCardName);

            // 선택된 index를 기반으로 이미지 URL 변경 (선택되면 변경하려면 이 코드를 사용하세요.)
            var selectedCardIndex = $(this).find('option:selected').index();
            $('.card-img').attr('src', '../../../resources/img/'+selectedCardName+ '.png');
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
                    // console.log("Response" + response.paymentLogList)
                    $('.card-list-info-cardid').text(response.cardInfo.cardId);

                    // cardName 업데이트
                    $('.card-list-info-cardname').text(response.cardInfo.cardName);
                    var rows = $('tbody tr');

                    $.each(response.paymentLogList, function (index, history) {
                        // 각 행의 td 요소들을 가져온다.
                        var tds = $(rows[index]).find('td');

                        var addressParts = history.address.split(' ');

                        // 각 td의 텍스트를 바꿔준다.
                        $(tds[0]).text(history.cardId);
                        $(tds[1]).text(history.paymentDate.substring(0, 16));
                        $(tds[2]).text(history.categorySmall);
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


    document.getElementById("prev").addEventListener("click", function () {
        if (currentPage > 1) {
            currentPage--;
            updatePage();
        }
    });

    document.getElementById("next").addEventListener("click", function () {
        const tbody = document.querySelector(".card-history-table tbody");
        const rows = tbody.querySelectorAll("tr");
        const totalPages = Math.ceil(rows.length / itemsPerPage);

        if (currentPage < totalPages) {
            currentPage++;
            updatePage();
        }
    });


    let currentPage = 1; // 현재 페이지
    const itemsPerPage = 7; // 페이지당 항목 수
    const pagesToShow = 10; // 한 번에 보여줄 페이지 수

    // 페이지를 업데이트하는 함수
    function updatePage() {
        const tbody = document.querySelector(".card-history-table tbody");
        const rows = tbody.querySelectorAll("tr");
        const totalPages = Math.ceil(rows.length / itemsPerPage);

        // 모든 행을 숨깁니다.
        rows.forEach(row => row.style.display = "none");

        // 현재 페이지의 행만 표시합니다.
        for (let i = (currentPage - 1) * itemsPerPage; i < currentPage * itemsPerPage && i < rows.length; i++) {
            rows[i].style.display = "";
        }

        // 페이지 번호 버튼들을 업데이트합니다.
        const pageNumbersDiv = document.getElementById("pageNumbers");
        pageNumbersDiv.innerHTML = ""; // 이전에 있는 버튼들을 모두 제거
        const startPage = Math.floor((currentPage - 1) / pagesToShow) * pagesToShow + 1;
        const endPage = Math.min(startPage + pagesToShow - 1, totalPages);
        for (let i = startPage; i <= endPage; i++) {
            const btn = document.createElement("button");
            btn.textContent = i;
            if (i === currentPage) {
                btn.classList.add("current-page"); // 현재 페이지에 대한 스타일 적용
            }
            btn.addEventListener("click", function () {
                currentPage = i;
                updatePage();
            });
            pageNumbersDiv.appendChild(btn);
        }

        // Prev, Next 버튼의 활성/비활성 상태를 업데이트합니다.
        document.getElementById("prev").disabled = currentPage === 1;
        document.getElementById("next").disabled = currentPage === totalPages;
    }

    // 페이지를 처음 로드할 때 페이지를 업데이트합니다.
    updatePage();


</script>

</body>
</html>
