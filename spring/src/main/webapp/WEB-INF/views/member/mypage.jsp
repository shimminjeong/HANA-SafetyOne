<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Document</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <link href="../../../resources/css/common.css" rel="stylesheet">
    <link href="../../../resources/css/admin/adminCommon.css" rel="stylesheet">
    <link href="../../../resources/css/member/mypage.css" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/chart.js@3.5.1/dist/chart.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <script src="../../../resources/js/mypage.js" type="text/javascript"></script>

</head>

<body>
<%@ include file="../include/header.jsp" %>
<div class="details">
    <div class="details__left">
        <ul class="menu">
            <li class="menu__item">
                <a href="/admin/safetyCard" class="menu__link">
                    <div class="menu__icon"><img src="../../../resources/img/bell%20(1).png"></div>
                    소비 대시보드
                </a>
            </li>
            <li class="menu__item">
                <a href="/admin/fds" class="menu__link">
                    <div class="menu__icon"><img src="../../../resources/img/bell%20(1).png"></div>
                    이용내역
                </a>
            </li>
        </ul>
    </div>
    <div class="detail__right">
        <div class="sub-container">
            <div class="who" style="font-size: 25px; margin-top:30px"><%= name %>님의 카드정보</div>
            <div class="slideshow-container">
                <c:forEach items="${cards}" var="card" varStatus="loop">
                    <div class="mySlides fade">
                        <img src="../../resources/img/cardImg${loop.index + 1}.png"
                             onclick="openChartCardDetailModal(this.getAttribute('data-card-id'))"
                             data-card-id="${card.cardId}">
                        <div class="cardIdtext">${card.cardId}</div>
                    </div>
                </c:forEach>
                <!-- Next and previous buttons -->
                <a class="prev" onclick="plusSlides(-1)">&#10094;</a>
                <a class="next" onclick="plusSlides(1)">&#10095;</a>
            </div>
        </div>
        <div class="month-info">
            <div class="month-info-1">
                <div class="month-box">
                    <div>지난달보다 소비액이 <span id="totalAmount"></span>하였습니다.</div>
                    <%--                    <div class="chart" style="width: 60%; margin: 0 auto"><canvas id="monthChart"></canvas></div>--%>
                </div>
            </div>
            <div class="info">이번달 눈에 띄는 소비 영역은 어디?</div>
            <div class="month-info-2">
                <div class="month-box">
                    <div id="increase"></div>
                    <%--                    <canvas id="increaseChart"></canvas>--%>
                </div>
                <div class="month-box">
                    <div id="decrease"></div>
                    <%--                    <canvas id="decreaseChart"></canvas>--%>
                </div>
            </div>
        </div>
        <div class="history">
            <h2>이용내역</h2>
            <table id="cardHistoryTable">
                <thead>
                <tr>
                    <th>카드번호</th>
                    <th>카테고리</th>
                    <th>가맹점명</th>
                    <th>거래일시</th>
                    <th>거래금액</th>
                </tr>
                </thead>
                <tbody>
                <!-- 여기에 서버에서 받아온 카드 히스토리 정보를 추가할 예정 -->
                </tbody>
            </table>
        </div>
    </div>
</div>
<div class="modal">
    <div id="myCardChartModal">
        <div class="chart-row1">
            <div class="month">
                <div class="chart-info">최근 6개월간 지출</div>
                <canvas id="monthChart"></canvas>
            </div>
            <div class="week">
                <div class="chart-info">최근 1주일간 지출</div>
                <canvas id="weekChart"></canvas>
            </div>
        </div>
        <div class="chart-row2">
            <div class="month"></div>
            <div class="month"></div>
        </div>
        <span class="close" onclick="closeChartCardDetailModal()">&times;</span>
    </div>
