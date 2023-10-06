<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

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
                        <div class="menu__icon"><img src="../../../resources/img/credit-card.png"></div>
                        안심카드서비스
                    </a>
                </li>
                <li class="menu__item">
                    <a href="/admin/fds" class="menu__link active">
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
            <h2 class="details____title">이상거래 서비스관리</h2>
            <div class="box-container">
                <div class="info-box" onclick="window.location.href='/admin/fds'">
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
                <div class="info-box" onclick="window.location.href='/admin/fdsData'">
                    <div class="info-content2">
                        <div class="box-header">금일 이상거래 건수</div>
                        <div>${fdsDataCount}건</div>
                    </div>
                    <div class="info-content3"><img src="../../../resources/img/log_.png"></div>
                </div>
            </div>

            <div class="table-container">
                <h3>서비스 사용자 관리</h3>
                <%--            <span>*학습시작 버튼을 누르고 학습이 완료된 후 해당 고객은 서비스를 이용할 수 있습니다.</span>--%>
                <table class="data-table">
                    <thead>
                    <tr>

                        <th>아이디</th>
                        <th>카드번호</th>
                        <th>서비스 시작일시</th>
                        <th>서비스상태</th>
                        <th>가중치저장경로</th>
                        <!-- 필요한 다른 컬럼들도 여기에 추가 -->
                    </tr>
                    </thead>

                    <tbody>
                    <c:forEach items="${FdsMemberList}" var="fdsmember">
                        <tr>
                            <td onclick="showMemberDetails('${fdsmember.member.email}','${fdsmember.cardId}','${fdsmember.member.name}','${fdsmember.member.address}','${fdsmember.member.phone}','${fdsmember.member.age}','${fdsmember.member.gender}')"
                                style="cursor: pointer;">${fdsmember.member.email}</td>
                            <td>${fdsmember.cardId}</td>
                            <td>${fn:substring(fdsmember.serRegDate, 0, 16)}</td>
                                <%--                        <td>${fn:split(fdsmember.serRegDate, ' ')[0]}</td>--%>
                            <!-- JSTL if문 -->
                            <td>
                                    <%--                                <c:if test="${fdsmember.serviceStatus eq '학습대기'}">--%>
                                    <%--                                    <button onclick="learningData('${fdsmember.cardId}')">학습대기</button>--%>
                                    <%--                                </c:if>--%>
                                    <%--                                <c:if test="${fdsmember.serviceStatus eq '학습완료'}">--%>
                                    <%--                                    &lt;%&ndash;                                ${fdsmember.serviceStatus}&ndash;%&gt;--%>
                                    <%--                                    진행중--%>
                                    <%--                                </c:if>--%>
                                <c:if test="${fdsmember.serviceStatus eq 'Y'}">활성</c:if>
                            </td>
                            <td>${fdsmember.weightSavePath}</td>
                            <!-- 필요한 다른 컬럼들의 데이터도 여기에 추가 -->
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
<%--멤버정보띄우는 모달--%>
<div id="memberModal" class="modal">
    <div class="modal-content">
        <span class="close" onclick="closeModal()">&times;</span>
        <div class="modal-header">회원 세부 정보</div>
        <table id="memberDetailsTable">
            <!-- 테이블 내용 -->
            <tbody>
            <tr>
                <td>아이디</td>
                <td><!-- 아이디 값 --></td>
            </tr>
            <tr>
                <td>이름</td>
                <td><!-- 이름 값 --></td>
            </tr>
            <tr>
                <td>주소</td>
                <td><!-- 주소 값 --></td>
            </tr>
            <tr>
                <td>전화번호</td>
                <td><!-- 전화번호 값 --></td>
            </tr>
            <tr>
                <td>나이</td>
                <td><!-- 나이 값 --></td>
            </tr>
            <tr>
                <td>성별</td>
                <td><!-- 성별 값 --></td>
            </tr>
            <tr>
                <td>이상소비알림횟수</td>
                <td></td>
            </tr>

            </tbody>
        </table>
    </div>
</div>
<script>

    function showMemberDetails(email, cardId, name, address, phone, age, gender) {
        var fdsCount;
        $.ajax({
            url: '/admin/fdsDataCount',
            type: 'POST',
            dataType: 'json',
            data: {
                cardId: cardId
            },
            success: function (data) {
                console.log("adata", data)
                fdsCount = data.fdsCount;

                document.getElementById('memberModal').style.display = "block";

                // 테이블 요소 찾기
                const tableBody = document.getElementById('memberDetailsTable').getElementsByTagName('tbody')[0];

                // 기존 행 삭제
                tableBody.innerHTML = "";

                // 데이터와 라벨을 쌍으로 관리
                const dataPairs = [
                    {label: "이메일", value: email},
                    {label: "이름", value: name},
                    {label: "주소", value: address},
                    {label: "전화번호", value: phone},
                    {label: "나이", value: age},
                    {label: "성별", value: gender},
                    {label: "이상거래 탐지횟수", value: fdsCount}
                ];

                // 각 데이터 쌍에 대해 테이블 행 추가
                dataPairs.forEach(pair => {
                    const newRow = tableBody.insertRow(tableBody.rows.length);
                    newRow.insertCell(0).innerHTML = pair.label;
                    newRow.insertCell(1).innerHTML = pair.value;
                });

            },
            error: function (error) {
                console.error('Error:', error);
            }
        });

    }

    // 모달 표시


    function closeModal() {
        document.getElementById('memberModal').style.display = "none";
    }

    // function learningData(cardId) {
    //     console.log("cardId" + cardId)
    //
    //     // AJAX로 데이터 전송
    //     $.ajax({
    //         type: "POST", // 또는 POST, PUT, DELETE 등 다른 HTTP 메서드
    //         url: "/admin/learning",
    //         data: {cardId: cardId},
    //         success: function (response) {
    //             alert(response);
    //             window.location.href = "/admin/fds";
    //         },
    //         error: function (error) {
    //             console.error("Error:", error);
    //         }
    //     });
    // }

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