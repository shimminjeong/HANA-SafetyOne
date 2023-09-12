<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Title</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <link href="../../../resources/css/common.css" rel="stylesheet">
    <link href="../../../resources/css/regionspot.css" rel="stylesheet">
    <script src="../../../resources/js/service.js" type="text/javascript"></script>
    <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/chart.js@3.5.1/dist/chart.min.js"></script>
</head>
<style>

    .setting-container {
        width: 100%;
        height: 100%;
    }

    .region-content {
        display: flex;
        flex-direction: column;
        width: 100%;
        align-items: stretch;

    }

    /*region*/
    #region {
        position: relative;
        display: inline-block;
    }

    .spot button {
        position: absolute;
        cursor: pointer;
        background-color: transparent;
        border: none;
        padding: 0;
        font-size: 12px;
        color: black;
    }


    .time-select {
        display: flex;
        justify-content: center;
        align-items: center;
        margin-bottom: 30px;
        margin-top: 15px;

    }

    .inputBox1, .inputBox2 {
        padding: 10px;
        border: 1px solid #ccc;
        border-radius: 4px;
        background-color: #f5f5f5;
        width: 70px;
        height: 40px;
        font-size: 18px;
        text-align: center;
        margin-right: 10px;
    }

    p {
        font-size: 18px;
        margin-right: 10px;
    }


    .okBtn a {
        flex: 1;
    }

    .region-head {
        position: absolute;
        top: 32px;
        left: 0px;
    }


    /*category*/


    /* 모달의 기본 스타일 */
    #myRegionmodal, #myCategorymodal, #myTimemodal {
        display: none; /* 처음에는 숨겨둠. JavaScript로 보이게 할 예정 */
        position: fixed; /* 스크롤 해도 위치 고정 */
        top: 50%;
        left: 70%;
        transform: translate(-50%, -50%); /* 중앙 정렬 */
        width: 400px;
        max-width: 800px;
        background-color: #fff;
        box-shadow: 0px 0px 15px rgba(0, 0, 0, 0.2); /* 그림자 효과 */
        padding: 20px;
        border-radius: 8px; /* 모서리 둥글게 */
        z-index: 1000; /* 다른 요소 위에 위치 */
    }

    /* 캔버스 스타일 */
    #myRegionmodal canvas, #myCategorymodal canvas, #myTimemodal canvas {
        width: 50%;
        max-width: 750px;
        margin: 10px 0;
    }

    /* 닫기 버튼 스타일 */
    #myRegionmodal .close, #myCategorymodal .close, #myTimemodal .close {
        position: absolute;
        right: 10px;
        top: 10px;
        color: black;
        padding: 5px 10px;
        cursor: pointer;
        font-size: 18px;
    }

    #myRegionmodal .close:hover, #myCategorymodal .close:hover, #myTimemodal .close:hover {
        background-color: #00857F;
    }

    * {
        margin: 0;
        padding: 0;
        box-sizing: border-box;
    }

    .wrapper {
        width: 360px;
        margin: 20px auto 0;
    }

    .select, .options li {
        display: flex;
        cursor: pointer;
        align-items: center;
    }

    .select {
        height: 60px;
        padding: 0 20px;
        background: #4285f4;
        border-radius: 10px;
        color: #ffffff;
        justify-content: space-between;
    }

    .content {
        display: none;
        background: #ffffff;
        margin-top: 5px;
        padding: 15px;
        border-radius: 10px;
    }

    .active .content {
        display: block;
    }

    .content .search-box {
        position: relative;
    }

    .search-box .material-icons {
        left: 15px;
        line-height: 53px;
        position: absolute;
    }

    .search-box input {
        height: 53px;
        width: 100%;
        outline: none;
        font-size: 17px;
        padding: 0 10px 0 43px;
        border: 1px solid #aabb;
        border-radius: 10px;
    }

    .content .options {
        margin-top: 10px;
        max-height: 250px;
        overflow-y: auto;
    }

    .options::-webkit-scrollbar-track {
        backgound: #f1f1f1;
        border-radius: 25px;
    }

    .options::-webkit-scrollbar-thumb {
        backgound: #ccc;
        border-radius: 25px;
    }

    .options li {
        height: 50px;
        padding: 0 13px;
        border-radius: 7px;
    }

    .options li:hover {
        background: #f2f2f2;
    }

    .sub-container {
        background-color: #dddd; /* Light gray background */
        border: 1px solid #e0e0e0; /* Subtle border */
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1); /* Slight shadow for depth */
        padding: 15px; /* Internal spacing */
        margin: 15px 0; /* External spacing */
        border-radius: 5px; /* Rounded corners */
        transition: box-shadow 0.3s ease; /* Smooth shadow transition */
    }

    .myconsume {
        display: inline-block;
        justify-content: center;
        align-items: center;
        flex-direction: column;
        background-color: #f4f4f4; /* Light gray background */
        border: 1px solid #e0e0e0; /* Subtle border */
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1); /* Slight shadow for depth */
        padding: 15px; /* Internal spacing */
        margin: 15px 0; /* External spacing */
        border-radius: 5px; /* Rounded corners */
        transition: box-shadow 0.3s ease; /* Smooth shadow transition */
    }

    .sub-container {
        display: flex;
        align-items: center;
        box-sizing: border-box;
        flex-direction: column;
        width: 100%;
        margin-top: 10px;
    }

    .subsub-container{
        display: flex;
        align-items: center;
    }

    .recommend {
        background-color: #f4f4f4; /* Light gray background */
        border: 1px solid #e0e0e0; /* Subtle border */
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1); /* Slight shadow for depth */
        padding: 15px; /* Internal spacing */
        margin: 15px 0; /* External spacing */
        border-radius: 5px; /* Rounded corners */
        transition: box-shadow 0.3s ease; /* Smooth shadow transition */
        display: flex;
        flex-direction: row;
    }

    .recommend button {
        padding: 10px 20px;
        margin: 5px;
        background-color: #00857F;
        color: #fff;
        border: none;
        border-radius: 5px;
        font-size: 16px;
        cursor: pointer;
    }


