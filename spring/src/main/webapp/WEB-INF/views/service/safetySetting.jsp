<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <%--    <link href="../../../resources/css/regionspot.css" rel="stylesheet">--%>
    <link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.12.1/i18n/jquery-ui-i18n.min.js"></script>
    <link rel="stylesheet" href="https://uicdn.toast.com/tui.time-picker/latest/tui-time-picker.css">
    <script src="https://uicdn.toast.com/tui.time-picker/latest/tui-time-picker.js"></script>


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
        }

        .buttons > button {
            flex: 1; /* 같은 크기로 나누기 위해 flex 설정 */
            /*margin: 0 5px; !* 요소 사이 간격 조절 *!*/
            padding: 10px;
            border: 1px solid #ccc;
        }

        .buttons > input {
            flex: 1; /* 같은 크기로 나누기 위해 flex 설정 */
            /*margin: 0 5px; !* 요소 사이 간격 조절 *!*/
            padding: 10px;
            font-size: 14px;
            border: 1px solid #ccc;
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
        }

        .time-select {
            display: flex;
            justify-content: space-between;
            width: 100%;
        }

        .time-select > input {
            flex: 1; /* 같은 크기로 나누기 위해 flex 설정 */
            padding: 10px;

            border: 1px solid #ccc;

        }

        .timepicker > .tui-timepicker {
            position: relative;
            font-weight: bold;
            border: 1px solid #aaa;
            background: white;
            text-align: center;
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
            margin: 0px auto ;
            display: block; /* 버튼을 블록 레벨로 설정하여 가운데 정렬을 위한 설정 */
        }


    </style>
