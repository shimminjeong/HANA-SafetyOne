<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <%--    <link href="../../../resources/css/regionspot.css" rel="stylesheet">--%>
    <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/chart.js@3.5.1/dist/chart.min.js"></script>
    <link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
    <script src="../../../resources/js/service.js" type="text/javascript"></script>
    <style>
        .main {
            width: 100%;
            margin: 70px auto;
        }


        main hr {
            border: 1px solid;
        }

        .card-info {
            width: 100%;
            float: left;
            padding: 20px 10px 20px 10px;
        }

        .card-details {
            width: 30%;
            float: left;
            padding: 10px;
        }

        .card-type {
            width: 60%;
            padding: 10px;
        }

        .setting-options {
            width: 100%;
            height: 100%;
            background: #eafaf3;
            float: left;
            padding-bottom: 50px;
            margin-bottom: 50px;
        }

        .setting-buttons {
            display: flex;
            margin: 0 auto;
            width: 800px;
            justify-content: center;
            margin-bottom: -50px;

        }

        .setting-type {
            width: 20%;
            padding: 50px 0px 30px 0;
            font-weight: 700;
            text-align: left;
            margin: 13px;
            font-size: 18px;

        }

        .setting-type > span {
            padding: 10px;
        }

        .buttons {
            padding: 50px 0px 30px 0px;
            width: 50%;
            display: flex;
            align-items: center;
            text-align: center;
            justify-content: center;
        }

        .buttons > button {
            flex: 1; /* 같은 크기로 나누기 위해 flex 설정 */
            /*margin: 0 5px; !* 요소 사이 간격 조절 *!*/
            padding: 10px;
            border: 1px solid black;
            background: white;
            border-radius: 2px;
            font-size: 16px;
        }

        .buttons > button:hover {
            border: 2px solid #00857F;
            border-radius: 2px;
            color: #00857F;
        }

        .buttons > input {
            flex: 1; /* 같은 크기로 나누기 위해 flex 설정 */
            /*margin: 0 5px; !* 요소 사이 간격 조절 *!*/
            padding: 10px;
            font-size: 16px;
            border: 1px solid #ccc;
            border-radius: 2px;
        }

        .buttons > input:hover {
            border: 2px solid #00857F;
            border-radius: 2px;
            color: #00857F;
        }

        .buttons input[type="text"]::placeholder {
            direction: rtl; /* 텍스트 방향을 오른쪽에서 왼쪽으로 설정 */
            text-align: right; /* 텍스트를 오른쪽으로 정렬 */
        }

        .select-list {
            padding: 50px 0px 30px 0px;
            width: 50%;
            display: flex;
            flex-direction: column;
            align-items: center;
            text-align: center;

        }

        #selectCategoryBig {
            display: flex;
            flex-direction: row;
            padding: 10px;
            width: 50%;
            border-radius: 2px;
        }


        .myselect-region, .myselect-category, .myselect-time {
            /*padding: 50px 0px 30px 0px;*/
            width: 100%;
            display: none;
            flex-direction: column;
            align-items: center;
            text-align: center;

        }

        .select-con {
            display: flex;
            flex-direction: row;
            padding: 10px;
            width: 100%;
            border-radius: 2px;
        }

        .select-con > .select-element {
            padding: 10px;
            border: 1px solid #ccc;
            width: 75%;
            background-color: rgba(238, 238, 238, 0.5);
            border-radius: 2px;
            color: #717171;
        }

        .select-con > .delete-btn {
            padding: 10px;
            border: 1px solid black;
            background-color: white;
            width: 25%;
            margin-left: 10px;
            border-radius: 2px;
        }


        .select-list > select {
            padding: 10px;
            border: 1px solid #ccc;
            width: 100%;
            margin-bottom: 20px;
            border-radius: 2px;
            font-size: 16px;
        }

        .select-list > select:hover {
            border: 2px solid #00857F;
            border-radius: 2px;
            color: #00857F;
            font-weight: 700;
        }

        .time-select > input {
            flex: 1; /* 같은 크기로 나누기 위해 flex 설정 */
            padding: 10px;
            border: 1px solid #ccc;
        }

        .tui-timepicker {
            position: relative;
            font-weight: bold;
            background: none;
            text-align: center;
            border: none;
            padding: 0;
            height: 30px;
        }

        .tui-timepicker select {
            height: 40px;
            background-color: white;
            font-size: 16px;
        }

        .reg-Btn {
            color: white;
            border: none;
            padding: 12px 40px 12px 40px;
            border-radius: 2px;
            cursor: pointer;
            text-decoration: none;
            background-color: #00857F;
            font-size: 16px;
            transition: background-color 0.3s;
            align-items: center;
            margin: 0px auto;
            display: block; /* 버튼을 블록 레벨로 설정하여 가운데 정렬을 위한 설정 */
        }

        .custom-setting1 {
            margin-right: 15px;
        }




        .show-modal {
            padding: 10px;
            border: 1px solid #ccc;
            background: white;
            border-radius: 5px;
            text-align: center;
            font-size: 16px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }


        .limited-options {
            max-height: 130px; /* 이 값을 조절하여 5개의 항목에 대한 대략적인 높이를 설정하세요. */
            overflow-y: auto; /* 수직 스크롤을 활성화합니다. */
        }

        #myRegionmodal, #myCategorymodal, #myTimemodal, #categorymodal, #mapmodal {
            display: none; /* 처음에는 숨겨둠. JavaScript로 보이게 할 예정 */
            position: fixed; /* 스크롤 해도 위치 고정 */
            top: 50%;
            left: 70%;
            transform: translate(-50%, -50%); /* 중앙 정렬 */
            width: 436px;
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
        #myRegionmodal .close, #myCategorymodal .close, #myTimemodal .close, #categorymodal .close, #mapmodal .close {
            position: absolute;
            right: 10px;
            top: 10px;
            color: black;
            padding: 5px 10px;
            cursor: pointer;
            font-size: 18px;
        }

        #myRegionmodal .close:hover, #myCategorymodal .close:hover, #myTimemodal .close:hover, #categorymodal .close:hover, #mapmodal .close:hover {
            background-color: #00857F;
        }

        .recommend {
            display: flex;
            flex: 1;
            flex-direction: row;
        }

        .buttons .select {
            padding: 10px;
            border: 1px solid #ccc;
            background: white;
            border-radius: 2px;
        }

        .grid-container {
            margin-top: 40px;
            margin-bottom: 30px;
            display: grid;
            grid-template-columns: repeat(5, 87px); /* 2열로 반복 */
            /*grid-gap: 10px; !* 박스 사이의 간격 설정 *!*/
            align-items: center; /* 내용 수직 가운데 정렬 */
            text-align: center; /* 내용 가로 가운데 정렬 */
        }

        .grid-item {
            display: flex;
            flex-direction: column;
            justify-content: center;
            border: 1px solid black;
            padding: 10px 5px;
            height: 100px; /* 그리드 컨테이너의 높이 설정 */
            cursor: pointer;
            transition: background-color 0.3s;
            position: relative;
            font-size: 15px;

        }

        .dropdown-item {
            display: none;
            cursor: pointer;
            margin: auto;
            font-size: 12px;
            line-height: 25px;
            height: 25px;
            background-color: transparent; /* 초기 배경 설정 */
            transition: background-color 0.3s ease; /* 배경 변경 시 부드러운 효과를 위한 트랜지션 추가 */
            padding: 0px 3px;
        }

        .dropdown-item:hover {
            background-color: #00857F; /* 마우스 호버 시 배경 변경 */
            transform: scale(1.1); /* hover 시 약간 확대되는 효과 */
            box-shadow: 0 6px 8px rgba(0, 0, 0, 0.2); /* hover 시 그림자 약간 강화 */
            color: white;
        }

        .dropdown-list {
            position: absolute;
            top: 100%; /* Position the dropdown below the grid item */
            left: 0;
            width: 100%; /* Make the dropdown width match the grid item width */
            z-index: 1; /* Ensure the dropdown appears above other content */
            background-color: #ffffff; /* Add a background color */
            /*border: 1px solid  !* Add a border for visual separation *!*/
            box-shadow: 0px 2px 5px rgba(0, 0, 0, 0.1); /* Add shadow for depth */
        }

        .grid-item:hover .dropdown-item {
            display: block;
            color: black;
        }

        .grid-image {
            width: 50px; /* 이미지 너비 설정 */
            height: 50px; /* 이미지 높이 설정 */
            padding-bottom: 14px;
            margin: 0 auto; /* 이미지 가운데 정렬 */
            /*display: block; !* 이미지를 블록 요소로 변경 *!*/
        }

        .grid-item:hover {
            background-color: #00857F;
            border: 1px solid #ffffff;
            color: black;
        }

        .select-no {
            margin-right: 15px;
        }

        .buttons > .active-button {
            background-color: #dddddd;
        }

        .recommend{
            margin-bottom: 30px;
        }

        .info {
            display: flex;
            flex-direction: row;
            align-items: center;
            align-content: center;
            margin-bottom: 20px;
        }

        #startHour, #endHour , #startMinute, #endMinute{
            width: 80px;
            height: 38px;
            font-size: 16px;
        }

    </style>
