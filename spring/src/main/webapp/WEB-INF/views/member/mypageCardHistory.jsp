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
    <hr style="border:1px solid #00857F; margin:0px;">
    <div class="detail__right">
        <div class="sub-container">
            <div class="sub-container-hearder">카드이용내역</div>
            <div class="info">※ 카드를 선택하시면 카드별 이용내역을 확인할 수 있습니다.</div>

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
            <div class="user-search">
                <div class="search-header">카테고리 검색</div>
                <input type="text" id="memberSearchInput" placeholder="카테고리를 입력하세요">
                <button onclick="filterMembers()">검색</button>
            </div>
            <div class="info" style="margin-top: 10px;">※ 이용내역을 클릭할시 해당 결제에 대한 자세한 정보를 확인할 수 있습니다.</div>

            <div class="table-div">
                <%--                <div class="menu-tab">--%>
                <%--                    <button class="tab-button" onclick="showApprovedTransactions()">거래승인내역</button>--%>
                <%--                    <button class="tab-button" onclick="showUnapprovedTransactions()">거래 미승인내역</button>--%>
                <%--                </div>--%>
                <table class="card-history-table">
                    <thead>
                    <tr>
                        <th>카드번호</th>
                        <th>거래일시<img src="../../../resources/img/sort1.png" alt="Icon for 거래일자" class="th-icon" id="sortDateIcon"></th>
                        <th>카테고리<img src="../../../resources/img/sort1.png" alt="Icon for 거래일자" class="th-icon" id="sortCategoryIcon"></th>
                        <th>가맹점주소</th>
                        <th>금액<img src="../../../resources/img/sort1.png" alt="Icon for 거래일자" class="th-icon" id="sortAmountIcon"></th>
                        <th>승인여부</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${paymentLogList}" var="paymentLog">
                        <tr onclick="showReceipt(${paymentLog.paymentLogId}, '${paymentLog.cardId}');"
                            style="cursor: pointer;">
                            <c:set var="cardIdParts" value="${fn:split(paymentLog.cardId, '-')}"/>
                            <td>${cardIdParts[0]}-****-****-${cardIdParts[3]}</td>
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
                    <button id="next">다음</button>
                </div>
            </div>
        </div>
    </div>
</div>

<div id="receiptModal" class="modal">
    <div class="modal-body">
        <span class="close" onclick="closeModal()">&times;</span>
        <div class="modal-header"><img src="../../../resources/img/document.png">결제정보</div>
        <hr>
        <div class="modal-content">
            <div class="receipt-content-div">
                <div class="content-name-date">거래일자</div>
                <div class="content-value-time"></div>
            </div>
            <hr>
            <div class="receipt-content-div1">
                <div class="content-name1">결제구분</div>
                <div class="content-value">일시불</div>
            </div>
            <hr>
            <div class="receipt-content-div">
                <div class="content-name-amount">결제금액</div>
                <div class="content-value3"></div>
            </div>
            <hr>
            <div class="receipt-content-div">
                <div class="content-name">결제카드</div>
                <div class="content-value-cardName"></div>
            </div>
            <hr>
            <div class="receipt-content-div">
                <div class="content-name">승인번호</div>
                <div class="content-value-cardName">123122</div>
            </div>
            <hr>
            <div class="receipt-content-div">
                <div class="content-name">승인상태</div>
                <div class="content-approval"></div>
            </div>
            <div class="content-reason-value"></div>


            <div class="store-info">
                <div class="receipt-content-div" style="margin-bottom: 10px;">
                    <div class="content-value-address"></div>
                </div>
                <div class="receipt-content-div">
                    <div class="content-value-store"></div>
                    <div class="content-value-storedetail">가맹점상세<img src="../../../resources/img/down-arrow.png"></div>
                </div>
            </div>

        </div>
    </div>