</head>
<body>
<%@ include file="../include/header.jsp" %>
<div class="container">
    <div class="main">
        <h2>해외사용안심설정[Self FDS]</h2>
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
                        <input type="text" id="fromDate" name="fromDate">
                        <%--                        <span style="font-size: 18px;">&#x1F4C5;</span>--%>
                        <p><strong> ~ </strong></p>
                        <input type="text" id="toDate" name="toDate">
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
                <%--                <div id="category" class="setting-buttons">--%>
                <%--                    <div class="setting-type">--%>
                <%--                        <span>업종선택</span>--%>
                <%--                    </div>--%>
                <%--                    <div class="select-list">--%>
                <%--                        <select id="selectCategoryBig">--%>
                <%--                            <option value="" selected disabled>대분류 선택</option>--%>
                <%--                            <c:forEach var="entry" items="${categoryBigList}">--%>
                <%--                                <option name="${entry}">${entry}</option>--%>
                <%--                            </c:forEach>--%>
                <%--                        </select>--%>
                <%--                        <select id="selectCategorySmall">--%>
                <%--                            &lt;%&ndash;                            <option value="" selected disabled></option>&ndash;%&gt;--%>
                <%--                        </select>--%>
                <%--                    </div>--%>
                <%--                </div>--%>
                <div id="region" class="setting-buttons">
                    <div class="setting-type">
                        <span>지역선택</span>
                    </div>
                    <div class="select-list">
                        <select>
                            <c:forEach var="entry" items="${regionList}">
                                <option name="${entry}">${entry}</option>
                            </c:forEach>
                        </select>
                        <%--                        <div class="spot">--%>
                        <%--                            <img src="../../../resources/img/map.png" style="height: 380px">--%>
                        <%--                            <button class="seoul-btn" onclick="selectRegion(this)" value="${regionList[0]}">서울</button>--%>
                        <%--                            <button class="gyeonggi-btn" onclick="selectRegion(this)" value="${regionList[1]}">경기도--%>
                        <%--                            </button>--%>
                        <%--                            <button class="incheon-btn" onclick="selectRegion(this)" value="${regionList[2]}">인천--%>
                        <%--                            </button>--%>
                        <%--                            <button class="gangwon-btn" onclick="selectRegion(this)" value="${regionList[3]}">강원도--%>
                        <%--                            </button>--%>
                        <%--                            <button class="chungnam-btn" onclick="selectRegion(this)" value="${regionList[4]}">충청남도--%>
                        <%--                            </button>--%>
                        <%--                            <button class="daejeon-btn" onclick="selectRegion(this)" value="${regionList[5]}">대전--%>
                        <%--                            </button>--%>
                        <%--                            <button class="chungbuk-btn" onclick="selectRegion(this)" value="${regionList[6]}">충청북도--%>
                        <%--                            </button>--%>

                        <%--                            <button class="busan-btn" onclick="selectRegion(this)" value="${regionList[8]}">부산</button>--%>
                        <%--                            <button class="ulsan-btn" onclick="selectRegion(this)" value="${regionList[9]}">울산</button>--%>
                        <%--                            <button class="daegu-btn" onclick="selectRegion(this)" value="${regionList[10]}">대구</button>--%>
                        <%--                            <button class="gyeongbuk-btn" onclick="selectRegion(this)" value="${regionList[11]}">경상북도--%>
                        <%--                            </button>--%>
                        <%--                            <button class="gyeonggnam-btn" onclick="selectRegion(this)" value="${regionList[12]}">경상남도--%>
                        <%--                            </button>--%>
                        <%--                            <button class="jeollanam-btn" onclick="selectRegion(this)" value="${regionList[13]}">전라남도--%>
                        <%--                            </button>--%>
                        <%--                            <button class="gwangju-btn" onclick="selectRegion(this)" value="${regionList[14]}">광주--%>
                        <%--                            </button>--%>
                        <%--                            <button class="jeollabuk-btn" onclick="selectRegion(this)" value="${regionList[15]}">전라북도--%>
                        <%--                            </button>--%>
                        <%--                            <button class="jejudo-btn" onclick="selectRegion(this)" value="${regionList[16]}">제주도--%>
                        <%--                            </button>--%>
                        <%--                            &lt;%&ndash;                        <div class="myconsume">&ndash;%&gt;--%>
                        <%--                            &lt;%&ndash;                            <h2>차단 추천</h2>&ndash;%&gt;--%>
                        <%--                            &lt;%&ndash;                            <div id="region-recommend" class="recommend"></div>&ndash;%&gt;--%>
                        <%--                            &lt;%&ndash;                            <a href="#" class="show-modal" onclick="openChartRegionModal()">지역 나의 소비 확인</a>&ndash;%&gt;--%>
                        <%--                            &lt;%&ndash;                        </div>&ndash;%&gt;--%>
                        <%--                        </div>--%>
                    </div>
                </div>
                <div id="time" class="setting-buttons">
                    <div class="setting-type">
                        <span>시간선택</span>
                    </div>
                    <div class="buttons">
                        <div id="starttimepicker-container" class="timepicker"></div>
                        <div id="endtimepicker-container" class="timepicker"></div>
                        <%--                        <div class="time-select">--%>
                        <%--                            <input type="number" class="custom-setting1" name="inputBox1">--%>
                        <%--                            <p><strong>~</strong></p>--%>
                        <%--                            <input type="number" class="custom-setting2" name="inputBox2">--%>
                        <%--                        </div>--%>
                        <%--                        <div class="myconsume">--%>
                        <%--                            <h2>차단 추천</h2>--%>
                        <%--                            <div id="time-recommend" class="recommend"></div>--%>
                        <%--                            <a href="#" class="show-modal" onclick="openChartTimeModal()">시간 나의 소비 확인</a>--%>
                        <%--                        </div>--%>
                    </div>
                </div>
                <div id="category" class="setting-buttons">
                    <div class="setting-type">
                        <span>업종선택</span>
                    </div>
                    <div class="select-list">
                        <select id="selectCategoryBig">
                            <option value="" selected disabled>대분류 선택</option>
                            <c:forEach var="entry" items="${categoryBigList}">
                                <option name="${entry}">${entry}</option>
                            </c:forEach>
                        </select>
                        <select id="selectCategorySmall">
                            <%--                            <option value="" selected disabled></option>--%>
                        </select>
                    </div>
                </div>

            </div>
        </div>
        <button class="reg-Btn"> 다음</button>
    </div>
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

    $(function () {
        $('.select-date').on('click', function () {
            var rangeSelect = $('#rangeSelect');
            if (rangeSelect.is(':visible')) {
                rangeSelect.hide();
            } else {
                rangeSelect.show();
            }
        });

        // Your existing datepicker initialization code here
    });

    const starttimepicker = new tui.TimePicker('#starttimepicker-container', {
        initialHour: 10,
        initialMinute: 0,
        inputType: 'selectbox',
        showMeridiem: true
    });

    // Initialize the second timepicker for end time
    const endtimepicker = new tui.TimePicker('#endtimepicker-container', {
        initialHour: 18,
        initialMinute: 0,
        inputType: 'selectbox',
        showMeridiem: true
    });

    // Add custom locale texts
    tui.TimePicker.localeTexts['customKey'] = {
        am: 'a.m.',
        pm: 'p.m.'
    };

    // Create instances of the timepicker with custom locale
    const instance1 = new tui.TimePicker('#starttimepicker-container', {
        language: 'customKey'
    });

    const instance2 = new tui.TimePicker('#endtimepicker-container', {
        language: 'customKey'
    });


    var today = $.datepicker.formatDate('yy-mm-dd', new Date());
    $(function () {

        //datepicker 한국어로 사용하기 위한 언어설정
        $.datepicker.setDefaults($.datepicker.regional['ko']);

        // 시작일(fromDate)은 종료일(toDate) 이후 날짜 선택 불가
        // 종료일(toDate)은 시작일(fromDate) 이전 날짜 선택 불가

        //시작일.
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
                // 시작일(fromDate) datepicker가 닫힐때
                // 종료일(toDate)의 선택할수있는 최소 날짜(minDate)를 선택한 시작일로 지정
                $("#toDate").datepicker("option", "minDate", selectedDate);
            }
        });

        //종료일
        $('#toDate').datepicker({
            dateFormat: "yy-mm-dd",
            monthNamesShort: ["1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월"],
            dayNamesMin: ["일", "월", "화", "수", "목", "금", "토"],
            changeMonth: true,
            maxDate: 1000, // 오늘 이후 날짜 선택 불가
            onClose: function (selectedDate) {
                // 종료일(toDate) datepicker가 닫힐때
                // 시작일(fromDate)의 선택할수있는 최대 날짜(maxDate)를 선택한 종료일로 지정
                $("#fromDate").datepicker("option", "maxDate", selectedDate);
            }
        });


    });


    document.getElementById('selectCategoryBig').addEventListener('change', function () {
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
                let selectCategorySmall = document.getElementById('selectCategorySmall');
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

</script>
</body>


</html>
