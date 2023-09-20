<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<html>
<head>
    <title>Document</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <link href="../../../resources/css/admin/adminCommon.css" rel="stylesheet">
    <link href="../../../resources/css/member/mypageCardHistory.css" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/chart.js/dist/Chart.js"></script>

</head>

<body>
<%@ include file="../include/header.jsp" %>
<div class="details">
    <div class="details__left">
        <ul class="menu">
            <li class="menu__item">
                <a href="/mypage" class="menu__link">
                    <div class="menu__icon"><img src="../../../resources/img/bell%20(1).png"></div>
                    대시보드
                </a>
            </li>
            <li class="menu__item">
                <a href="/mypageCardHistory" class="menu__link">
                    <div class="menu__icon"><img src="../../../resources/img/bell%20(1).png"></div>
                    이용내역
                </a>
            </li>
        </ul>
    </div>
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
                    <div class="card-list-info-cardid"><%=request.getAttribute("cardId")%>
                    </div>
                    <div class="card-list-info-name">본인&nbsp;&nbsp;|&nbsp;&nbsp;<%= name %>&nbsp;&nbsp;|&nbsp;&nbsp;
                    </div>
                    <div class="card-list-info-cardname">yolo</div>
                    <img class="card-img" src="../../../resources/img/cardImg${loop.index + 1}.png">
                </div>
            </div>
            <div class="if 조건">
                <table class="card-history-table">
                    <thead>
                    <tr>
                        <th>카드번호</th>
                        <th>거래일시</th>
                        <th>거래처명</th>
                        <th>금액</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${cardHistoryList}" var="history">
                        <tr>
                            <td>${history.cardId}</td>
                            <td>${fn:substring(history.cardHisDate, 0, 16)}</td>
                            <td>${history.store}</td>
                            <td><fmt:formatNumber value="${history.amount}" type="number" pattern="#,###"/>원</td>
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

        $('#cardSelect').on('change', function() {
            if ($(this).val() !== "전체이용내역") {
                $('.lostcard-list').removeClass('hidden'); // hidden 클래스 제거
            } else {
                $('.lostcard-list').addClass('hidden'); // hidden 클래스 추가
            }
        });

        // 함수 정의
        function sendCardIdToServer(cardId) {
            $.ajax({
                type: "POST",
                url: "/cardHistoryDetail",
                contentType: "application/json",
                data: JSON.stringify({cardId: cardId}),
                success: function (response) {
                    $('.card-list-info-cardid').text(response.cardInfo.cardId);

                    // cardName 업데이트
                    $('.card-list-info-cardname').text(response.cardInfo.cardName);
                    var rows = $('tbody tr');

                    $.each(response.cardHistoryList, function (index, history) {
                        // 각 행의 td 요소들을 가져온다.
                        var tds = $(rows[index]).find('td');

                        // 각 td의 텍스트를 바꿔준다.
                        $(tds[0]).text(history.cardId);
                        $(tds[1]).text(history.cardHisDate.substring(0, 16));
                        $(tds[2]).text(history.store);
                        $(tds[3]).text(Number(history.amount).toLocaleString() + "원");
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