</head>
<body>
<%@ include file="../include/header.jsp" %>
<div class="container">
    <div class="main">
        <h2>안심카드설정</h2>
        <h3>대상카드</h3>
        <hr>
        <div class="card-info">
            <div class="card-details">
                <span>본인 | </span>
                <span><%=session.getAttribute("cardId")%></span>
            </div>
            <div class="card-type">
                <span>알뜰교통 S20(체크)</span>
            </div>
        </div>
        <div class="setting-options">
            <div class="setting-buttons">
                <div class="setting-type">
                    <span>서비스사용기간</span>
                </div>
                <div class="buttons">
                    <button class="custom-setting1">카드유효기간까지</button>
                    <button class="select-date">직접선택</button>
                </div>
            </div>
            <div class="setting-buttons" id="rangeSelect" style="display: none;">
                <div class="setting-type">
                    <span>기간선택</span>
                </div>
                <div class="buttons">
                    <input type="text" style="width: 155px" id="fromDate" name="fromDate" placeholder="📅">
                    <p style="margin: 0 10px 0 10px"><strong> ~ </strong></p>
                    <input type="text" style="width: 155px"  id="toDate" name="toDate" placeholder="📅">
                </div>
            </div>
            <div class="setting-buttons">
                <div class="setting-type">
                    <span>차단지역선택</span>
                </div>
                <div class="buttons">
                    <button class="select-no" id="region-no">선택안함</button>
                    <button class ="select-thing" id="select-region">직접선택</button>
                </div>
            </div>
            <div id="region" class="setting-buttons" style="display: none;">
                <div class="setting-type">
                    <span></span>
                </div>
                <div class="select-list">
                    <div class="recommend">
                        <button class="show-modal" onclick="openMapModal()">지도보기</button>
                        <button class="show-modal" onclick="openChartRegionModal()">지역별 소비 확인</button>
                    </div>
                    <select class="limited-options">
                        <c:forEach var="entry" items="${regionList}">
                            <option name="${entry}">${entry}</option>
                        </c:forEach>
                    </select>
                    <div class="myselect-region">
                    </div>
                </div>
            </div>
            <div class="setting-buttons">
                <div class="setting-type">
                    <span>차단시간선택</span>
                </div>
                <div class="buttons">
                    <button class="select-no" id="time-no">선택안함</button>
                    <button class ="select-thing" id="select-time">직접선택</button>
                </div>
            </div>
            <div id="time" class="setting-buttons" style="display: none;">
                <div class="setting-type">
                    <span></span>
                </div>
                <div class="buttons" style="flex-direction: column">
                    <div class="recommend">
                        <button class="show-modal" onclick="openChartTimeModal()">시간별 소비 확인</button>
                    </div>
                    <div class="info">
                        <select id="startHour"></select>
                        <p style="margin: 0 10px 0 10px"><strong> : </strong></p>
                        <select id="startMinute"></select>
                        <p style="margin: 0 10px 0 10px"><strong> ~ </strong></p>
                        <select id="endHour" ></select>
                        <p style="margin: 0 10px 0 10px"><strong> : </strong></p>
                        <select id="endMinute" onchange="updateTime()"></select>
                    </div>
                    <div class="myselect-time"></div>
                </div>
            </div>
            <div class="setting-buttons">
                <div class="setting-type">
                    <span>차단업종선택</span>
                </div>
                <div class="buttons">
                    <button class="select-no" id="category-no">선택안함</button>
                    <button class ="select-thing" id="select-category">직접선택</button>
                </div>
            </div>
            <div id="category" class="setting-buttons" style="display: none;">
                <div class="setting-type">
                    <span></span>
                </div>
                <div class="select-list">
                    <div class="recommend">
                        <button class="show-modal" onclick="openCategoryModal()">업종 한눈에 보기</button>
                        <button class="show-modal" onclick="openChartCategoryModal()">업종별 소비 확인</button>
                    </div>
                    <select id="selectCategoryBig-list" class="limited-options">
                        <option value="" selected disabled>대분류 선택</option>
                        <c:forEach var="entry" items="${categoryBigList}">
                            <option name="${entry}">${entry}</option>
                        </c:forEach>
                    </select>
                    <select id="selectCategorySmall-list">
                    </select>
                    <div class="myselect-category"></div>
                </div>
            </div>
        </div>
    </div>
    <button class="reg-Btn" onclick="sendSettingsToController()"> 등록</button>
