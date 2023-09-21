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
    <link rel="stylesheet" href="../../../resources/css/admin/admin.css"/>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>


</head>
<body>
<jsp:include page="adminHeader.jsp"/>
<hr style="border:1px solid #00857F">
<div class="details">
    <jsp:include page="adminSideBar.jsp"/>
    <hr style="border:1px solid #00857F">
    <div class="detail__right">
        <div class="sub-container">
            <div class="hana-info">
                <div class="hana-info-header">하나카드</div>
                <div class="hana-info-content">
                    <div class="hana-info-content-box1">
                        <div class="hana-info-content-header">현재 하나카드 이용자수</div>
                        <div class="hana-info-content-div1"><strong>${memberCnt}</strong></div>
                        <div class="hana-info-content-div2">
                            <c:if test="${memberCntByYearRate < 0}">
                                올해 가입자 수는 작년보다 약 <strong><span
                                    style="color: blue;">${-memberCntByYearRate}</span></strong>% 감소
                            </c:if>

                            <c:if test="${memberCntByYearRate >= 0}">
                                올해 가입자 수는 작년보다 약 <strong><span
                                    style="color: red;">${memberCntByYearRate}</span></strong>% 증가
                            </c:if>
                        </div>
                    </div>
                    <div class="hana-info-content-box2">
                        <div class="hana-info-content-header">현재 거래중인 카드수</div>
                        <div class="hana-info-content-div1"><strong>${cardCnt}</strong> 개</div>
                        <div class="hana-info-content-div2">
                            <c:if test="${cardCntByYearRate < 0}">
                                올해 가입카드수는 작년보다 약 <strong><span
                                    style="color: blue;">${-cardCntByYearRate}</span></strong>% 감소
                            </c:if>

                            <c:if test="${cardCntByYearRate >= 0}">
                                올해 가입카드수는 작년보다 약 <strong><span
                                    style="color: red;">${cardCntByYearRate}</span></strong>% 증가
                            </c:if>
                        </div>
                    </div>
                    <div class="hana-info-content-box3">
                        <div class="hana-info-content-header">금일 총 거래액</div>
                        <div class="hana-info-content-div1"><strong>${amountSum}</strong>원</div>
                        <div class="hana-info-content-div2">
                            <c:if test="${amountSumByDateRate < 0}">
                                금일 총 소비액은 어제에 비해 약<strong><span style="color: blue;">${-amountSumByDateRate}</span></strong>% 감소
                            </c:if>

                            <c:if test="${amountSumByDateRate >= 0}">
                                금일 총 소비액은 어제에 비해 약<strong><span style="color: red;">${amountSumByDateRate}</span></strong>% 증가
                            </c:if>
                        </div>
                    </div>
                </div>
            </div>
            <div class="safetyone-info">
                <div class="safetyone-info-header">SafetyOne</div>
                <div class="safetyone-info-content">
                    <div class="safetyone-info-content-box1">
                        <div class="safetyone-info-content-header">안심카드</div>
                        <div class="safetyone-info-content-div1"></div>
                    </div>
                    <div class="safetyone-info-content-box2">
                        <div class="safetyone-info-content-header">이상소비알림</div>
                        <div class="safetyone-info-content-div1"></div>
                    </div>
                    <div class="safetyone-info-content-box3">
                        <div class="safetyone-info-content-header">군집분석</div>
                        <div class="safetyone-info-content-div1"></div>
                    </div>
                </div>
            </div>
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