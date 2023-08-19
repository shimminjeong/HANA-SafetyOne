<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Title</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <link href="../../../resources/css/common.css" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/chart.js@3.5.1/dist/chart.min.js"></script>
</head>
<style>
    #formsize img {
        width: 40%;
        height: auto;
    }

    /* Style for vertical navigation */
    .service-nav {
        background-color: #f9f9f9;
        width: 100px;
        padding-top: 20px;
        padding-left: 0px;
        padding-right: 0px;
        padding-bottom: 0px;
        margin-right: 20px;
        margin-left: 20px;
        margin-bottom: 20px;
        margin-top: 50px;
        height: 120px;
        border: none;
        display: flex;
        flex-direction: column;
        border-radius: 10px;
        text-decoration: none;
        cursor: pointer;
        transition: background-color 0.3s, transform 0.3s;
        box-shadow: 0 4px 6px rgba(0, 0, 0, 0.4);
        align-items: center;
    }

    .service-nav a {
        margin-bottom: 10px;
        font-size: 16px;
    }

    .sub-container {
        display: flex;
        flex-direction: row;
        justify-content: center;
        width: 1000px;
        height: 500px;
        margin: 50px auto;
        text-decoration: none;

    }

    #formsize {
        margin-top: 50px;
        display: flex;
        flex-direction: column;
        justify-content: center;
        color: black; /* 글자색 변경 */
        border: none; /* 테두리 없음 */
        border-radius: 10px; /* 둥근 모서리 */
        text-decoration: none;
        font-size: 12px; /* 폰트 크기 변경 */
        cursor: pointer;
        background-color: #ffffff; /* 배경색 추가 */
        transition: background-color 0.3s, transform 0.3s; /* 부드러운 전환 효과 추가 */
        box-shadow: 0 4px 6px rgba(0, 0, 0, 0.4); /* 그림자 추가 */
        width: 600px; /* 가로 크기 */
        height: 400px; /* 세로 크기 */
    }

    .sub-container {
        display: flex;
        margin: 0;
        width: 800px; /* 가로 크기 */
        height: 500px; /* 세로 크기 */
    }

    .service-nav a {
        text-decoration: none;
        color: black;
    }

    .info {
        display: flex;
        flex-direction: row;
    }

    #myChartmodal {
        position: absolute;
        top: 0;
        left: 0;

        width: 500px;
        height: 500px;

        display: none;

    }


</style>
<%@ include file="../include/header.jsp" %>
<body>
<div class="container">
    <div class="sub-container">
        <div class="service-nav">
            <a href="/service/selffdsRegion">지역설정</a>
            <a href="/service/selffdsCategory">업종설정</a>
            <a href="/service/selffdsTime">시간설정</a>
        </div>
        <div id="formsize">
            <div class="info">장소선택</div>
            <div class="info-content">
                <img src="../../../resources/img/map.png">
                <h3>이거:<%=session.getAttribute("card_id")%></h3>
                <a href="#" onclick="openChartModal()" style="color:black">나의소비보기(지역)</a>
            </div>
            <button class="okBtn">등록</button>
        </div>
    </div>
    <div id="myChartmodal">
        <canvas id="myChart" width="500px" height="500px"></canvas>
        <script>

            $(document).ready(function () {
                let region_nameList=[];
                let region_cntList=[];
                let amount_sumList=[];
                $.ajax({
                    url: '/chart/regionServiceChart', // 컨트롤러의 엔드포인트 경로
                    type: 'GET',
                    success: function (data) {
                        // 데이터 가공
                        for (let i=0; i<data.length;i++){
                            region_nameList.push(data[i].region_name)
                            region_cntList.push(data[i].region_cnt)
                            amount_sumList.push(data[i].amount_sum)
                        }

                        // 바 차트 그리기
                        var ctx = document.getElementById('myChart').getContext('2d');
                        new Chart(ctx, {
                            type: 'bar',
                            data: {
                                labels: region_nameList,
                                datasets: [{
                                    label: 'Amount Count',
                                    data: region_cntList,
                                    backgroundColor: 'rgba(75, 192, 192, 0.2)',
                                    borderColor: 'rgb(75, 192, 192)',
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


                    },
                    error: function () {
                        console.error("Error while fetching data");
                    }
                });
            })
        </script>
        <span class="close" onclick="closeChartModal()">모달닫기</span>
    </div>
</div>
<%--차트그리기--%>


<script>


    // 모달 열기 함수
    function openChartModal() {
        document.getElementById("myChartmodal").style.display = "block";
    }

    // 모달 닫기 함수
    function closeChartModal() {
        document.getElementById("myChartmodal").style.display = "none";
    }
</script>
</body>
</html>
