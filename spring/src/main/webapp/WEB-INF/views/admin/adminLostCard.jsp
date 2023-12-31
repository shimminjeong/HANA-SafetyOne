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
                        <div class="menu__icon"><img src="../../../resources/img/secure-payment.png"></div>
                        안심서비스
                    </a>
                </li>
                <li class="menu__item">
                    <a href="/admin/fds" class="menu__link">
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
            <h2 class="details____title"><img class="img-size-service" src="../../../resources/img/lostcard.png">분실카드관리</h2>
            <div class="sub-container">
<%--                <div class="alarm-info">분실사유 별로 조회할 수 있습니다.</div>--%>
                <div class="lost-info">
                    <div class="lostReason-select-div">
                        <div class="lostReason-select-text">분실사유 : </div>
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
                                <th>분실일자<img src="../../../resources/img/sort1.png" alt="Icon for 아이디" class="th-icon" id="sortIcon"></th>
                                <th>분실장소</th>
                                <th>분실사유</th>
                                <th>재발급여부</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach items="${lostCardList}" var="lostCard">
                                <tr>
                                    <td>${fn:substring(lostCard.cardId, 0, 4)}-****-****-${fn:substring(lostCard.cardId, 15,20)}</td>
                                    <td>${fn:substring(lostCard.regLostDate, 0, 10)}</td>
                                    <td>${lostCard.lostPlace}</td>
                                    <td>${lostCard.lostReason}</td>
                                    <td>${lostCard.reissued}</td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                    </div>
                    <div class="pagination">
                        <button id="prev">이전</button>
                        <div id="pageNumbers"></div>
                        <button id="next">다음</button>
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

        $(".lostCard-table tbody tr").hide();

        $(".lostCard-table tbody tr").each(function () {
            var reasonInRow = $(this).find("td:nth-child(4)").text();
            if (reasonInRow === lostReasonValue) {
                $(this).show();

            }

        });

        updatePage();

    }

    // 페이지네이션
    document.getElementById("prev").addEventListener("click", function () {
        if (currentPage > 1) {
            currentPage--;
            updatePage();
        }
    });

    document.getElementById("next").addEventListener("click", function () {
        const tbody = document.querySelector(".lostCard-table table tbody");
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
        const tbody = document.querySelector(".lostCard-table table tbody");

        const visibleRows = Array.from(tbody.querySelectorAll("tr")).filter(row => row.style.display !== 'none');

        const totalPages = Math.ceil(visibleRows.length / itemsPerPage);

        for (let i = 0; i < visibleRows.length; i++) {
            if (i >= (currentPage - 1) * itemsPerPage && i < currentPage * itemsPerPage) {
                visibleRows[i].style.display = "";
            } else {
                visibleRows[i].style.display = "none";
            }
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
