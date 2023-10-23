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
    <link rel="stylesheet" href="../../../resources/css/admin/email.css"/>

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
                    <a href="/admin/email" class="menu__link active">
                        <div class="menu__icon"><img src="../../../resources/img/gmail.png"></div>
                        이메일전송
                    </a>
                </li>
                <li class="menu__item">
                    <a href="/admin/lostCard" class="menu__link">
                        <div class="menu__icon"><img src="../../../resources/img/lostcard.png"></div>
                        분실카드
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
            <h2 class="details____title">안심서비스 추천 이메일 전송</h2>
            <div class="sub-container">
                <div class="email-content">
                <span class="search-cluster">
                    <img src="../../../resources/img/magnifier.png"><a href="/admin/cluster" class="btn-link">군집별 특성
                    확인하기</a>
                </span>
                    <div class="select-div">
                        <div class="select-header">군집 선택</div>
                        <select id="clusterSelect">
                            <option value="all">전체회원</option>
                            <c:forEach items="${clusterList}" var="clusterNum" varStatus="loop">
                                <option value="${clusterNum}">${clusterNum}번 군집</option>
                            </c:forEach>
                        </select>

                    </div>
                    <div class="sender-div">
                        <button id="openModalBtn" onclick="openModal();">이메일 전송</button>
                    </div>
                    <div class="user-search">
                        <div class="search-header">회원 검색</div>
                        <input type="text" id="memberSearchInput" placeholder="회원 이름을 입력하세요">
                        <button onclick="filterMembers()">검색</button>
                    </div>
                    <div class="cluster-member-info">
                        <table class="member-info-table">
                            <thead>
                            <tr>
                                <th>군집번호</th>
                                <th>이름</th>          <!-- 예시 컬럼, 실제 구조에 맞게 조절 필요 -->
                                <th>이메일</th>        <!-- 예시 컬럼, 실제 구조에 맞게 조절 필요 -->
                                <th>성별</th>       <!-- 예시 컬럼, 실제 구조에 맞게 조절 필요 -->
                                <th>나이</th>       <!-- 예시 컬럼, 실제 구조에 맞게 조절 필요 -->
                                <th>전화번호</th>       <!-- 예시 컬럼, 실제 구조에 맞게 조절 필요 -->
                                <th>주소</th>       <!-- 예시 컬럼, 실제 구조에 맞게 조절 필요 -->
                                <!-- 다른 필요한 컬럼들 -->
                            </tr>
                            </thead>
                            <tbody id="memberTbody">
                            <c:forEach items="${memberList}" var="member" varStatus="status">
                                <tr>
                                    <td style="text-align: center;">${member.clusterNum}</td>
                                    <td data-name="${member.name}">${fn:substring(member.name, 0, 1)}*${fn:substring(member.name, 2, 3)}</td>
                                    <td>${member.email}</td>
                                    <td style="text-align: center;">${member.gender}
<%--                                        <c:if test="${member.gender == 'F'}">여성</c:if>--%>
<%--                                        <c:if test="${member.gender == 'M'}">남성</c:if>--%>

                                    </td>
                                    <td style="text-align: right;">${member.age}세</td>
                                    <td>${member.phone}</td>
                                    <c:set var="addressParts" value="${fn:split(member.address, ' ')}"/>
                                    <td>${addressParts[0]}</td>
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
    </div>
</div>


<div id="myModal" class="modal">
    <div class="modal-content">
        <span class="close-btn" onclick="closeModal()">&times;</span>
        <div class="modal-header">군집별 메일전송</div>
        <div class="cluster-info">
            <div class="emailTo">받는사람</div>
            <select id="mail-clusterSelect">
                <c:forEach items="${clusterList}" var="clusterNum" varStatus="loop">
                    <option value="${clusterNum}">${clusterNum}번 군집</option>
                </c:forEach>
            </select>
            <div class="cluster-count"></div>
        </div>

        <div class="input-group">
            <label for="emailTitle">제목</label>
            <input type="text" id="emailTitle" placeholder="제목을 입력하세요">
        </div>


        <div class="input-group">
            <label for="emailContent">내용</label>
            <textarea id="emailContent" placeholder="내용을 입력하세요"></textarea>
        </div>


        <button class="sendEmailBtn" onclick="sendEmailData()">이메일 전송</button>

    </div>
</div>

