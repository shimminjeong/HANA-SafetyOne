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
                    <c:forEach items="${cards}" var="card" varStatus="loop">
                        <option value="${card.cardId}">${card.cardName}</option>
                    </c:forEach>
                </select>
            </div>
            <div class="lostcard-list">
                <div class="card-list-info" id="<%=request.getAttribute("cardId")%>">
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
                    <button id="prev">Prev</button>
                    <div id="pageNumbers"></div>
                    <button id="next">Next</button>
                </div>


            </div>
        </div>
    </div>
</div>
<script>

    document.getElementById("prev").addEventListener("click", function() {
        if (currentPage > 1) {
            currentPage--;
            updatePage();
        }
    });

    document.getElementById("next").addEventListener("click", function() {
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
            btn.addEventListener("click", function() {
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
