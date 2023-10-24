<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<html>
<head>
    <title>Document</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <link href="../../../resources/css/member/mypage.css" rel="stylesheet">
    <link href="../../../resources/css/member/mypageReport.css" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

</head>

<body>
<%@ include file="../include/header.jsp" %>
<div class="details">
    <div class="details__left">
        <div class="section-header">마이페이지</div>
        <hr style="margin: 0px; border: 1px solid #00857F;">
        <ul class="menu">
            <li class="menu__item">
                <a href="/mypageCardHistory" class="menu__link">
                    <div class="menu__icon"><img src="../../../resources/img/menu.png"></div>
                    이용내역
                </a>
            </li>
            <li class="menu__item">
                <a href="/mypageReport" class="menu__link active">
                    <div class="menu__icon"><img src="../../../resources/img/menu.png"></div>
                    소비레포트
                </a>
            </li>
        </ul>
    </div>
    <hr style="border:1px solid #00857F; margin:0px;">
    <div class="detail__right">
        <div class="sub-container">
            <div class="sub-container-hearder"><%=session.getAttribute("name")%>님의 소비레포트</div>
            <div style="text-align:right; margin-bottom: 10px"></div>
            <div style="text-align:right; ">2023/10/12 오후 12시 기준</div>
            <div class="sub-container-content">
                <div class="div-header"><img src="../../../resources/img/magnifier.png">
                    지난달과 비교했을 때 이번달의 소비 변화
                </div>
                <div class="div-box2">
                    <div class="div-box-sub">
                        <div class="div-box-header">
                            <div class="chart-header">최근 6개월 간 카드 결제 금액 비교</div>
                        </div>
                        <div class="div-box-content">
                            <canvas id="monthChart"></canvas>
                        </div>
                        <div>이번달 이용금액은 <span class="color-change"> <fmt:formatNumber value="${monthList[5].amountSum}" type="number"
                                                          pattern="#,###"/></span>원 입니다.</div>
                    </div>

                    <div class="div-box-sub">
                        <div class="div-box-header">
                            <div class="chart-header">지난달 대비 가장 변동이 큰 카테고리</div>

                            <div class="div-box-content">
                                <canvas id="diffChart"></canvas>
                            </div>
                            <div><span class="color-change">${differenceList[0].categorySmall}</span> 카테고리의 지난달 대비 지출 변동이 큽니다.</div>
                        </div>
                    </div>
                </div>
                <div class="div-header">
                    <img src="../../../resources/img/magnifier.png">최근 3개월 동안의 결제 카테고리 분석
                </div>
                <div class="div-box2">
                    <div class="div-box-sub">

                        <div class="sub-header">카테고리별 사용 금액 TOP3</div>

                        <c:forEach var="item" items="${topCategoryList}" begin="0" end="2" varStatus="status">
                            <div class="left">
                                <span>${status.index + 1}&nbsp;&nbsp;</span>
                                <span> ${item.categorySmall}&nbsp;&nbsp;</span>
                                <span>${(item.ratio * 100).intValue()}%</span>
                            </div>
                            <div class="right"><fmt:formatNumber value="${item.amountSum}" type="number"
                                                                                            pattern="#,###"/>원
                            </div>
                        </c:forEach>
                        <div class="fir"><span class="color-change">${topCategoryList[0].categorySmall}</span> 카데고리에서 가장 큰 지출이 발생했습니다.</div>

                    </div>
                    <div class="div-box-sub">
                        <div class="sub-header">카테고리별 결제 빈도 TOP3</div>
                        <c:forEach var="item" items="${topCountCategoryList}" begin="0" end="2" varStatus="status">
                            <div class="left">
                                <span>${status.index + 1}&nbsp;&nbsp;</span>
                                <span> ${item.categorySmall}&nbsp;&nbsp;</span>
                                <span>${(item.ratio * 100).intValue()}%</span>
                            </div>
                            <div class="right">${item.categoryCnt}회</div>
                        </c:forEach>
                        <div class="fir"><span class="color-change">${topCountCategoryList[0].categorySmall}</span> 카테고리에서 가장 빈번한 이용이 확인되었습니다.</div>
                    </div>

                </div>
                <div class="div-header">
                    <img src="../../../resources/img/magnifier.png">최근 3개월 동안의 결제 시간 및 지역별 지출 금액
                </div>
                    <div class="div-box2">
                        <div class="div-box-sub">
                            <div class="sub-header">시간대별 결제 금액</div>
                            <canvas id="timeChart"></canvas>
                        </div>
                        <div class="div-box-sub">
                            <div class="sub-header">지역별 결제 금액</div>
                            <canvas id="regionChart"></canvas>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <script>

        let labels = [];
        let data = [];
        <c:forEach var="item" items="${monthList}" varStatus="loop">
        <c:if test="${loop.index < 6}">
        labels.push("${item.month}월");
        data.push(${item.amountSum});
        </c:if>
        </c:forEach>

        var ctx = document.getElementById('monthChart').getContext('2d');
        var myBarChart = new Chart(ctx, {
            type: 'bar',
            data: {
                labels: labels,
                datasets: [{
                    label: '월별 거래금액',
                    data: data,
                    backgroundColor: [
                        '#4cbd4d'
                    ]
                }]
            },
            options: {
                plugins: {
                    legend: {
                        display: false,
                        position: 'top',
                        labels: {
                            font: {
                                size: 12
                            }
                        }
                    }
                },
                scales: {
                    y: {
                        beginAtZero: true,
                        ticks: {
                            callback: function (value, index, values) {
                                return new Intl.NumberFormat('en-US').format(value / 10000) + '만원';
                            }
                        }
                    }
                }
            }
        });

        let labels1 = ['지난달', '이번달'];
        let data1 = [${differenceList[0].amount}, ${differenceList[0].amountSum}];

        var ctx1 = document.getElementById('diffChart').getContext('2d');
        var myBarChart1 = new Chart(ctx1, {
            type: 'bar',
            data: {
                labels: labels1,
                datasets: [{
                    data: data1,
                    backgroundColor: [
                        '#1A535C'
                    ]
                }]
            },
            options: {
                plugins: {
                    legend: {
                        display: false,
                        position: 'top',
                        labels: {
                            font: {
                                size: 12
                            }
                        }
                    }
                },
                scales: {
                    y: {
                        beginAtZero: true,
                        ticks: {
                            callback: function (value, index, values) {
                                return new Intl.NumberFormat('en-US').format(value / 10000) + '만원';
                            }
                        }
                    }
                }
            }
        });


        let labels2 = [];
        let data2 = [];
        let timeListData = {};


        <c:forEach var="item" items="${timeList}">
        timeListData["${item.time}"] = ${item.amountSum};
        </c:forEach>


        for (let i = 0; i < 24; i++) {
            const label = (i < 10 ? '0' : '') + i;
            labels2.push(label + '시');


            if (timeListData[label]) {
                data2.push(timeListData[label]);
            } else {
                data2.push(0);
            }
        }

        console.log("data2", data2);

        var ctx2 = document.getElementById('timeChart').getContext('2d');
        var myBarChart2 = new Chart(ctx2, {
            type: 'bar',
            data: {
                labels: labels2,
                datasets: [{
                    data: data2,
                    backgroundColor: [
                        '#3a8cc5'
                    ]
                }]
            },
            options: {
                plugins: {
                    legend: {
                        display: false,
                        position: 'top',
                        labels: {
                            font: {
                                size: 12
                            }
                        }
                    }
                },
                responsive: true,
                scales: {
                    y: {
                        beginAtZero: true,
                        ticks: {
                            callback: function (value, index, values) {
                                return new Intl.NumberFormat('en-US').format(value / 10000) + '만원';
                            }
                        }
                    }
                }
            }

        });


        let labels3 = [];
        let data3 = [];
        <c:forEach var="item" items="${regionNameList}" varStatus="loop">

        labels3.push("${item.regionName}");
        data3.push(${item.amountSum});

        </c:forEach>

        var ctx3 = document.getElementById('regionChart').getContext('2d');
        var myBarChart3 = new Chart(ctx3, {
            type: 'bar',
            data: {
                labels: labels3,
                datasets: [{
                    data: data3,
                    backgroundColor: labels3.map(function(label, index) {
                        var colors = ['#4E937A', '#F3D250', '#F29F05', '#F24B0F'];
                        return colors[index % colors.length];
                    })
                }]
            },
            options: {
                plugins: {
                    legend: {
                        display: false,
                        position: 'top',
                        labels: {
                            font: {
                                size: 12
                            }
                        }
                    }
                },
                scales: {
                    y: {
                        beginAtZero: true,
                        ticks: {
                            callback: function (value, index, values) {
                                return new Intl.NumberFormat('en-US').format(value / 10000) + '만원'; 
                            }
                        }
                    }
                }
            }
        });


    </script>

</body>
</html>
