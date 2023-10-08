<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Document</title>
    <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
    <link rel="stylesheet" href="../../../resources/css/admin/adminCommon.css"/>
    <link rel="stylesheet" href="../../../resources/css/admin/cluster.css"/>
    <script src="../../../resources/js/cluster.js" type="text/javascript"></script>
    <script src="https://cdn.jsdelivr.net/npm/chart.js/dist/Chart.js"></script>

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
                        안심서비스
                    </a>
                </li>
                <li class="menu__item">
                    <a href="/admin/fds" class="menu__link">
                        <div class="menu__icon"><img src="../../../resources/img/bellcolor.png"></div>
                        이상소비서비스
                    </a>
                </li>
                <li class="menu__item">
                    <a href="/admin/cluster" class="menu__link  active">
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
            <h2 class="details____title"><img class="img-size-service" src="../../../resources/img/networking.png">하나카드 회원 군집분석</h2>
            <div class="sub-container">
                <div class="cluster-header">
                    <h3>회원 소비특성별 군집</h3>
                    <div style="margin-bottom: 10px">3개월마다 회원의 거래내역으로 군집분석이 시행됩니다.</div>
                    <div>현 군집은 2023-08-08 ~ 2023-10-08 까지의 거래내역으로 분석하였습니다. </div>
                    <div>
                        <table  class="table-div">
                            <thead>
                            <tr>
                                <th>군집</th>
                                <th>소속회원수</th>
                                <th>주요거래업종</th>
                                <th>비주요거래업종</th>
                                <th>군집비율(%)</th>
                                <th>군집특성확인</th>
                                <th>이메일발송</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach var="cluster" items="${clusterInfo}">
                                <tr>
                                    <td>${cluster.clusterNum}번 군집</td>
                                    <td>${cluster.clusterPeopleCount}명</td>
                                    <td>${cluster.categoryMaxName}</td>
                                    <td>${cluster.categoryMinName}</td>
                                    <td style="text-align: right">${(cluster.clusterPeopleRatio * 100).intValue()}%</td>


                                    <td>
                                        <button class="open-modal" data-clusterNum="${cluster.clusterNum}"
                                                data-clusterPeopleCount="${cluster.clusterPeopleCount}">군집특성확인
                                        </button>
                                    </td>
                                    <td>
                                        <button>이메일전송
                                        </button>
                                    </td>
                                        <%--                                <td>--%>
                                        <%--                                    <button>메일 보내기</button>--%>
                                        <%--                                </td>--%>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
                <div class="cluster-chart-div">
                    <div class="pie-div">
                        <h3>군집별 인구 분포 시각화</h3>
                        <canvas id="pieChart"></canvas>
                    </div>
                    <div class="bar1-div">
                        <h3>평균 한달 군집별 거래횟수 및 거래금액</h3>
                        <canvas id="combinedBarChart"></canvas>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<div class="modal" id="myModal">
    <div class="modal-content">
        <span class="close">&times;</span>
        <div class="report">군집 대시보드</div>
        <div class="row1-div">
            <div class="report-div">
                <div class="chartname-header"><strong>군집 report</strong></div>
                <hr style="height: 1px; background-color: black;">
                <div class="report-content">
                    <div class="people-info"></div>
                </div>
                <div class="category-top3">
                    <div class="big">
                        <div class="category-header">주요 거래업종</div>
                        <div class="bigcategory"></div>
                    </div>
                    <div class="small">
                        <div class="category-header">비주요 거래업종</div>
                        <div class="smallcategory"></div>
                    </div>
                </div>
                <div class="mean-div">
                </div>
            </div>
            <div class="many-chart-div">
                <div class="chartname-header">
                    <strong>주요소비처 한달 평균 거래횟수 및 거래금액</strong>
                </div>
                <div class="canvas-div">
                    <canvas id="manyChart"></canvas>
                </div>
            </div>
        </div>
        <div class="row2-div">
            <div class="gender-chart-div">
                <div class="chartname-header">
                    <strong>군집 내 인구분포</strong>
                </div>
                <canvas id="genderAgeChart"></canvas>
            </div>
            <div class="small-chart-div">
                <div class="chartname-header">
                    <strong>비주요소비처 한달 평균 거래횟수 및 거래금액</strong>
                </div>
                <div class="canvas-div">
                    <canvas id="smallChart"></canvas>
                </div>
            </div>
        </div>
    </div>
