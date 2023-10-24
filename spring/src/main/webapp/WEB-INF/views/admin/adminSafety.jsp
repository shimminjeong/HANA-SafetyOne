<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
<style>


</style>
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
                    <a href="/admin/safety" class="menu__link active">
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
                    <a href="/admin/paymentLogData" class="menu__link">
                        <div class="menu__icon"><img src="../../../resources/img/log.png"></div>
                        결제로그
                    </a>
                </li>
            </ul>
        </div>
        <div class="detail__right">
            <h2 class="details____title"><img class="img-size" src="../../../resources/img/secure-payment.png">안심서비스 관리
            </h2>
            <div class="box-container">
                <div style="background-color: #eee;"  class="info-box2" onclick="window.location.href='/admin/safety'">
                    <div class="info-content2">
                        <div class="box-header">이용자 수</div>
                        <div><fmt:formatNumber value="${safetyUserCount}" groupingUsed="true" />명</div>
                    </div>
                    <div class="info-content3"><img src="../../../resources/img/id-card.png"></div>
                </div>
                <div  style="background-color: #eee;"  class="info-box" onclick="window.location.href='/admin/safety'">
                    <div class="info-content2">
                        <div class="box-header">이용중인 카드 수</div>
                        <div><fmt:formatNumber value="${safetyCardCount}" groupingUsed="true" />개</div>
                    </div>
                    <div class="info-content3"><img src="../../../resources/img/credit-card_.png"></div>
                </div>
                <div class="info-box1"
                     onclick="window.location.href='/admin/safetyData'">
                    <div class="info-content2">
                        <div class="box-header">금일 차단 건수</div>
                        <div><fmt:formatNumber value="${safetyDataCount}" groupingUsed="true" />건</div>
                    </div>
                    <div class="info-content3"><img src="../../../resources/img/log_.png"></div>
                </div>
            </div>
            <div style="text-align: right; margin-bottom:20px;">금일 차단 건수를 선택하면 안심서비스 차단 내역을 조회할 수 있습니다.</div>
            <div class="table-container">
                <h3>서비스 사용자 및 카드 관리</h3>
                <div class="alarm-info">※ 회원의 이름을 선택하면 상세한 회원 정보를 조회할 수 있습니다.</div>
                <div class="alarm-info">※ 카드번호를 선택하면 해당 카드의 안심서비스 이용내역을 확인할 수 있습니다.</div>
                <div class="user-search">
                    <div class="search-header">회원 검색</div>
                    <input type="text" id="memberSearchInput" placeholder="회원 이름을 입력하세요">
                    <button onclick="filterMembers()">검색</button>
                </div>
                <table class="data-table">
                    <thead>
                    <tr>
                        <th>이메일</th>
                        <th>이름</th>
                        <th>카드번호</th>
                        <th>
                            서비스 시작일시
                            <img src="../../../resources/img/sort1.png" alt="Icon for 아이디" class="th-icon"
                                 id="sortIcon">
                        </th>
                        <th>서비스 상태</th>

                    </tr>
                    </thead>

                    <tbody>
                    <c:forEach items="${safetyMemberList}" var="safetymember">
                        <tr>
                            <td>${safetymember.member.email}</td>
                            <td data-name="${safetymember.member.name}"  onclick="showMemberDetails('${safetymember.member.email}','${safetymember.cardId}','${safetymember.member.name}','${safetymember.member.address}','${safetymember.member.phone}','${safetymember.member.age}','${safetymember.member.gender}')"
                                style="cursor: pointer;">${fn:substring(safetymember.member.name, 0, 1)}*${fn:substring(safetymember.member.name, 2, 3)}</td>
                            <td onclick="showSafetyInfo('${safetymember.cardId}')"
                                style="cursor: pointer;">${fn:substring(safetymember.cardId, 0, 4)}-****-****-${fn:substring(safetymember.cardId, 15,20)}</td>
                            <td>${fn:substring(safetymember.safetyStartDate, 0, 16)}</td>
                                <%--                        <td>${fn:split(fdsmember.serRegDate, ' ')[0]}</td>--%>
                            <!-- JSTL if문 -->
                            <td>
