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
    <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
    <link rel="stylesheet" href="../../../resources/css/admin/adminCommon.css"/>
    <link rel="stylesheet" href="../../../resources/css/admin/adminFds.css"/>
</head>
<body>
<jsp:include page="adminHeader.jsp"/>
<div class="back-container">
    <div class="details">
        <jsp:include page="adminSideBar.jsp"/>
        <div class="detail__right">
            <h2 class="details____title"><img class="img-size-service" src="../../../resources/img/log.png">결제 로그 관리</h2>
            <div class="sub-container">
                <div class="alarm-info">해당 서비스의 모든 결제로그를 조회할 수 있습니다.</div>
                <div class="user-search">
                    <div class="search-header">카드 검색</div>
                    <input type="text" id="memberSearchInput" placeholder="카드번호를 입력하세요">
                    <button onclick="filterMembers()">검색</button>
                </div>
<%--                <div class="user-search">--%>
<%--                    <div class="search-header">회원 검색</div>--%>
<%--                    <select id="clusterSelect">--%>
<%--                        <option value="all">승인여부</option>--%>
<%--                        <c:forEach items="${clusterList}" var="clusterNum" varStatus="loop">--%>
<%--                            <option value="${clusterNum}">${clusterNum}번 군집</option>--%>
<%--                        </c:forEach>--%>
<%--                    </select>--%>
<%--                </div>--%>
                <table class="logdata-table">
                    <thead>
                    <tr>
                        <th>카드번호</th>
                        <th>거래일시<img src="../../../resources/img/sort1.png" alt="Icon for 아이디" class="th-icon" id="sortedIcon"></th>
                        <th>가맹점주소</th>
                        <th>업종</th>
                        <th>거래금액<img src="../../../resources/img/sort1.png" alt="Icon for 아이디" class="th-icon" id="sortIcon"></th>
                        <th>승인여부</th>
                        <th>이상탐지여부</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${paymentLogList}" var="paymentdata">
                        <tr onclick="showAnomalyDetails(${paymentdata.paymentLogId}, '${paymentdata.cardId}');"
                            style="cursor: pointer;">
                            <td>${fn:substring(paymentdata.cardId, 0, 4)}-****-****-${fn:substring(paymentdata.cardId, 15,20)}</td>
                            <td>${fn:substring(paymentdata.paymentDate, 0, 16)}</td>
                            <c:set var="addressParts" value="${fn:split(paymentdata.address, ' ')}"/>
                            <c:choose>
                                <c:when test="${fn:length(addressParts) >= 2}">
                                    <td>${addressParts[0]} ${addressParts[1]}</td>
                                </c:when>
                                <c:otherwise>
                                    <td>${paymentdata.address}</td>
                                </c:otherwise>
                            </c:choose>
                            <td>${paymentdata.categorySmall}</td>
                            <td style="text-align: right"><fmt:formatNumber value="${paymentdata.amount}" type="number" pattern="#,###"/>원</td>
                            <c:choose>
                                <c:when test="${paymentdata.paymentApprovalStatus == 'Y'}">
                                    <td style="text-align: center;">거래승인</td>
                                </c:when>
                                <c:otherwise>
                                    <td style="text-align: center;">미승인</td>
                                </c:otherwise>
                            </c:choose>
                            <td style="text-align: center;">
                                <c:choose>
                                    <c:when test="${paymentdata.fdsDetectionStatus == 'Y'}">이상</c:when>
                                    <c:otherwise>정상</c:otherwise>
                                </c:choose>
                            </td>
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
</body>
<jsp:include page="drawPaymentChart.jsp"/>
<script>

    // Get the modal
    var modal = document.getElementById("chartModal");

    // Get the <span> element that closes the modal
    var span = document.getElementsByClassName("close")[0];

    // When the user clicks on <span> (x), close the modal
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

    let currentPage = 1; // 현재 페이지
    const itemsPerPage = 10; // 페이지당 항목 수
    const pagesToShow = 10; // 한 번에 보여줄 페이지 수

    // 페이지를 업데이트하는 함수
    function updatePage() {
        const tbody = document.querySelector(".logdata-table tbody");
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