<script>

    function filterMembers() {
        // 입력된 이름 가져오기
        var input = document.getElementById('memberSearchInput');
        var filter = input.value.toUpperCase(); // 대소문자 구분 없이 검색하기 위해

        // 테이블의 모든 행 가져오기
        var tbody = document.getElementById('memberTbody');
        var tr = tbody.getElementsByTagName('tr');

        // 각 행을 순회하며 이름과 입력된 값 비교
        for (var i = 0; i < tr.length; i++) {
            var td = tr[i].getElementsByTagName('td')[1];
            if (td) {
                var originalName = td.getAttribute('data-name').toUpperCase();
                if (originalName.indexOf(filter) > -1) {
                    tr[i].style.display = "";
                } else {
                    tr[i].style.display = "none";
                }
            }
        }
    }

    function openModal() {
        document.getElementById('myModal').style.display = 'block';
    }

    function closeModal() {
        document.getElementById('myModal').style.display = 'none';
    }

    // // 버튼에 이벤트 리스너를 추가
    document.getElementById('openModalBtn').addEventListener('click', openModal);
    // document.getElementById('closeModalBtn').addEventListener('click', closeModal);

    // 모달 외부 클릭 시 닫기
    window.addEventListener('click', function (event) {
        if (event.target === document.getElementById('myModal')) {
            closeModal();
        }
    });

    function sendEmailData() {
        // 입력 상자에서 데이터 가져오기
        // var recipientEmail = $('#recipientEmail').val();
        var emailTitle = $('#emailTitle').val();
        var emailContent = $('#emailContent').val();

        // 데이터를 서버에 전송하기 위한 객체 생성
        var data = {
            to: "pooh5045@naver.com",
            title: emailTitle,
            message: emailContent
        };

        // jQuery AJAX를 사용하여 데이터를 서버에 POST 요청으로 전송
        $.ajax({
            url: '/sendEmail',
            type: 'POST',
            contentType: 'application/json',
            data: JSON.stringify(data),
            success: function (response) {
                console.log('Success:', response);
                alert('이메일이 성공적으로 전송되었습니다.');
                window.location.replace("/admin/email");
            },
            error: function (error) {
                console.error('Error:', error);
                alert('이메일 전송에 실패했습니다.');
            }
        });
    }

    function sendClusterToServer(clusterNum) {
        console.log("clusterNum" + clusterNum)
        $.ajax({
            type: "POST",
            url: "/admin/clusterMemberList",
            contentType: "application/json",
            data: JSON.stringify({clusterNum: clusterNum}),
            success: function (response) {

                var tbody = $('tbody');
                tbody.empty();

                $.each(response.memberInfoList, function (index, history) {
                    // 새로운 tr 및 td 요소들을 생성한다.
                    var tr = $("<tr></tr>");
                    tr.append("<td>" + history.clusterNum + "</td>");
                    tr.append("<td>" + history.name + "</td>");
                    tr.append("<td>" + history.email + "</td>");
                    tr.append("<td>" + history.gender + "</td>");
                    tr.append("<td>" + history.age + "</td>");
                    tr.append("<td>" + history.phone + "</td>");
                    var addressPart = history.address.split(' ')[0];
                    tr.append("<td>" + addressPart + "</td>");


                    // tr 요소를 tbody에 추가한다.
                    tbody.append(tr);
                });
                updatePage();

            },
            error: function (error) {
                // 실패 시 수행할 작업 (예: 오류 메시지 표시)
                console.error("Error sending data:", error);
            }
        });
    }


    function sendModalClusterToServer(clusterNum) {
        console.log("clusterNum" + clusterNum)
        $.ajax({
            type: "POST",
            url: "/admin/clusterMailContent",
            contentType: "application/json",
            data: JSON.stringify({clusterNum: clusterNum}),
            success: function (response) {
                $("#emailTitle").val(response.mailTitle);
                $("#emailContent").val(response.mailContent);
                $(".cluster-count").text(response.memberCount + "명");


            },
            error: function (error) {
                // 실패 시 수행할 작업 (예: 오류 메시지 표시)
                console.error("Error sending data:", error);
            }
        });
    }


    /////////////pagenation

    $(document).ready(function () {
        // select 요소 값 변경 감지
        $("#clusterSelect").change(function () {
            var selectedCluster = $(this).val();
            sendClusterToServer(selectedCluster);
        });  // <-- 여기에 닫는 괄호와 세미콜론을 추가

        $("#mail-clusterSelect").change(function () {
            var selectedCluster = $(this).val();
            sendModalClusterToServer(selectedCluster);
        });  // <-- 여기에 닫는 괄호와 세미콜론을 추가
    });


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
        const tbody = document.querySelector(".member-info-table tbody");
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