</div>
<script>
    let slideIndex = 1;
    showSlides(slideIndex);


    function openChartCardDetailModal(cardId) {
        document.querySelector(".modal").style.display = "block"; // 추가
        document.getElementById("myCardChartModal").style.display = "block";
        console.log("(cardid" + cardId);
        $.ajax({
            type: "POST",
            url: "/cardDetail",
            data: JSON.stringify({cardId: cardId}),
            contentType: 'application/json',
            success: function (data) {
                var monthChart = data.monthData;
                var weekChart = data.weekData;
                // var increase = data.increaseList;
                // var decrease = data.decreaseList;
                // var increaseChart = data.increaseData;
                // var decreaseChart = data.decreaseData;
                console.log("monthChart" + monthChart);


                $("#monthChart").replaceWith('<canvas id="monthChart"></canvas>');
                $("#weekChart").replaceWith('<canvas id="weekChart"></canvas>');


                // 전역 변수로 차트 선언
                var ctx = document.getElementById('monthChart').getContext('2d');

                if (monChart) {
                    monChart.destroy(); // 이미 차트가 있으면 파괴
                }

                var months = monthChart.map(item => item.month);
                var amountSums = monthChart.map(item => item.amountSum);

                var monChart = new Chart(ctx, {
                    type: 'bar',
                    data: {
                        labels: months,
                        datasets: [{
                            label: 'Amount Sum',
                            data: amountSums,
                            backgroundColor: 'rgba(75, 192, 192, 0.2)', // 배경색
                            borderColor: 'rgba(75, 192, 192, 1)', // 테두리 색
                            borderWidth: 1
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


                // 전역 변수로 차트 선언
                var ctx = document.getElementById('weekChart').getContext('2d');

                if (weeChart) {
                    weeChart.destroy(); // 이미 차트가 있으면 파괴
                }


                var weeks = weekChart.map(item => item.cardHisDate.split(' ')[0]);
                var weeksamountSums = weekChart.map(item => item.amountSum);

                var weeChart = new Chart(ctx, {
                    type: 'bar',
                    data: {
                        labels: weeks,
                        datasets: [{
                            label: 'Amount Sum',
                            data: weeksamountSums,
                            backgroundColor: 'rgba(75, 192, 192, 0.2)', // 배경색
                            borderColor: 'rgba(75, 192, 192, 1)', // 테두리 색
                            borderWidth: 1
                        }]
                    },
                    options: {
                        scales: {
                            y: {
                                beginAtZero: true
                            }
                        },
                        plugins: {
                            legend: {
                                onClick: function (event, array) {
                                    console.log("onclick")
                                    if (array.length > 0) {
                                        var clickedIndex = array[0]._index; // 클릭된 막대의 인덱스 얻기
                                        var clickedValue = weeks[clickedIndex]; // 클릭된 막대의 값 얻기

                                        // 서버에 데이터 전송하고 차트 업데이트
                                        $.ajax({
                                            type: "POST",
                                            url: "/updateChart",
                                            data: JSON.stringify({
                                                cardHisDate: clickedValue,
                                                cardId: cardId
                                            }),
                                            contentType: 'application/json',
                                            success: function (newData) {
                                                var dayChart = newData.dayData;
                                                console.log("dayData" + dayChart);

                                                if (weeChart) {
                                                    weeChart.destroy(); // 이미 차트가 있으면 파괴
                                                }

                                                var oneday = dayChart.map(item => item.time);
                                                var amountSums = dayChart.map(item => item.amountSum);


                                                var weeChart = new Chart(ctx, {
                                                    type: 'bar',
                                                    data: {
                                                        labels: oneday,
                                                        datasets: [{
                                                            label: 'Amount Sum',
                                                            data: amountSums,
                                                            backgroundColor: 'rgba(75, 192, 192, 0.2)', // 배경색
                                                            borderColor: 'rgba(75, 192, 192, 1)', // 테두리 색
                                                            borderWidth: 1
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

                                            }
                                        });
                                    }
                                }
                            }
                        }
                    }
                })
            }
        })
    }


    function closeChartCardDetailModal() {
        document.querySelector(".modal").style.display = "none"; // 추가
        document.getElementById("myCardChartModal").style.display = "none";
    }
</script>
</body>
</html>