</div>
<script>

    $(document).ready(function() {
        var ascendingAmount = false;
        var ascendingDate = false; // 날짜 정렬 상태를 추적하기 위한 플래그

        // 금액 컬럼 클릭 이벤트 핸들러
        $("#sortAmountIcon").click(function() {
            sortTable("금액", ascendingAmount,this);
            ascendingAmount = !ascendingAmount;
        });

        // 거래일시 컬럼 클릭 이벤트 핸들러
        $("#sortDateIcon").click(function() {
            sortTable("거래일시", ascendingDate,this);
            ascendingDate = !ascendingDate;
        });

        function sortTable(columnName, ascending,iconElement) {
            var $table = $(".card-history-table");
            var $rows = $table.find("tbody tr").toArray();

            $rows.sort(function(a, b) {
                var cellA = $(a).find("td:eq(" + getColumnIndex(columnName) + ")").text().trim();
                var cellB = $(b).find("td:eq(" + getColumnIndex(columnName) + ")").text().trim();

                if(columnName === "금액") {
                    cellA = parseFloat(cellA.replace(/[^\d.-]/g, ''));
                    cellB = parseFloat(cellB.replace(/[^\d.-]/g, ''));
                    return ascending ? cellA - cellB : cellB - cellA;
                } else { // 거래일시
                    return ascending ? cellA.localeCompare(cellB) : cellB.localeCompare(cellA);
                }
            });

            $table.find("tbody").empty().append($rows);
            if(ascending) {
                iconElement.src = "../../../resources/img/sort2.png";

            } else {
                iconElement.src = "../../../resources/img/sort1.png";

            }
            updatePage();


        }

        function getColumnIndex(columnName) {
            var $headerRow = $(".card-history-table thead tr");
            var columnIndex = -1;
            $headerRow.find("th").each(function(index) {
                if ($(this).text().trim().includes(columnName)) {
                    columnIndex = index;
                    return false; // break the loop
                }
            });
            return columnIndex;
        }
    });

    $(document).ready(function() {
        var ascendingAmount = false;

        // 금액 컬럼 클릭 이벤트 핸들러
        $("#sortAmountIcon").click(function() {
            sortTable("금액", ascendingAmount);
            ascendingAmount = !ascendingAmount;
        });

        function sortTable(columnName, ascending,iconElement) {
            var $table = $(".card-history-table");
            var $rows = $table.find("tbody tr").toArray();

            $rows.sort(function(a, b) {
                var keyA = parseFloat($(a).find("td:eq(" + getColumnIndex(columnName) + ")").text().replace(/[^\d.-]/g, ''));
                var keyB = parseFloat($(b).find("td:eq(" + getColumnIndex(columnName) + ")").text().replace(/[^\d.-]/g, ''));

                // 오름차순 또는 내림차순으로 정렬
                return ascending ? keyA - keyB : keyB - keyA;
            });

            $table.find("tbody").empty().append($rows);
            if(ascending) {
                iconElement.src = "../../../resources/img/sort2.png";

            } else {
                iconElement.src = "../../../resources/img/sort1.png";

            }

            updatePage();
        }

        function getColumnIndex(columnName) {
            var $headerRow = $(".card-history-table thead tr");
            var columnIndex = -1;
            $headerRow.find("th").each(function(index) {
                if ($(this).text().trim().includes(columnName)) {
                    columnIndex = index;
                    return false; // break the loop
                }
            });
            return columnIndex;
        }
    });




    function closeModal() {
        document.getElementById('receiptModal').style.display = 'none';
    }


    function showReceipt(paymentLogId, cardId) {
        console.log("paymentLogId", paymentLogId)

        console.log("cardId", cardId)
        $.ajax({
            type: 'POST',
            url: '/cardHistoryReceipt',
            data: JSON.stringify({
                paymentLogId: paymentLogId,
                cardId: cardId
            }),
            contentType: 'application/json',
            dataType: 'json',
            success: function (responseData) {
                console.log("responseData", responseData);
                console.log("responseData", responseData.paymentLog1);
                console.log("responseData", responseData.cardInfo);
                document.getElementById('receiptModal').style.display = 'block';
                if (responseData.paymentLog1.paymentApprovalStatus == 'Y') {

                    $('.content-approval').text('정상');

                } else {
                    $('.content-approval').text('미승인');
                    $('.content-reason-value').text('!안심서비스 이용으로 인한 거래미승인');
                    $('.content-reason-value').css('display', 'block');
                }
                var amount = responseData.paymentLog1.amount;
                var formattedAmount = amount.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
                $('.content-value3').text(formattedAmount + '원');


                $('.content-value-cardName').text(responseData.cardInfo.cardName);
                $('.content-value-cardId').text(responseData.paymentLog1.cardId.split);
                $('.content-value-store').text(responseData.paymentLog1.store);
                $('.content-value-address').text(responseData.paymentLog1.address);
                var validDate = responseData.cardInfo.validDate;
                var parts = validDate.split("-"); // '-'를 기준으로 문자열 분리
                var month = parts[1];
                var year = parts[0].substr(2, 2); // 연도의 마지막 두 자리
                $('.content-value4').text(month + '/' + year);

                // $('.content-value4').text(responseData.cardInfo.validDate);
                $('.content-value-time').text(responseData.paymentLog1.paymentDate);

            }
        })
    }

    window.onclick = function (event) {
        var modal = document.getElementById('receiptModal');
        if (event.target == modal) {
            modal.style.display = "none";
        }
    }

    $(document).ready(function () {

        $('#cardSelect').on('change', function () {
            if ($(this).val() !== "전체이용내역") {

                $('.lostcard-list').removeClass('hidden'); // hidden 클래스 제거
                $('.lostReason-select-div').removeClass('hidden'); // hidden 클래스 제거
            } else {
                $('.lostcard-list').addClass('hidden'); // hidden 클래스 추가
                $('.lostReason-select-div').addClass('hidden'); // hidden 클래스 추가
                window.location.href = "/mypageCardHistory";
            }

            var selectedCardName = $(this).find('option:selected').text();

            // cardName을 해당 div에 적용
            $('.card-list-info-cardname').text(selectedCardName);

            // 선택된 cardName을 기반으로 이미지 URL 변경
            $('.card-img').attr('src', '../../../resources/img/cardImg/' + selectedCardName + '.png');
            console.log("selectedCardName", selectedCardName)
        });

        $('#cardSelect').change(function () {
            var selectedCardName = $(this).find('option:selected').text();

            // cardName을 해당 div에 적용
            $('.card-list-info-cardname').text(selectedCardName);

            // 선택된 index를 기반으로 이미지 URL 변경 (선택되면 변경하려면 이 코드를 사용하세요.)
            var selectedCardIndex = $(this).find('option:selected').index();
            $('.card-img').attr('src', '../../../resources/img/' + selectedCardName + '.png');
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
                    $('.card-list-info-cardid').text(response.cardInfo.cardId.split('-')[0] + "-****-****-" + response.cardInfo.cardId.split('-')[3]);

                    // cardName 업데이트
                    $('.card-list-info-cardname').text(response.cardInfo.cardName);
                    var rows = $('tbody tr');

                    $.each(response.paymentLogList, function (index, history) {
                        // 각 행의 td 요소들을 가져온다.
                        var tds = $(rows[index]).find('td');

                        var addressParts = history.address.split(' ');

                        var cardId = history.cardId;
                        var segments = cardId.split('-');

                        if (segments.length === 4) {
                            segments[1] = '****';
                            segments[2] = '****';
                        }
                        var maskedCardId = segments.join('-');

                        // 각 td의 텍스트를 바꿔준다.
                        $(tds[0]).text(maskedCardId);
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
    const itemsPerPage = 10; // 페이지당 항목 수
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
