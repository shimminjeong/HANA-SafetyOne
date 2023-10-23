<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

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
<div class="back-container">
    <div class="details">
        <div class="details__left">
            <ul class="menu">
                <li class="menu__item">
                    <a href="/admin/" class="menu__link active">
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
                    <a href="/admin/paymentLogData" class="menu__link">
                        <div class="menu__icon"><img src="../../../resources/img/log.png"></div>
                        결제로그
                    </a>
                </li>
            </ul>
        </div>
        <div class="admin__dashboard">
            <div class="sub-container">
                <div class="hana-info">
                    <h2 class="details____title" style="text-align: center">하나카드 이용 현황</h2>
                    <div style="font-size:16px; text-align: right">2023.10.13 오후 5시 기준</div>
                    <div class="hana-info-content">
                        <div class="hana-info-content-box1">
                            <div class="hana-info-content-header">총 회원 수</div>
                            <div class="hana-info-content-div1"><strong><fmt:formatNumber value="${memberCnt}"
                                                                                          pattern="#,###,###"/></strong> 명</div>
                            <%--                            <div class="hana-info-content-div2">--%>
                            <%--                                <c:if test="${memberCntByYearRate < 0}">--%>
                            <%--                                    올해 가입자 수는 작년보다 약 <strong><span--%>
                            <%--                                        style="color: blue;">${-memberCntByYearRate}</span></strong>% 감소--%>
                            <%--                                </c:if>--%>

                            <%--                                <c:if test="${memberCntByYearRate >= 0}">--%>
                            <%--                                    올해 가입자 수는 작년보다 약 <strong><span--%>
                            <%--                                        style="color: red;">${memberCntByYearRate}</span></strong>% 증가--%>
                            <%--                                </c:if>--%>
                            <%--                            </div>--%>
                            <hr>
                            <div class="chart-name">최근 3년 가입 회원 수 변화</div>
                            <div class="hana-info-content-div2">
                                <canvas id="memberCntByYearChart"></canvas>
                            </div>
                        </div>
                        <div class="hana-info-content-box2">
                            <div class="hana-info-content-header">총 카드 수</div>
                            <div class="hana-info-content-div1"><strong><fmt:formatNumber value="${cardCnt}"
                                                                                          pattern="#,###,###"/></strong> 개</div>
                            <%--                            <div class="hana-info-content-div2">--%>
                            <%--                                <c:if test="${cardCntByYearRate < 0}">--%>
                            <%--                                    올해 가입카드수는 작년보다 약 <strong><span--%>
                            <%--                                        style="color: blue;">${-cardCntByYearRate}</span></strong>% 감소--%>
                            <%--                                </c:if>--%>

                            <%--                                <c:if test="${cardCntByYearRate >= 0}">--%>
                            <%--                                    올해 가입카드수는 작년보다 약 <strong><span--%>
                            <%--                                        style="color: red;">${cardCntByYearRate}</span></strong>% 증가--%>
                            <%--                                </c:if>--%>
                            <%--                            </div>--%>
                            <hr>
                            <div class="chart-name">최근 3년 가입 카드 수 변화</div>
                            <div class="hana-info-content-div2">
                                <canvas id="cardCntByYearChart"></canvas>
                            </div>
                        </div>
                        <div class="hana-info-content-box3">
                            <div class="hana-info-content-header">금일 총 거래액</div>
                            <div class="hana-info-content-div1"><strong><fmt:formatNumber value="${amountSum}"
                                                                                          pattern="#,###,###"/></strong>
                                원
                            </div>
                            <%--                            <div class="hana-info-content-div2">--%>
                            <%--                                <c:if test="${amountSumByDateRate < 0}">--%>
                            <%--                                    금일 총 소비액은 어제에 비해 약<strong><span style="color: blue;">${-amountSumByDateRate}</span></strong>% 감소--%>
                            <%--                                </c:if>--%>

                            <%--                                <c:if test="${amountSumByDateRate >= 0}">--%>
                            <%--                                    금일 총 소비액은 어제에 비해 약<strong><span style="color: red;">${amountSumByDateRate}</span></strong>% 증가--%>
                            <%--                                </c:if>--%>
                            <%--                            </div>--%>
                            <hr>
                            <div class="chart-name">최근 일주일 총 거래액</div>
                            <div class="hana-info-content-div2">
                                <canvas id="amountSumByWeekChart"></canvas>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="safetyone-info">
                    <h2 class="details____title" style="margin-top:0px; text-align: center">SafetyOne 이용 현황</h2>
                    <div class="safetyone-info-content">
                        <div class="safetyone-info-content-box1" onclick="window.location.href='/admin/safety'">
                            <div class="safetyone-info-content-header" style="margin-bottom: 14px;">
                                <img src="../../../resources/img/secure-payment.png" style="width: 42px; height: 42px;">안심서비스
                            </div>
                            <div class="safetyone-info-content-div1">금일 차단 건수</div>
