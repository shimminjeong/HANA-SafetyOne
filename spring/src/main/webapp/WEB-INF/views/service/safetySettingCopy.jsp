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
    <link href="../../../resources/css/safetySetting.css" rel="stylesheet">
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