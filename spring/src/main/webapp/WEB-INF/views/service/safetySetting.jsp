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
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.12.1/i18n/jquery-ui-i18n.min.js"></script>
    <link rel="stylesheet" href="https://uicdn.toast.com/tui.time-picker/latest/tui-time-picker.css">
    <script src="https://uicdn.toast.com/tui.time-picker/latest/tui-time-picker.js"></script>
    <script src="../../../resources/js/service.js" type="text/javascript"></script>
    <style>

        .main {
            width: 100%;
            margin: 0 auto;
        }

        mian h4 {
            margin: 5px 0 10px 0;
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
        }

        .setting-type > span {
            padding: 10px;
            font-weight: 700;
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
            border: 1px solid #ccc;
            background: white;
            border-radius: 5px;
        }

        .buttons > button:hover {
            border: 2px solid #00857F;
            border-radius: 5px;
            color: #00857F;
            font-weight: 700;
        }

        .buttons > input {
            flex: 1; /* 같은 크기로 나누기 위해 flex 설정 */
            /*margin: 0 5px; !* 요소 사이 간격 조절 *!*/
            padding: 10px;
            font-size: 14px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }

        .buttons > input:hover {
            border: 2px solid #00857F;
            border-radius: 5px;
            color: #00857F;
            font-weight: 700;
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

        .select-list > select {
            padding: 10px;
            border: 1px solid #ccc;
            width: 100%;
            margin-bottom: 20px;
            border-radius: 5px;
        }

        .select-list > select:hover {
            border: 2px solid #00857F;
            border-radius: 5px;
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
            height: 30px;
            background-color: white;
        }

        .reg-Btn {
            color: white;
            border: none;
            padding: 12px 40px 12px 40px;
            border-radius: 5px;
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

        #time-recommend {
            display: flex;
            flex-direction: column;
            width: 30%;
            margin-right: 0px;
        }

        .info {
            display: flex;
            flex-direction: row;
        }

        .show-modal {
            padding: 10px;
            border: 1px solid #ccc;
            background: white;
            border-radius: 5px;
            text-align: center;
            font-size: 12px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }


        select.limited-options {
            max-height: 130px; /* 이 값을 조절하여 5개의 항목에 대한 대략적인 높이를 설정하세요. */
            overflow-y: auto; /* 수직 스크롤을 활성화합니다. */
        }

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

        .recommend {
            display: flex;
            flex: 1;
            flex-direction: row;
        }

    </style>
</head>
<body>
<%@ include file="../include/header.jsp" %>
<div class="container">
    <div class="main">
        <h2>안심카드설정</h2>
        <h4>서비스선택</h4>
        <h3>대상카드</h3>
        <hr>
        <div>
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
                        <span>사용가능기간</span>
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
                        <input type="text" id="fromDate" name="fromDate" placeholder="📅">
                        <p style="margin: 0 10px 0 10px"><strong> ~ </strong></p>
                        <input type="text" id="toDate" name="toDate" placeholder="📅">
                    </div>
                </div>
                <div class="setting-buttons">
                    <div class="setting-type">
                        <span>적용구분</span>
                    </div>
                    <div class="buttons">
                        <button class="custom-setting1">맞춤설정</button>
                        <button class="custom-setting2">해외전체 정지</button>
                    </div>
                </div>
                <div id="region" class="setting-buttons">
                    <div class="setting-type">
                        <span>지역선택</span>
                    </div>
                    <div class="select-list">
                        <select class="limited-options">
                            <c:forEach var="entry" items="${regionList}">
                                <option name="${entry}">${entry}</option>
                            </c:forEach>
                        </select>
                        <div id="region-recommend" class="recommend">
                            <button class="show-modal" onclick="openMapModal()">지도보기</button>
                            <button class="show-modal" onclick="openChartRegionModal()">지역별 소비 확인</button>
                        </div>
                    </div>
                </div>
                <div id="time" class="setting-buttons">
                    <div class="setting-type">
                        <span>시간선택</span>
                    </div>
                    <div class="buttons" style="flex-direction: column">
                        <div class="info">
                            <div id="starttimepicker-container" class="tui-timepicker"
                                 style="margin-right: 15px;"></div>
                            <p style="position: relative; top:-10px;"><strong>~</strong></p>
                            <div id="endtimepicker-container" class="tui-timepicker" style="margin-left: 15px;"></div>
                        </div>
                        <div id="time-recommend" class="recommend">
                            <button class="show-modal" onclick="openChartTimeModal()">시간별 소비 확인</button>
                        </div>
                    </div>
                </div>
                <div id="category" class="setting-buttons">
                    <div class="setting-type">
                        <span>업종선택</span>
                    </div>
                    <div class="select-list">
                        <select id="selectCategoryBig-list" class="limited-options">
                            <option value="" selected disabled>대분류 선택</option>
                            <c:forEach var="entry" items="${categoryBigList}">
                                <option name="${entry}">${entry}</option>
                            </c:forEach>
                        </select>
                        <select id="selectCategorySmall-list">
                        </select>
                        <div id="category-recommend" class="recommend">
                            <button class="show-modal" onclick="openCategoryModal()">업종 한눈에 보기</button>
                            <button class="show-modal" onclick="openChartCategoryModal()">업종별 소비 확인</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <button class="reg-Btn"> 다음</button>
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

<div id="mapmodal" style="display: none">
    <div>지도모달</div>
    <img src="../../../resources/img/map.png" style="height: 380px">
    <span class="close" onclick="closeMapModal()">&times;</span>
</div>

<div id="categorymodal" style="display: none">
    <div>업종모달</div>
    <span class="close" onclick="closeCategoryModal()">&times;</span>
</div>

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


    document.getElementById('selectCategoryBig-list').addEventListener('change', function () {
        let selectedCategory = this.value;

        let categorySmallList = [];

        $.ajax({
            url: '/chart/categoryServiceChart',
            type: 'POST',
            contentType: 'application/json',
            data: JSON.stringify({categoryBig: selectedCategory}),
            success: function (data) {
                categorySmallList = data.map(item => item.categorySmall);

                // Populate categorySmall dropdown
                let selectCategorySmall = document.getElementById('selectCategorySmall-list');
                // selectCategorySmall.innerHTML = '<option value="" selected disabled>Select a category</option>';

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
    });




    const starttimepicker = new tui.TimePicker('#starttimepicker-container', {
        initialHour: 10,
        initialMinute: 0,
        inputType: 'selectbox',
        showMeridiem: true,
        minuteStep: 10 // 10분 단위로 설정
    });

    const endtimepicker = new tui.TimePicker('#endtimepicker-container', {
        initialHour: 18,
        initialMinute: 0,
        inputType: 'selectbox',
        showMeridiem: true,
        minuteStep: 10 // 10분 단위로 설정
    });

    tui.TimePicker.localeTexts['customKey'] = {
        am: 'a.m.',
        pm: 'p.m.'
    };

    const instance1 = new tui.TimePicker('#starttimepicker-container', {
        language: 'customKey',
        minuteStep: 10
    });

    const instance2 = new tui.TimePicker('#endtimepicker-container', {
        language: 'customKey',
        minuteStep: 10
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

    document.addEventListener('DOMContentLoaded', function () {
        var selectElems = document.querySelectorAll('.limited-options');

        selectElems.forEach(function (selectElem) {
            // 페이지 로드 시 size를 1로 설정
            selectElem.size = 1;

            selectElem.addEventListener('click', function () {
                this.size = 5; // 항목을 5개로 제한합니다.
            });

            selectElem.addEventListener('blur', function () {
                this.size = 1;
            });
        });
    });

</script>
</body>


</html>
