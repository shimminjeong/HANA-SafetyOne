<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Title</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <link href="../../../resources/css/common.css" rel="stylesheet">
    <link href="../../../resources/css/service.css" rel="stylesheet">
    <link href="../../../resources/css/regionspot.css" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/chart.js@3.5.1/dist/chart.min.js"></script>
</head>
<style>

    #myChartmodal {
        position: absolute;
        top: 0;
        left: 0;
        width: 500px;
        height: 500px;
        display: none;
    }

    .region-content {
        display: flex;
        flex-direction: row;
        width: 100%;
        align-items: stretch;
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

    .mychoice {
        display: flex;
        padding: 10px;
        justify-content: center;
        align-items: center;
        flex-direction: column;
        width: 100%;
    }

    button.selected-btn {
        background-color: #00857F;
        color: white;
        border: none;
        padding: 12px;
        margin: 2px;
        cursor: pointer;
        border-radius: 20px;
        font-size: 16px;
    }


    .myreport {
        display: flex;
        justify-content: center;
        align-items: center;
        flex-direction: column;
        margin: 10px;
    }

    .selected-btn{
        flex: 1;
        margin: 10px;
        padding : 20px;

    }

    .recommend{
        display: flex;
        flex-direction: row;
    }

    .recommend p{
        margin: 5px;
        color: black;
        font-size: 16px;
    }

    .show-modal {
        padding: 10px;
        border: 1px solid #ccc;
        background: white;
        border-radius: 5px;

        text-align: center;
        font-size: 15px;
        cursor: pointer;
        transition: background-color 0.3s ease;
    }

    .show-modal:hover {
        background-color: #2980b9;
    }

    .okBtn a {
        flex: 1;
    }

</style>

<%@ include file="../include/header.jsp" %>
<body>
<div class="container">
    <div class="setting-container">
        <div class="setting-nav">
            <a href="/safetyCard/region" style="color: #00857F">지역설정</a>
            <a href="/safetyCard/category">업종설정</a>
            <a href="/safetyCard/time">시간설정</a>
            <a href="/safetyCard/selffdsTotal">통합설정</a>
        </div>
        <div class="setting-form">
            <div class="info">
                <h2>결제를 차단할 지역을 선택해주세요</h2>
            </div>

            <div class="region-content">
                <span class="spot-container">
                    <img src="../../../resources/img/map.png" style="height: 380px">
                    <button class="seoul-btn" onclick="selectRegion(this)" value="${regionList[0]}">서울</button>
                    <button class="gyeonggi-btn" onclick="selectRegion(this)" value="${regionList[1]}">경기도</button>
                    <button class="incheon-btn" onclick="selectRegion(this)" value="${regionList[2]}">인천</button>
                    <button class="gangwon-btn" onclick="selectRegion(this)" value="${regionList[3]}">강원도</button>
                    <button class="chungnam-btn" onclick="selectRegion(this)" value="${regionList[4]}">충청남도</button>
                    <button class="daejeon-btn" onclick="selectRegion(this)" value="${regionList[5]}">대전</button>
                    <button class="chungbuk-btn" onclick="selectRegion(this)" value="${regionList[6]}">충청북도</button>
                    <button class="sejong-btn" onclick="selectRegion(this)" value="${regionList[7]}">세종</button>
                    <button class="busan-btn" onclick="selectRegion(this)" value="${regionList[8]}">부산</button>
                    <button class="ulsan-btn" onclick="selectRegion(this)" value="${regionList[9]}">울산</button>
                    <button class="daegu-btn" onclick="selectRegion(this)" value="${regionList[10]}">대구</button>
                    <button class="gyeongbuk-btn" onclick="selectRegion(this)" value="${regionList[11]}">경상북도</button>
                    <button class="gyeonggnam-btn" onclick="selectRegion(this)" value="${regionList[12]}"> 경상남도</button>
                    <button class="jeollanam-btn" onclick="selectRegion(this)" value="${regionList[13]}">전라남도</button>
                    <button class="gwangju-btn" onclick="selectRegion(this)" value="${regionList[14]}">광주</button>
                    <button class="jeollabuk-btn" onclick="selectRegion(this)" value="${regionList[15]}">전라북도</button>
                    <button class="jejudo-btn" onclick="selectRegion(this)" value="${regionList[16]}">제주도</button>
                </span>
                <div class="mychoice">
                    <div class="myreport">
                        <h2>차단 추천 지역</h2>
                        <div class="recommend"></div>
                        <button class="show-modal" onclick="openChartModal()">나의 소비 확인</button>
                    </div>
                    <div class="selected-btn">
                    <h2>선택한 차단 지역</h2>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div id="myChartmodal">
        <canvas id="myChart" width="500px" height="500px"></canvas>
        <script>
            $(document).ready(function () {
                let regionNameList = [];
                let region_cntList = [];
                let amount_sumList = [];
                $.ajax({
                    url: '/chart/regionServiceChart', // 컨트롤러의 엔드포인트 경로
                    type: 'GET',
                    success: function (data) {
                        // 데이터 가공
                        for (let i = 0; i < data.length; i++) {
                            regionNameList.push(data[i].regionName)
                            region_cntList.push(data[i].region_cnt)
                            amount_sumList.push(data[i].amount_sum)
                        }

                        // 바 차트 그리기
                        var ctx = document.getElementById('myChart').getContext('2d');
                        new Chart(ctx, {
                            type: 'bar',
                            data: {
                                labels: regionNameList,
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

    document.addEventListener('DOMContentLoaded', function () {
        fetch('/chart/regionServiceChart')
            .then(response => response.json())
            .then(data => {
                const recommendElements = document.querySelector('.recommend');
                for (let i = 1; i < 4; i++) {
                    const regionTop = data[data.length - i].regionName;
                    const pTag = document.createElement('p');
                    pTag.textContent = regionTop;
                    recommendElements.appendChild(pTag);
                }
            })
            .catch(error => {
                console.error('Error:', error);
            });
    });



    function selectRegion(button) {
        var value = button.value;
        var selectedBtnDiv = document.querySelector('.selected-btn');

        // 새로운 버튼 생성
        var newButton = document.createElement('button');
        newButton.textContent = value;
        newButton.classList.add('selected-region');

        // 새로운 버튼을 선택된 버튼 영역에 추가
        selectedBtnDiv.appendChild(newButton);

        document.querySelector('.selected-btn').addEventListener('click', function (event) {
            // 클릭된 요소가 버튼인 경우에만 동작
            if (event.target.tagName === 'BUTTON') {
                // 클릭된 버튼 제거
                event.target.remove();
            }
        });
    }


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