</style>
<script>
    $(document).ready(function () {
        $("#category, #time, #region").hide();

        const urlParams = new URLSearchParams(window.location.search);
        const selectedButtons = urlParams.get('selectedButtons');

        if (selectedButtons) {
            const buttons = selectedButtons.split(',');
            for (let btn of buttons) {
                $("#" + btn).show();
            }
        }
    });

    document.addEventListener('DOMContentLoaded', function () {
        fetch('/chart/regionServiceChart')
            .then(response => response.json())
            .then(data => {
                const recommendElements = document.querySelector('#region-recommend'); // Select by ID

                for (let i = 1; i < 4; i++) {
                    const regionTop = data[data.length - i].regionName;
                    const button = document.createElement('button');
                    button.textContent = regionTop;

                    // Apply button styling
                    button.classList.add('recommend-button');

                    recommendElements.appendChild(button);
                    console.log(regionTop);
                }
            })
            .catch(error => {
                console.error('Error:', error);
            });
    });

    document.addEventListener('DOMContentLoaded', function () {
        fetch('/chart/timeServiceChart')
            .then(response => response.json())
            .then(data => {
                const recommendElements = document.querySelector('#time-recommend'); // Select by ID

                for (let i = 1; i < 4; i++) {
                    const timeTop = data[data.length - i].time;
                    const button = document.createElement('button');
                    button.textContent = timeTop;

                    // Apply button styling
                    button.classList.add('time-button');

                    recommendElements.appendChild(button);
                    console.log(timeTop);
                }
            })
            .catch(error => {
                console.error('Error:', error);
            });
    });