<%--                            <div class="safetyone-info-content-div2"><strong>${safetyDataCount}</strong>건</div>--%>
                            <div class="safetyone-info-content-div2"><strong>92</strong>건</div>
                        </div>
                        <div class="safetyone-info-content-box2" onclick="window.location.href='/admin/fds'">
                            <div class="safetyone-info-content-header"><img src="../../../resources/img/bellcolor.png">이상소비알림서비스</div>
                            <div class="safetyone-info-content-div1">금일 이상소비 건수</div>
                            <div class="safetyone-info-content-div2"><strong>${fdsDataCount}</strong>건</div>
                        </div>
                        <div class="safetyone-info-content-box3" onclick="window.location.href='/admin/cluster'">
                            <div class="safetyone-info-content-header"><img src="../../../resources/img/networking.png">군집 분석</div>
                            <div class="safetyone-info-content-div1">군집 수</div>
                            <div class="safetyone-info-content-div2"><strong>${clusterCount}</strong>개</div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script>


    let ctx1 = document.getElementById('memberCntByYearChart').getContext('2d');
    let labels1 = [];
    let data1 = [];

    <c:forEach var="item" items="${memberCntByYear}">
    labels1.push("${item.year}년");
    data1.push(${item.memberCnt});
    </c:forEach>

    let myChart1 = new Chart(ctx1, {
        type: 'line', // 차트 유형. 'bar', 'pie', 'doughnut' 등도 가능합니다.
        data: {
            labels: labels1,
            datasets: [{
                label: '가입 회원 수',
                data: data1,
                backgroundColor: 'rgb(14,157,151)', // 선 색상
                // borderWidth: 1,
                fill: false // 선 아래를 채우지 않음
            }]
        },
        options: {
            scales: {
                y: {
                    beginAtZero: true,
                    ticks: {
                        // 이 부분을 추가하여 각 틱에 '명'을 붙입니다.
                        callback: function (value, index, values) {
                            return new Intl.NumberFormat('en-US').format(value) + '명';
                        }
                    }
                }
            },
            plugins: {
                legend: {
                    display: false
                }
            }
        }

    });

    let ctx2 = document.getElementById('cardCntByYearChart').getContext('2d');
    let labels2 = [];
    let data2 = [];

    <c:forEach var="item" items="${cardCntByYear}">
    labels2.push("${item.year}년");
    data2.push(${item.cardCnt});
    </c:forEach>

    let myChart2 = new Chart(ctx2, {
        type: 'line', // 차트 유형. 'bar', 'pie', 'doughnut' 등도 가능합니다.
        data: {
            labels: labels2,
            datasets: [{
                label: '가입 카드 수',
                data: data2,
                backgroundColor: 'rgb(14,157,151)', // 선 색상
                fill: false // 선 아래를 채우지 않음
            }]
        },
        options: {
            scales: {
                y: {
                    beginAtZero: true,
                    ticks: {
                        // 이 부분을 추가하여 각 틱에 '명'을 붙입니다.
                        callback: function (value, index, values) {
                            return new Intl.NumberFormat('en-US').format(value) + '개';
                        }
                    }
                }
            },
            plugins: {
                legend: {
                    display: false
                }
            }
        }
    });

    function formatDate(inputDate) {
        // 문자열로부터 Date 객체 생성
        let parts = inputDate.split(' ')[0];
        console.log("parts", parts)
        let month = parts.split('-')[1];
        let day = parts.split('-')[2];
        console.log(month);
        console.log(day);

        return month + '/' + day;
    }

    let ctx3 = document.getElementById('amountSumByWeekChart').getContext('2d');
    let labels3 = [];
    let data3 = [];

    <c:forEach var="item" items="${amountSumByWeek}">
    labels3.push(formatDate('${item.cardHisDate}'));
    data3.push(${item.amountSum});
    </c:forEach>

    let myChart3 = new Chart(ctx3, {
        type: 'line', // 차트 유형. 'bar', 'pie', 'doughnut' 등도 가능합니다.
        data: {
            labels: labels3,
            datasets: [{
                label: '거래액',
                data: data3,
                backgroundColor: 'rgb(14,157,151)', // 선 색상
                fill: false // 선 아래를 채우지 않음
            }]
        },
        options: {
            scales: {
                y: {
                    beginAtZero: true,
                    min: 1000000000, // 최소값 설정
                    max: 1550000000, // 최대값 설정
                    ticks: {
                        callback: function (value, index, values) {
                            // 값을 10,000으로 나누고, ','로 구분하여 표시
                            return new Intl.NumberFormat('en-US').format(value / 10000000) + '천만원';
                        }
                    }

                }
            },
            plugins: {
                legend: {
                    display: false
                }
            }
        }

    });
</script>

</body>
</html>