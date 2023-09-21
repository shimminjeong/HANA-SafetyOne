<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Document</title>
    <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
    <link rel="stylesheet" href="../../../resources/css/admin/adminCommon.css"/>
    <link rel="stylesheet" href="../../../resources/css/admin/adminMain.css"/>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>


</head>
<body>
<jsp:include page="adminHeader.jsp"/>
<hr>
<div class="details">
    <jsp:include page="adminSideBar.jsp"/>
    <div class="detail__right">
        <h2 class="details____title">관리자 대시보드</h2>
        <div class="box-container">
            <div class="info-box">
                <div class="hana-info-content-header">현재 하나카드 이용자수</div>
                <div class="hana-info-content-div1"><strong>${memberCnt}</strong> 명 입니다.</div>
                <div class="hana-info-content-div2">
                    <c:if test="${memberCntByYearRate < 0}">
                        올해 가입자 수는 작년보다 약 <strong><span
                            style="color: blue;">${-memberCntByYearRate}</span></strong>% 감소했습니다.
                    </c:if>

                    <c:if test="${memberCntByYearRate >= 0}">
                        올해 가입자 수는 작년보다 약 <strong><span
                            style="color: red;">${memberCntByYearRate}</span></strong>% 증가했습니다.
                    </c:if>
                </div>
            </div>
            <div class="info-box">
                <div class="hana-info-content-header">현재 거래중인 카드수</div>
                <div class="hana-info-content-div1"><strong>${cardCnt}</strong> 개 입니다.</div>
                <div class="hana-info-content-div2">
                    <c:if test="${cardCntByYearRate < 0}">
                        올해 가입카드수는 작년보다 약 <strong><span
                            style="color: blue;">${-cardCntByYearRate}</span></strong>% 감소했습니다.
                    </c:if>

                    <c:if test="${cardCntByYearRate >= 0}">
                        올해 가입카드수는 작년보다 약 <strong><span style="color: red;">${cardCntByYearRate}</span></strong>% 증가했습니다.
                    </c:if>
                </div>
            </div>
            <div class="info-box">
                <div class="hana-info-content-header">금일 총 거래액</div>
                <div class="hana-info-content-div1"><strong>${amountSum}</strong>원 입니다.</div>
                <div class="hana-info-content-div2">
                    <c:if test="${amountSumByDateRate < 0}">
                        금일 총 소비액은 어제에 비해 약<strong><span style="color: blue;">${-amountSumByDateRate}</span></strong>% 감소했습니다.
                    </c:if>

                    <c:if test="${amountSumByDateRate >= 0}">
                        금일 총 소비액은 어제에 비해 약<strong><span style="color: red;">${amountSumByDateRate}</span></strong>% 증가했습니다.
                    </c:if>
                </div>
            </div>
        </div>
        <div class="chart-container1">
            <div class="chart-container1-1">
                <div class="chart-head">5년가 가입회원수 추이</div>
                <canvas id="memberChart" width="400" height="200">></canvas>
            </div>
            <div class="chart-container1-2">
                <div class="chart-head">5년간 카드가입수 추이</div>
                <canvas id="cardChart" width="400" height="200"></canvas>
            </div>
        </div>
        <div class="chart-container2">
            <div class="chart-head">최근일주일간 카드사용액</div>
            <canvas id="amountChart" width="600" height="300"></canvas>
        </div>


        <div class="table-container">
            <h3>신규 신청</h3>
            <br>
            <!-- 테이블로 데이터베이스 데이터 표시 -->
            <table class="data-table">
                <thead>
                <tr>
                    <th>ID</th>
                    <th>대출명</th>
                    <th>대출종류</th>
                    <th>신청일자</th>
                    <th>진행상황</th>
                    <!-- 필요한 다른 컬럼들도 여기에 추가 -->
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${loans}" var="loan">
                    <tr onclick="window.location.href='/loanDetails?id=${loan.id}';" style="cursor: pointer;">
                        <td>${loan.id}</td>
                        <td>${loan.newLoanName}</td>

                        <td>신용대출 갈아타기</td>
                        <td>${loan.applicationDate}</td>
                        <td>${loan.newLoanStatus}</td>
                        <!-- 필요한 다른 컬럼들의 데이터도 여기에 추가 -->
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</div>
<script>
    let ctx1 = document.getElementById('memberChart').getContext('2d');
    let labels1 = [];
    let data1 = [];

    <c:forEach var="item" items="${memberCntByYear}">
    labels1.push("${item.year}");
    data1.push(${item.memberCnt});
    </c:forEach>

    let myChart1 = new Chart(ctx1, {
        type: 'line', // 차트 유형. 'bar', 'pie', 'doughnut' 등도 가능합니다.
        data: {
            labels: labels1,
            datasets: [{
                label: '가입자 수',
                data: data1,
                borderColor: 'rgba(75, 192, 192, 1)', // 선 색상
                borderWidth: 1,
                fill: false // 선 아래를 채우지 않음
            }]
        },
        options: {
            scales: {
                y: {
                    beginAtZero: true
                }
            }
        }
    });

    let ctx2 = document.getElementById('cardChart').getContext('2d');
    let labels2 = [];
    let data2 = [];

    <c:forEach var="item" items="${cardCntByYear}">
    labels2.push("${item.year}");
    data2.push(${item.cardCnt});
    </c:forEach>

    let myChart2 = new Chart(ctx2, {
        type: 'line', // 차트 유형. 'bar', 'pie', 'doughnut' 등도 가능합니다.
        data: {
            labels: labels2,
            datasets: [{
                label: '가입자 수',
                data: data2,
                borderColor: 'rgba(75, 192, 192, 1)', // 선 색상
                borderWidth: 1,
                fill: false // 선 아래를 채우지 않음
            }]
        },
        options: {
            scales: {
                y: {
                    beginAtZero: true
                }
            }
        }
    });

    let ctx3 = document.getElementById('amountChart').getContext('2d');
    let labels3 = [];
    let data3 = [];

    <c:forEach var="item" items="${amountSumByYear}">
    labels3.push("${item.cardHisDate}");
    data3.push(${item.amountSum});
    </c:forEach>

    let myChart3 = new Chart(ctx3, {
        type: 'line', // 차트 유형. 'bar', 'pie', 'doughnut' 등도 가능합니다.
        data: {
            labels: labels3,
            datasets: [{
                label: '일주일',
                data: data3,
                borderColor: 'rgba(75, 192, 192, 1)', // 선 색상
                borderWidth: 1,
                fill: false // 선 아래를 채우지 않음
            }]
        },
        options: {
            scales: {
                y: {
                    beginAtZero: true
                }
            }
        }
    });
</script>

</body>
</html>