</script>
<%@ include file="../include/header.jsp" %>
<body>
<div class="container">
    <h1 style="margin-top: 50px"> 안심카드설정</h1>
    <h2 style="margin-top: 30px">결제를 차단할 조합을 설정하세요</h2>
    <div class="setting-container">
        <div class="region-content">
            <div id="region" class="sub-container">
                <h2>지역 선택</h2>
                <div class="subsub-container">
                    <div class="spot">
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
                        <button class="gyeongbuk-btn" onclick="selectRegion(this)" value="${regionList[11]}">경상북도
                        </button>
                        <button class="gyeonggnam-btn" onclick="selectRegion(this)" value="${regionList[12]}"> 경상남도
                        </button>
                        <button class="jeollanam-btn" onclick="selectRegion(this)" value="${regionList[13]}">전라남도
                        </button>
                        <button class="gwangju-btn" onclick="selectRegion(this)" value="${regionList[14]}">광주</button>
                        <button class="jeollabuk-btn" onclick="selectRegion(this)" value="${regionList[15]}">전라북도
                        </button>
                        <button class="jejudo-btn" onclick="selectRegion(this)" value="${regionList[16]}">제주도</button>
                    </div>
                    <div class="myconsume">
                        <h2>차단 추천</h2>
                        <div id="region-recommend" class="recommend"></div>
                        <a href="#" class="show-modal" onclick="openChartRegionModal()">지역 나의 소비 확인</a>
                    </div>
                </div>
            </div>
            <div id="time" class="sub-container">
                <h2>시간 선택</h2>
                <div class="subsub-container">
                    <div class="time-select">
                        <input type="number" class="inputBox1" name="inputBox1">
                        <p>시 ~ </p>
                        <input type="number" class="inputBox2" name="inputBox2">
                        <p>시 차단 </p>
                    </div>
                    <div class="myconsume">
                        <h2>차단 추천</h2>
                        <div id="time-recommend" class="recommend"></div>
                        <a href="#" class="show-modal" onclick="openChartTimeModal()">시간 나의 소비 확인</a>
                    </div>
                </div>
            </div>
            <div id="category" class="sub-container">
                <h2>업종 선택</h2>
                <div class="subsub-container">
                    <div class="grid-container">
                        <c:set var="imgList"
                               value="${['restaurant.png', 'shopping-cart.png', 'butcher-shop.png', 'fashion.png', 'sports.png', 'world.png', 'cosmetics.png', 'laundry-shop.png', 'education.png', 'hospital.png', 'electronics.png', 'taxi.png', 'oilstation.png']}"/>
                        <c:forEach var="entry" items="${categoryMap}" varStatus="loop">
                            <div class="grid-item">
                                <c:set var="imgIndex" value="${loop.index % imgList.size()}"/>
                                <c:set var="imageName" value="${imgList[imgIndex]}"/>
                                <img class="grid-image" src="../../../resources/img/${imageName}" alt="${entry.key}">
                                <div class="item-name">${entry.key}</div>
                                <div class="dropdown-list">
                                    <div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
                                        <c:forEach var="category" items="${entry.value}">
                                            <a class="dropdown-item"
                                               onclick="selectCategory('${category.categorySmall}')">${category.categorySmall}</a>
                                        </c:forEach>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                    <div class="myconsume">
                        <h2>차단 추천</h2>
                        <div id="category-recommend" class="recommend"></div>
                        <a href="#" class="show-modal" onclick="openChartCategoryModal()">업종 나의 소비 확인</a>
                    </div>
                </div>
            </div>
        </div>
        <div class="selected-btn">선택한 차단 조합</div>
        <button class="okBtn"><a href="#">등록</a></button>
    </div>
</div>
<div id="myRegionmodal">
    <canvas id="myRegionCntChart"></canvas>
    <canvas id="myRegionSumChart"></canvas>
    <span class="close" onclick="closeChartRegionModal()">&times;</span>
</div>
<div id="myCategorymodal">
    <h2>업종별 소비내역 확인</h2>
    <select id="selectCategoryBig">
        <c:forEach var="entry" items="${categoryBigList}">
            <option name="${entry}">${entry}</option>
        </c:forEach>
    </select>
    <button onclick="selectCategoryBig()">전송</button>
    <canvas id="myCategoryCntChart"></canvas>
    <canvas id="myCategorySumChart"></canvas>
    <span class="close" onclick="closeChartCategoryModal()">&times;</span>
</div>
<div id="myTimemodal">
    <canvas id="myTimeCntChart"></canvas>
    <canvas id="myTimeSumChart"></canvas>
    <span class="close" onclick="closeChartTimeModal()">&times;</span>
</div>
</body>
</html>
