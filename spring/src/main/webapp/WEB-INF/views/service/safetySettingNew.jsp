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
    <%--    <script src="../../../resources/js/service.js" type="text/javascript"></script>--%>
    <link href="../../../resources/css/safetyCardCommon.css" rel="stylesheet">
    <link href="../../../resources/css/safetySettingNew.css" rel="stylesheet">


</head>
<body>
<%@ include file="../include/header.jsp" %>
<div class="container">
    <div class="main">
        <h1>안심카드설정</h1>
        <h2>대상카드</h2>
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
            <div class="info-header">결제를 차단할 지역, 시간, 업종 등 나만의 rule을 설정해보세요</div>
            <div class="info-content">결제를 허용할 지역을 선택하세요</div>
            <div class="setting-buttons">
                <span>허용지역선택</span>
                <button class="select-no" id="region-no" onclick="noSelect(this)">선택안함</button>
                <button class="select-thing" id="select-region" onclick="window.location.href='/safetyCard/region'">
                    지역선택
                </button>
            </div>
            <div class="setting-result">
                <c:forEach var="region" items="${regions}">
                    <span>${region}, </span>
                </c:forEach> 외 모든 지역의 결제를 차단하였습니다.
                <div>결제 허용 지역에서 차단하고 싶은 나만의 rule이 있다면 추가하세요</div>
            </div>
            <div class="info-content">결제를 차단할 시간을 선택하세요</div>
            <div class="setting-buttons">
                <span>차단시간선택</span>
                <button class="select-no" id="time-no" onclick="noSelect()">선택안함</button>
                <button class="select-thing" id="select-time" onclick="redirectToTimePage()">시간선택</button>
            </div>
            <div class="setting-result">
                <c:forEach var="region" items="${regions}">
                    <span>${region}, </span>
                </c:forEach>지역에서
                <c:forEach var="time" items="${times}">
                    <span>${time}, </span>
                </c:forEach> 시간의 결제를 차단하였습니다.
                <div>해당 조건에서 차단하고 싶은 나만의 rule이 있다면 추가하세요</div>
            </div>
            <div class="info-content">결제를 차단할 업종을 선택하세요</div>
            <div class="setting-buttons">
                <span>차단업종선택</span>
                <button class="select-no" id="category-no" onclick="noSelect()">선택안함</button>
                <button class="select-thing" id="select-category" onclick="redirectToCategoryPage()">
                    업종선택
                </button>
            </div>
            <div class="setting-result">
                <c:forEach var="region" items="${regions}">
                    <span>${region}, </span>
                </c:forEach>지역에서
                <c:forEach var="time" items="${times}">
                    <span>${time}, </span>
                </c:forEach> 시간에
                <c:forEach var="categorySmall" items="${categorySmalls}">
                    <span>${categorySmall}, </span>
                </c:forEach>업종을 차단하였습니다.
            </div>
            <div class="gogoring">내용</div>
            <div class="setting-result">
                <c:if test="${not empty regions}">
                    <c:forEach var="region" items="${regions}">
                        <span>${region}, </span>
                    </c:forEach>
                    지역에
                </c:if>

                <c:if test="${not empty times}">
                    <c:forEach var="time" items="${times}">
                        <span>${time}, </span>
                    </c:forEach>
                    시간에
                </c:if>

                <c:if test="${not empty categorySmalls}">
                    <c:forEach var="categorySmall" items="${categorySmalls}">
                        <span>${categorySmall}, </span>
                    </c:forEach>
                    업종을
                </c:if>

                차단하였습니다.
            </div>
        </div>
    </div>
    <button class="reg-Btn" onclick="sendSettingsToController()"> 등록</button>
</div>
</body>
<script>

    var regions = [];
    <c:forEach var="region" items="${regions}">
    regions.push('${region}');
    </c:forEach>

    var times = [];
    <c:forEach var="time" items="${times}">
    times.push('${time}');
    </c:forEach>

    function redirectToTimePage() {
        var url = "/safetyCard/time?region=" + regions.join('&region=');
        window.location.href = url;
    }

    function redirectToCategoryPage() {
        var regionQueryString = regions.map(region => "region=" + region).join('&');
        var timeQueryString = times.map(time => "time=" + time).join('&');

        var url = "/safetyCard/category?" + regionQueryString;
        if (times.length > 0) {
            url += "&" + timeQueryString;
        }

        window.location.href = url;
    }




    function collectSettings() {

        let settingsMap = {};

        const safetyStartDate = document.getElementById('fromDate').value;
        const safetyEndDate = document.getElementById('toDate').value;
        settingsMap['safetyStartDate'] = safetyStartDate;
        settingsMap['safetyEndDate'] = safetyEndDate;
        settingsMap['cardId'] = '<%= session.getAttribute("cardId") %>';

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
        console.log("settings", settings);

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

</script>

</html>