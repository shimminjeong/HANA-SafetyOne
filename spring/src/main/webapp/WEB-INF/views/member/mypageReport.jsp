<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<html>
<head>
    <title>Document</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <%--    <link href="../../../resources/css/admin/adminCommon.css" rel="stylesheet">--%>
    <link href="../../../resources/css/member/mypage.css" rel="stylesheet">
    <link href="../../../resources/css/member/mypageReport.css" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

</head>

<body>
<%@ include file="../include/header.jsp" %>
<div class="details">
    <%@ include file="../include/mypageSideBar.jsp" %>
    <hr style="border:1px solid #00857F; margin:0px;">
    <div class="detail__right">
        <div class="sub-container">
            <div class="sub-container-hearder">소비레포트</div>
            <div style="text-align:right; margin-bottom: 10px">2023년 10월 9일 기준</div>
            <div class="sub-container-content">
                <div class="div-header">
                    지난달과 다르게 변화한 이번달 소비
                </div>
                <hr>
                <div class="div-box2">
                    <div class="div-box-sub">
                        <div class="div-box-header">
                            <div class="chart-header">최근 6개월 카드 결제 금액 비교</div>
                        </div>
                        <div class="div-box-content">
                            <canvas id="monthChart"></canvas>
                        </div>
                        <div>이번달은 이용금액은 <fmt:formatNumber value="${monthList[5].amountSum}" type="number"
                                                          pattern="#,###"/> 원 입니다.</div>
                    </div>

                    <div class="div-box-sub">
                        <div class="div-box-header">
                            <div class="chart-header">지날달 대비 변동금액이 큰 카테고리</div>

                            <div class="div-box-content">
                                <canvas id="diffChart"></canvas>
                            </div>
                            <div>지난달 대비 '${differenceList[0].categorySmall}' 에서 이용금액 변동이 가장 큰것으로 확인됩니다.</div>
                        </div>
                    </div>
                </div>
                <div class="div-header">
                    최근 3개월 이용 카테고리 확인
                </div>
                <hr>
                <div class="div-box2">
                    <div class="div-box-sub">

                        <div class="sub-header">카테고리별 사용비중 금액 TOP3</div>

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
                        <%--                        </div>--%>
                        <div class="fir">'${topCategoryList[0].categorySmall}' 에서 가장 많은 금액을 사용하셨습니다.</div>

                    </div>
                    <div class="div-box-sub">
                        <div class="sub-header">카테고리별 사용 빈도 TOP3</div>
                        <c:forEach var="item" items="${topCountCategoryList}" begin="0" end="2" varStatus="status">
                            <div class="left">
                                <span>${status.index + 1}&nbsp;&nbsp;</span>
                                <span> ${item.categorySmall}&nbsp;&nbsp;</span>
                                <span>${(item.ratio * 100).intValue()}%</span>
                            </div>
                            <div class="right">${item.categoryCnt}회</div>
                        </c:forEach>
                        <div class="fir">'${topCountCategoryList[0].categorySmall}' 에서 가장 많이 이용하셨어요.</div>
                    </div>

                </div>
                <div class="div-header">
                    최근 3개월 이용 시간 및 지역별 이용금액
                </div>
                <hr>
                    <div class="div-box2">
                        <div class="div-box-sub">
                            <div class="sub-header">시간대별 이용금액</div>
                            <canvas id="timeChart"></canvas>
                        </div>
                        <div class="div-box-sub">
                            <div class="sub-header">지역별 이용금액</div>
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
                        '#1A535C'
                    ]
                }]
            },
            options: {
                plugins: {
                    legend: {
                        display: false, // 범례를 표시합니다.
                        position: 'top', // 범례 위치 설정 (top, bottom, left, right 중 선택)
                        labels: {
                            font: {
                                size: 12 // 범례 레이블의 글꼴 크기 설정
                            }
                        }
                    }
                },
                scales: {
                    y: {
                        beginAtZero: true,
                        ticks: {
                            callback: function (value, index, values) {
                                return new Intl.NumberFormat('en-US').format(value / 10000) + '만원';// 숫자를 지역화된 문자열로 변환
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
                        display: false, // 범례를 표시합니다.
                        position: 'top', // 범례 위치 설정 (top, bottom, left, right 중 선택)
                        labels: {
                            font: {
                                size: 12 // 범례 레이블의 글꼴 크기 설정
                            }
                        }
                    }
                },
                scales: {
                    y: {
                        beginAtZero: true,
                        ticks: {
                            callback: function (value, index, values) {
                                return new Intl.NumberFormat('en-US').format(value / 10000) + '만원';// 숫자를 지역화된 문자열로 변환
                            }
                        }
                    }
                }
            }
        });


        let labels2 = [];
        let data2 = [];
        let timeListData = {};

        // 서버에서 받아온 데이터를 JavaScript 객체에 저장
        <c:forEach var="item" items="${timeList}">
        timeListData["${item.time}"] = ${item.amountSum};
        </c:forEach>

        // 라벨을 00 ~ 23까지 설정
        for (let i = 0; i < 24; i++) {
            const label = (i < 10 ? '0' : '') + i;
            labels2.push(label + '시'); // 00시, 01시, ... 23시

            // JavaScript 객체에서 데이터를 조회
            if (timeListData[label]) {
                data2.push(timeListData[label]);
            } else {
                data2.push(0);  // 해당 라벨의 값이 데이터 배열에 없으면 0을 설정
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
                        '#1A535C'
                    ]
                }]
            },
            options: {
                plugins: {
                    legend: {
                        display: false, // 범례를 표시합니다.
                        position: 'top', // 범례 위치 설정 (top, bottom, left, right 중 선택)
                        labels: {
                            font: {
                                size: 12 // 범례 레이블의 글꼴 크기 설정
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
                                return new Intl.NumberFormat('en-US').format(value / 10000) + '만원'; // 숫자를 지역화된 문자열로 변환
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
                    backgroundColor: [
                        '#1A535C'
                    ]
                }]
            },
            options: {
                plugins: {
                    legend: {
                        display: false, // 범례를 표시합니다.
                        position: 'top', // 범례 위치 설정 (top, bottom, left, right 중 선택)
                        labels: {
                            font: {
                                size: 12 // 범례 레이블의 글꼴 크기 설정
                            }
                        }
                    }
                },
                scales: {
                    y: {
                        beginAtZero: true,
                        ticks: {
                            callback: function (value, index, values) {
                                return new Intl.NumberFormat('en-US').format(value / 10000) + '만원'; // 숫자를 지역화된 문자열로 변환
                            }
                        }
                    }
                }
            }
        });


    </script>

</body>
</html>