</div>
<script>

    // JSP에서 데이터를 가져오기 위한 JavaScript 코드
    var clusterData = [];
    <c:forEach var="cluster" items="${clusterInfo}">
    clusterData.push({
        label: "${cluster.clusterNum}번 군집",
        value: ${cluster.clusterPeopleCount}
    });
    </c:forEach>

    var labels = clusterData.map(function (item) {
        return item.label;
    });
    var data = clusterData.map(function (item) {
        return item.value;
    });

    var ctx = document.getElementById('pieChart').getContext('2d');
    new Chart(ctx, {
        type: 'pie',
        data: {
            labels: labels,
            datasets: [{
                data: data,
                backgroundColor: [
                    'rgba(255, 99, 132, 0.5)',    // 붉은색
                    'rgba(54, 162, 235, 0.5)',    // 파란색
                    'rgba(255, 206, 86, 0.5)',    // 노란색
                    'rgba(75, 192, 192, 0.5)',    // 민트색
                    'rgba(153, 102, 255, 0.5)',   // 보라색
                    'rgba(255, 159, 64, 0.5)'     // 오렌지색
                ]
            }]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false,  // 추가
            legend: {
                position: 'right'
            }
        }
    });

    var clusterData2 = [];
    <c:forEach var="cluster" items="${clusterInfo2}">
    clusterData2.push({
        label: "${cluster.clusterNum}번 군집",
        value: ${cluster.count}
    });
    </c:forEach>

    var clusterData3 = [];
    <c:forEach var="cluster" items="${clusterInfo2}">
    clusterData3.push({
        label: "${cluster.clusterNum}번 군집",
        value: ${cluster.totalAmount}
    });
    </c:forEach>

    var labels = clusterData2.map(function (item) {
        return item.label;
    });
    var dataCount = clusterData2.map(function (item) {
        return item.value;
    });
    var dataSum = clusterData3.map(function (item) {
        return item.value;
    });

    var ctx = document.getElementById('combinedBarChart').getContext('2d');
    new Chart(ctx, {
        type: 'bar',
        data: {
            labels: labels,
            datasets: [
                {
                    label: '거래건수',
                    data: dataCount,
                    backgroundColor: 'rgba(255, 99, 132, 0.5)', // 붉은색
                    yAxisID: 'y-axis-count'
                },
                {
                    label: '거래금액',
                    data: dataSum,
                    backgroundColor: 'rgba(54, 162, 235, 0.5)', // 파란색
                    yAxisID: 'y-axis-sum'
                }
            ]
        },
        options: {
            responsive: true,
            legend: {
                position: 'top'
            },
            scales: {
                xAxes: [{
                    stacked: false
                }],
                yAxes: [
                    {
                        id: 'y-axis-count',
                        position: 'left',
                        ticks: {
                            beginAtZero: true,
                            callback: function (value, index, values) {
                                return value + '건';
                            }
                        }
                    },
                    {
                        id: 'y-axis-sum',
                        position: 'right',
                        ticks: {
                            beginAtZero: true,
                            callback: function (value, index, values) {
                                return new Intl.NumberFormat('en-US').format(value / 10000) + '만원';
                            }
                        },
                        gridLines: {
                            display: false
                        }

                    }
                ]
            }
        }
    });


    $(document).ready(function () {
        $(".open-modal").click(function () {
            var clusterNum = $(this).attr("data-clusterNum");
            console.log("clusterNum:", clusterNum);


            $.ajax({
                type: "POST",
                url: "/admin/clusterDetail",
                contentType: 'application/json', // 콘텐츠 타입을 JSON으로 지정
                data: JSON.stringify({clusterNum: clusterNum}),
                success: function (chartData) {
                    // chartData를 사용하여 차트를 그립니다.

                    drawChart(chartData); // drawChart는 차트를 그리는 함수, 이를 구현하실 필요가 있습니다.

                    // 모달을 보여줍니다.
                    $("#myModal").show();
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    console.error("Error:", textStatus, errorThrown);
                }
            });
        });

        // 모달 외부를 클릭했을 때 모달을 닫습니다.
        $(document).ready(function () {
            // .close 클래스 버튼을 클릭했을 때의 이벤트 리스너
            $(".close").click(function () {
                $("#myModal").hide();
            });
        });

    });


</script>
</body>
</html>