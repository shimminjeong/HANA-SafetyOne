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
        <jsp:include page="adminSideBar.jsp"/>
        <div class="detail__right">
            <h2 class="details____title">안심카드 서비스관리</h2>
            <div class="box-container">
                <div class="info-box" onclick="window.location.href='/admin/safety'">
                    <div class="info-content2">
                        <div class="box-header">이용자 수</div>
                        <div>${safetyUserCount}명</div>
                    </div>
                    <div class="info-content3"><img src="../../../resources/img/id-card.png"></div>
                </div>
                <div class="info-box" onclick="window.location.href='/admin/safety'">
                    <div class="info-content2">
                        <div class="box-header">이용중인 카드 수</div>
                        <div>${safetyCardCount}개</div>
                    </div>
                    <div class="info-content3"><img src="../../../resources/img/credit-card_.png"></div>
                </div>
                <div class="info-box" onclick="window.location.href='/admin/safetyData'">
                    <div class="info-content2">
                        <div class="box-header">금일 차단 건수</div>
                        <div>${safetyDataCount}건</div>
                    </div>
                    <div class="info-content3"><img src="../../../resources/img/log_.png"></div>
                </div>
            </div>

            <div class="table-container">
                <h3>차단된 데이터관리</h3>
                <%--            <span>*학습시작 버튼을 누르고 학습이 완료된 후 해당 고객은 서비스를 이용할 수 있습니다.</span>--%>
                <table class="data-table">
                    <thead>
                    <tr>
                        <th>카드번호</th>
                        <th>거래일자</th>
                        <th>가맹점주소</th>
                        <th>업종</th>
                        <th>거래가격</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${notApprovalList}" var="notApprovalData">
                        <tr onclick="showAnomalyDetails(${notApprovalData.paymentLogId}, '${notApprovalData.cardId}');"
                            style="cursor: pointer;">
                            <td>${notApprovalData.cardId}</td>
                            <td>${notApprovalData.paymentDate}</td>
                            <td>${notApprovalData.address}</td>
                            <td>${notApprovalData.categorySmall}</td>
                            <td><fmt:formatNumber value="${notApprovalData.amount}" type="number" pattern="#,###"/>원
                            </td>
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
            const tbody = document.querySelector(".data-table tbody");
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
