<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Title</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <link href="../../../resources/css/common.css" rel="stylesheet">
    <link href="../../../resources/css/regionspot.css" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/chart.js@3.5.1/dist/chart.min.js"></script>
</head>
<style>

    .setting-container {
        display: flex;
        justify-content: space-between;
        margin: 50px auto;
        max-width: 842px;
        height: 600px;
        text-decoration: none;

    }

    .setting-nav {
        background-color: #f9f9f9;
        width: 120px;
        margin-right: 20px;
        padding-top: 25px;

        height: 150px;
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

    .setting-nav a {
        margin-bottom: 10px;
        font-size: 18px;
        text-decoration: none;
        color: black;
    }


    .setting-form {
        margin: 0px 0px;
        display: flex;
        flex-direction: column;
        justify-content: center;
        color: black; /* 글자색 변경 */
        padding: 30px 50px; /* 패딩 */
        border: none; /* 테두리 없음 */
        border-radius: 10px; /* 둥근 모서리 */
        text-decoration: none;
        font-size: 12px; /* 폰트 크기 변경 */
        cursor: pointer;
        background-color: #ffffff; /* 배경색 추가 */
        transition: background-color 0.3s, transform 0.3s; /* 부드러운 전환 효과 추가 */
        box-shadow: 0 4px 6px rgba(0, 0, 0, 0.4); /* 그림자 추가 */
        width: 700px; /* 가로 크기 */
        max-height: 500px; /* 세로 크기 */
    }


    .info {
        display: flex;
        flex-direction: column;
    }

    .info h1 {
        margin: auto 0px;

    }

    .info h2 {
        margin-bottom: 0px;
    }

    #myChartmodal {
        position: absolute;
        top: 0;
        left: 0;

        width: 500px;
        height: 500px;

        display: none;

    }



    .spot-container {
        position: relative;
        display: inline-block;
    }

    .spot-container button {
        position: absolute;
        cursor: pointer;
        background-color: transparent;
        border: none;
        padding: 0;
        font-size: 12px;
        color: black;
    }


</style>
<script>
    const locationButtons = document.querySelectorAll('.location-button');
    const selectedLocation = document.querySelector('.selected-location');

    locationButtons.forEach(button => {
        button.addEventListener('click', () => {
            selectedLocation.textContent = button.textContent;
        });
    });
</script>
<%@ include file="../include/header.jsp" %>
<body>
<div class="container">
    <%--                <a href="#" onclick="openChartModal()" style="color:black">나의소비보기(지역)</a>--%>
    <div class="setting-container">
        <div class="setting-nav">
            <a href="/service/selffdsRegion">지역설정</a>
            <a href="/service/selffdsCategory">업종설정</a>
            <a href="/service/selffdsTime">시간설정</a>
            <a href="/service/selffdsTotal">통합설정</a>
        </div>
        <div class="setting-form">
            <div class="info">
                <h1>안심결제서비스</h1>
                <h2>결제를 차단할 지역을 선택해주세요</h2>
            </div>

            <div class="info-content">
                <span class="spot-container">
                    <img src="../../../resources/img/map.png" style="height: 380px">
                    <button class="seoul-btn">서울</button>
                    <button class="gyeonggi-btn">경기도</button>
                    <button class="incheon-btn">인천</button>
                    <button class="gangwon-btn">강원도</button>
                    <button class="chungnam-btn">충청남도</button>
                    <button class="daejeon-btn">대전</button>
                    <button class="chungbuk-btn">충청북도</button>
                    <button class="busan-btn">부산</button>
                    <button class="ulsan-btn">울산</button>
                    <button class="daegu-btn">대구</button>
                    <button class="gyeongbuk-btn">경상북도</button>
                    <button class="gyeonggnam-btn">경상남도</button>
                    <button class="jeollanam-btn">전라남도</button>
                    <button class="gwangju-btn">광주</button>
                    <button class="jeollabuk-btn">전라북도</button>
                    <button class="jejudo-btn">제주도</button>

                </span>
            </div>
            <div class="selected-location"></div>
            <button class="okBtn">다음</button>

        </div>
    </div>
    <div id="myChartmodal">
        <canvas id="myChart" width="500px" height="500px"></canvas>
        <script>

            $(document).ready(function () {
                let region_nameList = [];
                let region_cntList = [];
                let amount_sumList = [];
                $.ajax({
                    url: '/chart/regionServiceChart', // 컨트롤러의 엔드포인트 경로
                    type: 'GET',
                    success: function (data) {
                        // 데이터 가공
                        for (let i = 0; i < data.length; i++) {
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
