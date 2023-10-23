<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>


<html>
<head>
    <%--    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>--%>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <title>Document</title>

    <link rel="stylesheet" href="../../../resources/css/admin/adminCommon.css"/>
    <link rel="stylesheet" href="../../../resources/css/admin/adminFds.css"/>
    <!-- Datepicker CSS -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/css/bootstrap-datepicker3.min.css"
          rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css">
    <link rel="stylesheet" href="http://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">

</head>
<body>
<jsp:include page="drawPaymentChart.jsp"/>
<!-- Datepicker JS -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/js/bootstrap-datepicker.min.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
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
                    <a href="/admin/lostCard" class="menu__link">
                        <div class="menu__icon"><img src="../../../resources/img/lostcard.png"></div>
                        분실카드관리
                    </a>
                </li>
                <li class="menu__item">
                    <a href="/admin/paymentLogData" class="menu__link active">
                        <div class="menu__icon"><img src="../../../resources/img/log.png"></div>
                        결제로그
                    </a>
                </li>
            </ul>
        </div>
        <div class="detail__right">
            <h2 class="details____title"><img class="img-size-service" src="../../../resources/img/log.png">결제 로그 관리
            </h2>
            <div class="sub-container">
                <div class="alarm-info">해당 서비스의 모든 결제로그를 조회할 수 있습니다.</div>
                <div class="alarm-info">※ 카드번호와 일자를 입력하시면 해당 일에 그 카드로 결제된 내역을 조회할 수 있습니다.</div>
                <div class="pick">
                    <span class="date-div">
                        <span>일자 선택 :&nbsp; </span>
                        <input type="text" id="paymentdatepicker" name="startStopDate">
                    </span>
                    <span class="user-search-payment">
                        <div class="search-header-payment">카드 검색 : </div>
                        <input type="text" id="cardSearchInput" placeholder="카드번호를 입력하세요">
                        <button onclick="filterCard()">검색</button>
                    </span>
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
                        <th>거래일시<img src="../../../resources/img/sort1.png" alt="Icon for 아이디" class="th-icon"
                                     id="sortedIcon"></th>
                        <th>가맹점명</th>
                        <th>업종</th>
                        <th>거래금액<img src="../../../resources/img/sort1.png" alt="Icon for 아이디" class="th-icon"
                                     id="sortIcon"></th>
                        <th>승인여부</th>
                        <th>이상탐지여부</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${paymentLogList}" var="paymentdata">
                        <tr onclick="showAnomalyDetails(${paymentdata.paymentLogId}, '${paymentdata.cardId}');"
                            style="cursor: pointer;">
                            <td data-cardId="${paymentdata.cardId}">${fn:substring(paymentdata.cardId, 0, 4)}-****-****-${fn:substring(paymentdata.cardId, 15,20)}</td>
                            <td>${fn:substring(paymentdata.paymentDate, 0, 16)}</td>
                            <c:set var="addressParts" value="${fn:split(paymentdata.address, ' ')}"/>
                            <c:choose>
                                <c:when test="${fn:length(addressParts) >= 2}">
                                    <td>${addressParts[0]} ${addressParts[1]}</td>
                                </c:when>
                                <c:otherwise>
                                    <td>${paymentdata.store}</td>
                                </c:otherwise>
                            </c:choose>
                            <td>${paymentdata.categorySmall}</td>
                            <td style="text-align: right"><fmt:formatNumber value="${paymentdata.amount}" type="number"
                                                                            pattern="#,###"/>원
                            </td>
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
</div>

<script>

    $(function() {
        // 현재 날짜를 설정합니다. (2023년 10월 13일로 예시)
        var currentDate = new Date(2023, 9, 13); // 월은 0부터 시작하므로 9는 10월을 의미합니다.

        // DatePicker 초기화
        $("#paymentdatepicker").datepicker();

        // 현재 날짜를 설정한 날짜로 업데이트
        // $("#paymentdatepicker").datepicker("setDate", currentDate);
    });

    function filterCard() {
        var cardSearchInput = document.getElementById("cardSearchInput").value; // 사용자가 입력한 카드번호 가져오기
        var table = document.querySelector(".logdata-table"); // 테이블 요소 가져오기
        var rows = table.getElementsByTagName("tr"); // 테이블의 모든 행 가져오기

        // 각 행을 순회하며 data-cardId 속성을 사용하여 검색어와 일치하는 행을 찾음
        for (var i = 0; i < rows.length; i++) {
            var row = rows[i];
            var cardNumberCell = row.querySelector("td[data-cardId]"); // data-cardId 속성을 가진 열 찾기

            if (cardNumberCell) {
                var cellValue = cardNumberCell.getAttribute("data-cardId");
                if (cellValue === cardSearchInput) { // 입력된 카드번호와 일치하는 경우
                    row.style.display = ""; // 보여주기
                } else {
                    row.style.display = "none"; // 숨기기
                }
            }
        }
    }


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

    $("#paymentdatepicker").datepicker({
        dateFormat: 'yy-mm-dd' //달력 날짜 형태
        , showOtherMonths: true //빈 공간에 현재월의 앞뒤월의 날짜를 표시
        , showMonthAfterYear: true // 월- 년 순서가아닌 년도 - 월 순서
        , changeYear: true //option값 년 선택 가능
        , changeMonth: true //option값  월 선택 가능
        , yearSuffix: "년" //달력의 년도 부분 뒤 텍스트
        , monthNamesShort: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'] //달력의 월 부분 텍스트
        , monthNames: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'] //달력의 월 부분 Tooltip
        , dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'] //달력의 요일 텍스트
        , dayNames: ['일요일', '월요일', '화요일', '수요일', '목요일', '금요일', '토요일'] //달력의 요일 Tooltip
        , minDate: "-5Y" //최소 선택일자(-1D:하루전, -1M:한달전, -1Y:일년전)
        , maxDate: "+5y" //최대 선택일자(+1D:하루후, -1M:한달후, -1Y:일년후)
    });


</script>

</body>


</body>
</html>