</div>
<div class="modal">
    <div id="myRegionmodal">
        <canvas id="myRegionCntChart"></canvas>
        <span class="close" onclick="closeChartRegionModal()">&times;</span>
    </div>
    <div id="myCategorymodal">
        <h2>업종별 소비내역 확인</h2>
        <select id="selectCategoryBig" class="limited-options">
            <c:forEach var="entry" items="${categoryBigList}">
                <option name="${entry}">${entry}</option>
            </c:forEach>
        </select>
        <canvas id="myCategoryCntChart"></canvas>
        <span class="close" onclick="closeChartCategoryModal()">&times;</span>
    </div>
    <div id="myTimemodal">
        <canvas id="myTimeCntChart"></canvas>
        <span class="close" onclick="closeChartTimeModal()">&times;</span>
    </div>
    <div id="mapmodal">
        <h2>지도 한눈에 보기</h2>
        <img src="../../../resources/img/map.png" style="height: 380px">
        <span class="close" onclick="closeMapModal()">&times;</span>
    </div>
    <div id="categorymodal">
        <h2>업종 한눈에 보기</h2>
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
        <span class="close" onclick="closeCategoryModal()">&times;</span>
    </div>
</div>
<script>

    function collectSettings() {


        let settingsMap = {};

        const safetyStartDate = document.getElementById('fromDate').value;
        const safetyEndDate = document.getElementById('toDate').value;
        settingsMap['safetyStartDate']=safetyStartDate;
        settingsMap['safetyEndDate']=safetyEndDate;
        settingsMap['cardId']='<%= session.getAttribute("cardId") %>';

        // regions 값 추출
        const regionSelectedElements = document.querySelectorAll('.myselect-region .select-element');
        if (regionSelectedElements.length > 0) {
            settingsMap['regions'] = Array.from(regionSelectedElements).map(ele => ele.textContent);
        }

        // category 값 추출
        const categorySelectedElements = document.querySelectorAll('.myselect-category .select-element');
        if (categorySelectedElements.length > 0) {
            settingsMap['category'] = Array.from(categorySelectedElements).map(ele => ele.textContent);

        }

        // time 값 추출
        const timeSelectedValue = document.querySelector('.myselect-time .select-element');
        if (timeSelectedValue) {
            const timeParts = timeSelectedValue.textContent.split(' ~ ');
            settingsMap['startTime'] = timeParts[0].trim();
            settingsMap['endTime'] = timeParts[1].trim();
        }

        // null 또는 빈 배열 제거
        for (let key in settingsMap) {
            if (settingsMap[key] === null || (Array.isArray(settingsMap[key]) && settingsMap[key].length === 0)) {
                delete settingsMap[key];
            }
        }

        console.log(settingsMap);

        return settingsMap;
    }

    function sendSettingsToController() {
        const settings = collectSettings();
        console.log("settings",settings);

        fetch('/safetyCard/insertsetting', {
            method: 'POST',  // 'GET' 대신 'POST'를 사용
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify(settings),
        })
            .then(response => response.json())
            .then(data => {
                console.log('Success:', data);
            })
            .catch((error) => {
                console.error('Error:', error);
            });
    }





    function populateTimeOptions() {
        const startHourSelect = document.getElementById('startHour');
        const endHourSelect = document.getElementById('endHour');
        const startMinuteSelect = document.getElementById('startMinute');
        const endMinuteSelect = document.getElementById('endMinute');

        for (let i = 1; i <= 24; i++) {
            const option1 = document.createElement('option');
            option1.value = i;
            option1.textContent = i;
            startHourSelect.appendChild(option1);

            const option2 = option1.cloneNode(true);
            endHourSelect.appendChild(option2);
        }

        for (let j = 0; j < 60; j+=10) {
            const optionMinute = document.createElement('option');
            optionMinute.value = j;
            optionMinute.textContent = j < 10 ? '0' + j : j;  // 0 ~ 9인 경우 앞에 0을 추가
            startMinuteSelect.appendChild(optionMinute.cloneNode(true));
            endMinuteSelect.appendChild(optionMinute.cloneNode(true));
        }
    }

    populateTimeOptions();

    // 시작 시간 업데이트
    function updateTime() {
        const startHour = document.getElementById('startHour').value;
        console.log("updatestartHour",startHour);
        const startMinute = document.getElementById('startMinute').value;
        const endHour = document.getElementById('endHour').value;
        const endMinute = document.getElementById('endMinute').value;
        console.log("endHour",endHour);
        const timeText = startHour + ' : '+startMinute+' ~ ' + endHour + ' : '+endMinute;
        const newSelectDiv = document.createElement('div');
        newSelectDiv.classList.add('select-con');

        const newSelectElement = document.createElement('div');
        newSelectElement.classList.add('select-element');
        newSelectElement.textContent = timeText;

        const myselectContainer = document.querySelector('.myselect-time');

        const deleteButton = document.createElement('button');
        deleteButton.classList.add('delete-btn');
        deleteButton.textContent = '삭제';
        deleteButton.addEventListener('click', function () {
            myselectContainer.removeChild(newSelectDiv);
            if (!myselectContainer.querySelector('.select-con')) {
                myselectContainer.style.display = 'none';
            }
        });

        newSelectDiv.appendChild(newSelectElement);
        newSelectDiv.appendChild(deleteButton);

        myselectContainer.appendChild(newSelectDiv);
        myselectContainer.style.display = 'flex';

    }



    document.addEventListener('DOMContentLoaded', function () {

        // 카테고리 설정 버튼들
        let categoryButtons = document.querySelectorAll('#category-no,#select-category');
        categoryButtons.forEach(function (button) {
            button.addEventListener('click', function () {
                categoryButtons.forEach(function (btn) {
                    btn.classList.remove('active-button');
                });
                this.classList.add('active-button');
            });
        });

        // 시간 설정 버튼들
        let timeButtons = document.querySelectorAll('#time-no,#select-time');
        timeButtons.forEach(function (button) {
            button.addEventListener('click', function () {
                timeButtons.forEach(function (btn) {
                    btn.classList.remove('active-button');
                });
                this.classList.add('active-button');
            });
        });

        let regionButtons = document.querySelectorAll('#region-no,#select-region');
        regionButtons.forEach(function (button) {
            button.addEventListener('click', function () {
                regionButtons.forEach(function (btn) {
                    btn.classList.remove('active-button');
                });
                this.classList.add('active-button');
            });
        });

    });





    $(function () {
        $('#select-region').on('click', function () {
            var rangeSelect = $('#region');
            if (rangeSelect.is(':visible')) {
                rangeSelect.hide();
            } else {
                rangeSelect.show();
            }
        });
    });

    $(function () {
        $('#select-category').on('click', function () {
            var rangeSelect = $('#category');
            if (rangeSelect.is(':visible')) {
                rangeSelect.hide();
            } else {
                rangeSelect.show();
            }
        });
    });

    $(function () {
        $('#select-time').on('click', function () {
            var rangeSelect = $('#time');
            if (rangeSelect.is(':visible')) {
                rangeSelect.hide();
            } else {
                rangeSelect.show();
            }
        });
    });

    function appendSelectedValueToMySelect(selectedValue, containerSelector) {
        const myselectContainer = document.querySelector(containerSelector);

        const newSelectDiv = document.createElement('div');
        newSelectDiv.classList.add('select-con');

        const newSelectElement = document.createElement('div');
        newSelectElement.classList.add('select-element');
        newSelectElement.textContent = selectedValue;

        const deleteButton = document.createElement('button');
        deleteButton.classList.add('delete-btn');
        deleteButton.textContent = '삭제';
        deleteButton.addEventListener('click', function () {
            myselectContainer.removeChild(newSelectDiv);
            if (!myselectContainer.querySelector('.select-con')) {
                myselectContainer.style.display = 'none';
            }
        });

        newSelectDiv.appendChild(newSelectElement);
        newSelectDiv.appendChild(deleteButton);

        myselectContainer.appendChild(newSelectDiv);
        myselectContainer.style.display = 'flex';
    }

    // 첫 번째 select element에 대한 이벤트 핸들러
    document.querySelector('.limited-options').addEventListener('change', function () {
        appendSelectedValueToMySelect(this.value, '.myselect-region');
    });

    // 두 번째 select element에 대한 이벤트 핸들러
    document.getElementById('selectCategorySmall-list').addEventListener('change', function () {
        appendSelectedValueToMySelect(this.value, '.myselect-category');
    });




    function selectSmallCategory(selectedCategory) {
        let categorySmallList = [];

        $.ajax({
            url: '/chart/categoryServiceChart',
            type: 'POST',
            contentType: 'application/json',
            data: JSON.stringify({categoryBig: selectedCategory}),
            success: function (data) {
                categorySmallList = data.map(item => item.categorySmall);

                let selectCategorySmall = document.getElementById('selectCategorySmall-list');
                selectCategorySmall.innerHTML = '<option value="" selected disabled></option>';

                for (let i = 0; i < categorySmallList.length; i++) {
                    let option = document.createElement('option');
                    option.value = categorySmallList[i];
                    option.textContent = categorySmallList[i];
                    selectCategorySmall.appendChild(option);
                }
            },
            error: function () {
                console.log('Error fetching categorySmall data.');
            }
        });
    }

    document.getElementById('selectCategoryBig-list').addEventListener('change', function () {
        selectSmallCategory(this.value);
    });


    document.getElementById('selectCategoryBig').addEventListener('change', function () {
        updateCategoryChart(this.value);
    });



    $(function () {
        $('.select-date').on('click', function () {
            var rangeSelect = $('#rangeSelect');
            if (rangeSelect.is(':visible')) {
                rangeSelect.hide();
            } else {
                rangeSelect.show();
            }
        });
    });


    var today = $.datepicker.formatDate('yy-mm-dd', new Date());
    $(function () {

        $.datepicker.setDefaults($.datepicker.regional['ko']);

        $('#fromDate').datepicker({
            dateFormat: "yy-mm-dd",
            monthNamesShort: ["1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월"],
            dayNamesMin: ["일", "월", "화", "수", "목", "금", "토"],
            buttonImage: "/jdAdmin/images/calendar.png", // 버튼 이미지
            buttonImageOnly: true,             // 버튼 이미지만 표시할지 여부
            buttonText: "날짜선택",             // 버튼의 대체 텍스트
            changeMonth: true,                  // 월을 이동하기 위한 선택상자 표시여부
            maxDate: 1000,                       // 선택할수있는 최소날짜, ( 0 : 오늘 이후 날짜 선택 불가)
            onClose: function (selectedDate) {
                $("#toDate").datepicker("option", "minDate", selectedDate);
            }
        });

        $('#toDate').datepicker({
            dateFormat: "yy-mm-dd",
            monthNamesShort: ["1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월"],
            dayNamesMin: ["일", "월", "화", "수", "목", "금", "토"],
            changeMonth: true,
            maxDate: 1000,
            onClose: function (selectedDate) {
                $("#fromDate").datepicker("option", "maxDate", selectedDate);
            }
        });


    });


</script>
</body>
</html>