<%--                                <c:if test="${safetymember.status eq 'Y'}">활성</c:if>--%>
                                활성
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
<%--멤버정보띄우는 모달--%>
<div id="memberModal" class="modal">
    <div class="modal-content">
        <span class="close" onclick="membercloseModal()">&times;</span>
        <div class="modal-header">회원 세부 정보</div>
        <table id="memberDetailsTable">

            <tbody>
            <tr>
                <td>이메일</td>
                <td></td>
            </tr>
            <tr>
                <td>이름</td>
                <td></td>
            </tr>
            <tr>
                <td>주소</td>
                <td></td>
            </tr>
            <tr>
                <td>전화번호</td>
                <td></td>
            </tr>
            <tr>
                <td>나이</td>
                <td></td>
            </tr>
            <tr>
                <td>성별</td>
                <td></td>
            </tr>
            <tr>
                <td>미승인 거래 횟수</td>
                <td></td>
            </tr>

            </tbody>
        </table>

    </div>
</div>


<div id="safetyModal" class="modal">
    <div class="safety-modal-content">
        <span class="close" onclick="safetycloseModal()">&times;</span>
        <div class="modal-header">안심서비스 이용정보</div>
        <div class="safety-info"></div>
    </div>
</div>
<script>


    function filterMembers() {
        var searchTerm = document.getElementById("memberSearchInput").value;
        var table = document.querySelector(".data-table");
        var rows = table.getElementsByTagName("tr");

        for (var i = 0; i < rows.length; i++) {
            var row = rows[i];
            var secondColumn = row.querySelector("td[data-name]");
            if (secondColumn) {
                var cellValue = secondColumn.getAttribute("data-name");
                if (cellValue.includes(searchTerm)) {
                    row.style.display = "";
                } else {
                    row.style.display = "none";
                }
            }
        }
    }


    $(document).ready(function () {
        var ascending = false;

        $("#sortIcon").click(function () {
            var $table = $(".data-table");
            var $rows = $table.find("tbody tr").toArray();

            if (ascending) {
                $rows.sort(function (a, b) {
                    var keyA = $(a).find("td:eq(2)").text();
                    var keyB = $(b).find("td:eq(2)").text();
                    return keyA.localeCompare(keyB);
                });
                ascending = false;
            } else {
                $rows.sort(function (a, b) {
                    var keyA = $(a).find("td:eq(2)").text();
                    var keyB = $(b).find("td:eq(2)").text();
                    return keyB.localeCompare(keyA);
                });
                ascending = true;
            }

            $table.find("tbody").empty().append($rows);
            updatePage();


            if (ascending) {
                $("#sortIcon").attr("src", "../../../resources/img/sort1.png");
            } else {
                $("#sortIcon").attr("src", "../../../resources/img/sort2.png");
            }
        });
    });

    function showSafetyInfo(cardId) {
        var cardInfoList = $(".safety-info");
        $.ajax({
            url: "/safetyCard/selectSafetyInfo",
            type: 'POST',
            data: JSON.stringify({cardId: cardId}),
            contentType: 'application/json',
            success: function (data) {
                console.log("data", data)
                document.getElementById('safetyModal').style.display = "block";
                let regionNameAllList = data.regionList.map(item => item);
                let regionNames = data.safetyCardList.map(item => item.regionName);


                let allowedRegions = [];
                let blockStr = "";
                let timeStr = "";
                let regionStr = "";
                let categoryStr = "";
                let stopStartDate = "";
                let stopEndDate = "";


                const regionsSet = new Set();
                const timesSet = new Set();
                const categoriesSet = new Set();

                const stopregionsSet = new Set();
                const stoptimesSet = new Set();
                const stopcategoriesSet = new Set();

                data.safetyCardList.forEach(item => {
                    console.log("item", item)

                    if (item.regionName !== null && item.time === null && item.categorySmall === null) {
                        allowedRegions.push(item.regionName);
                        console.log("1")
                    }

                    if (item.regionName !== null && item.time !== null && item.categorySmall !== null) {
                        regionsSet.add(item.regionName);
                        timesSet.add(item.time);
                        categoriesSet.add(item.categorySmall);
                        console.log("2")
                    }
                    if (item.regionName !== null && item.time === null && item.categorySmall !== null) {
                        regionsSet.add(item.regionName);
                        categoriesSet.add(item.categorySmall);
                    }

                    if (item.regionName !== null && item.time !== null && item.categorySmall === null) {
                        regionsSet.add(item.regionName);
                        timesSet.add(item.time);
                    }

                    if (item.regionName === null && item.time === null && item.categorySmall !== null) {
                        categoriesSet.add(item.categorySmall);
                    }

                    if (item.regionName === null && item.time !== null && item.categorySmall === null) {
                        timesSet.add(item.time);
                    }

                    if (item.regionName === null && item.time !== null && item.categorySmall !== null) {
                        timesSet.add(item.time);
                        categoriesSet.add(item.categorySmall);
                    }

                    if (item.stopStartDate !== null) {
                        stopregionsSet.add(item.regionName);
                        stoptimesSet.add(item.time);
                        stopcategoriesSet.add(item.categorySmall);
                        stopStartDate = item.stopStartDate;
                        stopEndDate = item.stopEndDate;
                    }

                });


                data.regionList = data.regionList.filter(region => !allowedRegions.includes(region));
                let allowedRegionsString = data.regionList.join(", ");


                const regionsStr = Array.from(regionsSet).join(", ");
                const timesStr = Array.from(timesSet).join(", ");
                const categoriesStr = Array.from(categoriesSet).join(", ");

                const stopregionsStr = Array.from(stopregionsSet).join(", ");

                var resultRegionStr = ""
                var resultTimeStr = ""
                var resultCategoryStr = ""
                if (regionsSet.size !== 0) {
                    resultRegionStr = regionsStr + "에서 ";
                }
                if (timesSet.size !== 0) {
                    resultTimeStr = timesStr + "까지 ";
                }
                if (categoriesSet.size !== 0) {
                    resultCategoryStr = categoriesStr + " 업종을 ";
                }
                let noStr = "차단"

                const resultStr = resultRegionStr + resultTimeStr + resultCategoryStr + noStr;


                if (data.safetyCardList[0].regionName !== null) {

                    cardInfoList.empty();
                    var cardInfoListContent = "<hr><h3>안심서비스 설정항목<h3><div class='info-header' style='margin-bottom: 10px; font-size: 16px; font-weight: 500;'>서비스시작일시 : " + data.safetyCardList[0].safetyStartDate.split(":").slice(0, 2).join(":") + "</div>";
                    cardInfoListContent += "<div class='info-header' style='margin-bottom: 10px; font-size: 16px; font-weight: 500;'>허용 지역 : " + allowedRegionsString + "</div>";
                    cardInfoListContent += "<div class='info-header' style='margin-bottom: 10px; font-size: 16px; font-weight: 500;'>차단 조합 : " + resultStr + "</div>";

                    if (stopStartDate !== "") {
                        cardInfoListContent += "<h3 style='margin-top:30px;'>일시정지 이용정보<h3>" +
                            "<div style='margin-bottom: 10px; font-size: 16px; font-weight: 500;'>선택 지역 : " + stopregionsStr + "</div><div style='margin-bottom: 10px; font-size: 16px; font-weight: 500;'>일시정지 기간 : " + stopStartDate.split(" ")[0] + " ~ " + stopEndDate.split(" ")[0] + "</div>";
                    }
                    cardInfoList.append(cardInfoListContent);
                }

                if (data.safetyCardList[0].regionName === null) {

                    cardInfoList.empty();
                    var cardInfoListContent = "<hr><div class='info-list'><div class='info-header'>서비스시작일시 </div><div class='info-content'>" + data.safetyCardList[0].safetyStartDate.split(":").slice(0, 2).join(":") + "</div></div>";
                    cardInfoListContent += "<div class='info-list'><div class='info-header'>차단 조합</div><div class='info-content'>" + resultStr + "</div></div>"

                    if (stopStartDate !== "") {
                        cardInfoListContent += "<h3 style='margin-top:30px;>일시정지 이용정보<h3>" +
                            "<div style='margin-bottom: 10px'>선택 지역 : " + stopregionsStr + "</div><div>일시정지 기간 : " + stopStartDate.split[0] + " ~ " + stopEndDate.split[0] + "</div>";
                    }
                    cardInfoList.append(cardInfoListContent);


                }


            }
        });
    }


    function showMemberDetails(email, cardId, name, address, phone, age, gender) {
        var safetyCount;
        $.ajax({
            url: '/admin/safetyInfo',
            type: 'POST',
            dataType: 'json',
            data: {
                cardId: cardId
            },
            success: function (data) {
                console.log("adata", data)
                safetyCount = data.safetyCount;

                document.getElementById('memberModal').style.display = "block";

                const tableBody = document.getElementById('memberDetailsTable').getElementsByTagName('tbody')[0];

                tableBody.innerHTML = "";

                const dataPairs = [
                    {label: "이메일", value: email},
                    {label: "이름", value: name},
                    {label: "주소", value: address},
                    {label: "전화번호", value: phone},
                    {label: "나이", value: age},
                    {label: "성별", value: gender},
                    {label: "차단된 거래 횟수", value: safetyCount},
                ];

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


    function membercloseModal() {
        document.getElementById('memberModal').style.display = "none";
    }

    function safetycloseModal() {
        document.getElementById('safetyModal').style.display = "none";
    }

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
        const tbody = document.querySelector(".data-table tbody");
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