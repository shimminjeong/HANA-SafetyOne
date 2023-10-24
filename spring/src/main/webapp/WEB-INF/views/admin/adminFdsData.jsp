<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Document</title>
    <link rel="stylesheet" href="../../../resources/css/admin/adminCommon.css"/>
    <link rel="stylesheet" href="../../../resources/css/admin/adminFds.css"/>
    <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>

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
                        <div class="menu__icon"><img src="../../../resources/img/secure-payment.png"></div>
                        안심서비스
                    </a>
                </li>
                <li class="menu__item">
                    <a href="/admin/fds" class="menu__link active">
                        <div class="menu__icon"><img src="../../../resources/img/bellcolor.png"></div>
                        이상소비알림서비스
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
                    <a href="/admin/lostCard" class="menu__link">
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
            <h2 class="details____title"><img class="img-size-service" src="../../../resources/img/bellcolor.png">이상소비알림서비스 관리</h2>
            <div class="box-container">
                <div class="info-box1" onclick="window.location.href='/admin/fds'">
                    <div class="info-content2">
                        <div class="box-header">이용자 수</div>
                        <div>${fdsUserCount}명</div>
                    </div>
                    <div class="info-content3"><img src="../../../resources/img/id-card.png"></div>
                </div>
                <div class="info-box" onclick="window.location.href='/admin/fds'">
                    <div class="info-content2">
                        <div class="box-header">이용중인 카드 수</div>
                        <div>${fdsCardCount}개</div>
                    </div>
                    <div class="info-content3"><img src="../../../resources/img/credit-card_.png"></div>
                </div>
                <div style="background-color: #eee;"  class="info-box1" onclick="window.location.href='/admin/fdsData'">
                    <div class="info-content2">
                        <div class="box-header">금일 이상소비 건수</div>
                        <div>${fdsDataCount}건</div>
                    </div>
                    <div class="info-content3"><img src="../../../resources/img/log_.png"></div>
                </div>
            </div>

            <div class="table-container">
                <h3>이상소비탐지 거래내역</h3>
                <div class="alarm-info">※ 거래내역을 클릭하면 이상치로 탐지된 확률분포 그래프를 확인할 수 있습니다.</div>
                <div class="user-search">
                    <div class="search-header">카드 검색</div>
                    <input type="text" id="cardSearchInput" placeholder="카드번호를 입력하세요">
                    <button onclick="filterCard()">검색</button>
                </div>
                <table class="fdsdata-table">
                    <thead>
                    <tr>
                        <th>카드번호</th>
                        <th>
                            거래일시
                            <img src="../../../resources/img/sort1.png" alt="Icon for 거래일자" class="th-icon" id="sortDateIcon">
                        </th>
                        <th>가맹점명</th>
                        <th>업종</th>
                        <th>
                            거래금액
                            <img src="../../../resources/img/sort1.png" alt="Icon for 거래가격" class="th-icon" id="sortAmountIcon">
                        </th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${anomalyList}" var="anomalydata">
                        <tr onclick="showAnomalyDetails(${anomalydata.paymentLogId}, '${anomalydata.cardId}');"
                            style="cursor: pointer;">
                            <td data-cardId="${anomalydata.cardId}">${fn:substring(anomalydata.cardId, 0, 4)}-****-****-${fn:substring(anomalydata.cardId, 15,20)}</td>
                            <td>${anomalydata.paymentDate}</td>
                            <td>${anomalydata.store}</td>
                            <td>${anomalydata.categorySmall}</td>
                            <td style="text-align: right;"><fmt:formatNumber value="${anomalydata.amount}" type="number" pattern="#,###"/>원</td>
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
<!-- drawPaymentChart Modal -->
<jsp:include page="drawPaymentChart.jsp"/>

<script>


    function filterCard() {
        var cardSearchInput = document.getElementById("cardSearchInput").value;
        var table = document.querySelector(".fdsdata-table");
        var rows = table.getElementsByTagName("tr");

        for (var i = 0; i < rows.length; i++) {
            var row = rows[i];
            var cardNumberCell = row.querySelector("td[data-cardId]");
            if (cardNumberCell) {
                var cellValue = cardNumberCell.getAttribute("data-cardId");
                if (cellValue.includes(cardSearchInput)) {
                    row.style.display = "";
                } else {
                    row.style.display = "none";
                }
            }
        }
    }


    $(document).ready(function () {
        var ascendingAmount = false;

        $("#sortAmountIcon").click(function () {
            sortTable("amount", ascendingAmount);
            ascendingAmount = !ascendingAmount;
        });

        function sortTable(column, ascending) {
            var $table = $(".fdsdata-table");
            var $rows = $table.find("tbody tr").toArray();

            $rows.sort(function (a, b) {
                var keyA = parseFloat($(a).find("td:eq(" + getColumnIndex(column) + ")").text().replace(/[^\d.-]/g, ''));
                var keyB = parseFloat($(b).find("td:eq(" + getColumnIndex(column) + ")").text().replace(/[^\d.-]/g, ''));

                return ascending ? keyA - keyB : keyB - keyA;
            });
ㄴ
            $table.find("tbody").empty().append($rows);

            updatePage();
        }

        function getColumnIndex(columnName) {
            var $headerRow = $(".fdsdata-table thead tr");
            var columnIndex = -1;
            $headerRow.find("th").each(function (index) {
                if ($(this).text().trim() === columnName) {
                    columnIndex = index;
                    return false; // break the loop
                }
            });
            return columnIndex;
        }
    });

    var modal = document.getElementById("chartModal");

    var span = document.getElementsByClassName("close")[0];

    span.onclick = function () {
        modal.style.display = "none";
    }

    // 페이지네이션
    document.getElementById("prev").addEventListener("click", function () {
        if (currentPage > 1) {
            currentPage--;
            updatePage();
        }
    });

    document.getElementById("next").addEventListener("click", function () {
        const tbody = document.querySelector(".member-info-table tbody");
        const rows = tbody.querySelectorAll("tr");
        const totalPages = Math.ceil(rows.length / itemsPerPage);

        if (currentPage < totalPages) {
            currentPage++;
            updatePage();
        }
    });

    let currentPage = 1;
    const itemsPerPage = 10;
    const pagesToShow = 10;


    function updatePage() {
        const tbody = document.querySelector(".fdsdata-table tbody");
        const rows = tbody.querySelectorAll("tr");
        const totalPages = Math.ceil(rows.length / itemsPerPage);


        rows.forEach(row => row.style.display = "none");


        for (let i = (currentPage - 1) * itemsPerPage; i < currentPage * itemsPerPage && i < rows.length; i++) {
            rows[i].style.display = "";
        }


        const pageNumbersDiv = document.getElementById("pageNumbers");
        pageNumbersDiv.innerHTML = "";
        const startPage = Math.floor((currentPage - 1) / pagesToShow) * pagesToShow + 1;
        const endPage = Math.min(startPage + pagesToShow - 1, totalPages);
        for (let i = startPage; i <= endPage; i++) {
            const btn = document.createElement("button");
            btn.textContent = i;
            if (i === currentPage) {
                btn.classList.add("current-page");
            }
            btn.addEventListener("click", function () {
                currentPage = i;
                updatePage();
            });
            pageNumbersDiv.appendChild(btn);
        }

        document.getElementById("prev").disabled = currentPage === 1;
        document.getElementById("next").disabled = currentPage === totalPages;
    }


    updatePage();


</script>
</body>
</html>
