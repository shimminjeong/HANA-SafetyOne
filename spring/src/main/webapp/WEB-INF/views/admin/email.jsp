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
                                <th>이름</th>
                                <th>이메일</th>
                                <th>성별</th>
                                <th>나이</th>
                                <th>전화번호</th>
                                <th>주소</th>
                            </tr>
                            </thead>
                            <tbody id="memberTbody">
                            <c:forEach items="${memberList}" var="member" varStatus="status">
                                <tr>
                                    <td style="text-align: center;">${member.clusterNum}</td>
                                    <td data-name="${member.name}">${fn:substring(member.name, 0, 1)}*${fn:substring(member.name, 2, 3)}</td>
                                    <td>${member.email}</td>
                                    <td style="text-align: center;">${member.gender}

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

        var input = document.getElementById('memberSearchInput');
        var filter = input.value.toUpperCase();


        var tbody = document.getElementById('memberTbody');
        var tr = tbody.getElementsByTagName('tr');


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

    document.getElementById('openModalBtn').addEventListener('click', openModal);

    window.addEventListener('click', function (event) {
        if (event.target === document.getElementById('myModal')) {
            closeModal();
        }
    });

    function sendEmailData() {

        var emailTitle = $('#emailTitle').val();
        var emailContent = $('#emailContent').val();


        var data = {
            to: "pooh5045@naver.com",
            title: emailTitle,
            message: emailContent
        };

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
                    var tr = $("<tr></tr>");
                    tr.append("<td>" + history.clusterNum + "</td>");
                    tr.append("<td>" + history.name + "</td>");
                    tr.append("<td>" + history.email + "</td>");
                    tr.append("<td>" + history.gender + "</td>");
                    tr.append("<td>" + history.age + "</td>");
                    tr.append("<td>" + history.phone + "</td>");
                    var addressPart = history.address.split(' ')[0];
                    tr.append("<td>" + addressPart + "</td>");

                    tbody.append(tr);
                });
                updatePage();

            },
            error: function (error) {
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
                console.error("Error sending data:", error);
            }
        });
    }


    $(document).ready(function () {

        $("#clusterSelect").change(function () {
            var selectedCluster = $(this).val();
            sendClusterToServer(selectedCluster);
        });

        $("#mail-clusterSelect").change(function () {
            var selectedCluster = $(this).val();
            sendModalClusterToServer(selectedCluster);
        });
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

    let currentPage = 1;
    const itemsPerPage = 10;
    const pagesToShow = 10;


    function updatePage() {
        const tbody = document.querySelector(".member-info-table tbody");
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
