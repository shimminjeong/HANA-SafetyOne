<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/chart.js@3.5.1/dist/chart.min.js"></script>
    <link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
    <link href="../../../resources/css/safetyCardCommon.css" rel="stylesheet">
    <link href="../../../resources/css/safetySettingNew.css" rel="stylesheet">


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
            <div class="info-header">결제를 차단할 지역, 시간, 업종 등 나만의 rule을 설정해보세요</div>
            <div class="setting-buttons">
                <span>STEP1</span>
                <span>허용지역선택</span>
                <button class="select-no" id="region-no" onclick="noSelect(this)">선택안함</button>
                <button class="select-thing" id="select-region" onclick="window.location.href='/safetyCard/region'">
                    지역선택
                </button>
            </div>
            <c:if test="${not empty regions}">
                <script>
                    document.getElementById('select-region').style.background = "#dddd";
                </script>
                <div class="setting-result">
                    <c:forEach var="region" items="${regions}" varStatus="loop">
                        <span><strong>${region}</strong></span>
                        <c:if test="${loop.index+1 < fn:length(regions)}">
                            <span><strong>,</strong></span>
                        </c:if>
                    </c:forEach> 외 <strong>모든 지역</strong>의 결제를 차단하였습니다.
                </div>
                <div class="setting-result-info">결제 허용 지역내에서 차단하고 싶은 나만의 rule이 있다면 추가하세요</div>
            </c:if>
            <div class="setting-buttons">
                <span>STEP2</span>
                <span>차단시간선택</span>
                <button class="select-no" id="time-no" onclick="noSelect(this)">선택안함</button>
                <button class="select-thing" id="select-time" onclick="redirectToTimePage()">시간선택</button>
            </div>

            <c:if test="${not empty times && empty categorySmalls}">
                <script>
                    document.getElementById('select-time').style.background = "#dddd";
                </script>
                <div class="setting-result">
                    <c:if test="${not empty regions}">
                        <script>
                            document.getElementById('select-region').style.background = "#dddd";
                        </script>
                        <c:forEach var="region" items="${regions}" varStatus="loop">
                            <span><strong>${region}</strong></span>
                            <c:if test="${loop.index+1 < fn:length(regions)}">
                                <span><strong>,</strong></span>
                            </c:if>
                        </c:forEach> 에서
                    </c:if>
                    <c:if test="${empty regions}">
                        <strong>모든 지역</strong>에서
                        <script>
                            document.getElementById('region-no').style.background = "#dddd";
                        </script>
                    </c:if>
                    <c:forEach var="time" items="${times}" varStatus="loop">
                        <span><strong>${time}</strong></span>
                        <c:if test="${loop.index+1 < fn:length(times)}">
                            <span><strong>,</strong></span>
                        </c:if>
                    </c:forEach>까지 결제를 차단하였습니다.
                </div>
            </c:if>
            <div class="setting-buttons">
                <span>STEP3</span>
                <span>차단업종선택</span>
                <button class="select-no" id="category-no" onclick="noSelect(this)">선택안함</button>
                <button class="select-thing" id="select-category" onclick="redirectToCategoryPage()">
                    업종선택
                </button>
            </div>
            <c:if test="${not empty categorySmalls}">
                <script>document.getElementById('select-category').style.background = "#dddd";</script>
                <div class="setting-result">
                    <c:choose>
                        <c:when test="${not empty regions && not empty times}">
                            <script>
                                document.getElementById('select-region').style.background = "#dddd";
                                document.getElementById('select-time').style.background = "#dddd";
                            </script>
                            <c:forEach var="region" items="${regions}" varStatus="loop">
                                <span><strong>${region}</strong></span>
                                <c:if test="${loop.index+1 < fn:length(regions)}">
                                    <span><strong>,</strong></span>
                                </c:if>
                            </c:forEach> 에서
                            <c:forEach var="time" items="${times}" varStatus="loop">
                                <span><strong>${time}</strong></span>
                                <c:if test="${loop.index+1 < fn:length(times)}">
                                    <span><strong>,</strong></span>
                                </c:if>
                            </c:forEach> 까지
                        </c:when>
                        <c:when test="${empty regions && not empty times}">
                            <script>
                                document.getElementById('region-no').style.background = "#dddd";
                                document.getElementById('select-time').style.background = "#dddd";
                            </script>
                            <strong>모든 지역</strong>에서
                            <c:forEach var="time" items="${times}" varStatus="loop">
                                <span><strong>${time}</strong></span>
                                <c:if test="${loop.index+1 < fn:length(times)}">
                                    <span><strong>,</strong></span>
                                </c:if>
                            </c:forEach> 까지
                        </c:when>
                        <c:when test="${not empty regions && empty times}">
                            <script>
                                document.getElementById('select-region').style.background = "#dddd";
                                document.getElementById('time-no').style.background = "#dddd";
                            </script>
                            <c:forEach var="region" items="${regions}" varStatus="loop">
                                <span><strong>${region}</strong></span>
                                <c:if test="${loop.index+1 < fn:length(regions)}">
                                    <span><strong>,</strong></span>
                                </c:if>
                            </c:forEach> 에서
                        </c:when>
                        <c:otherwise>
                            <script>
                                document.getElementById('region-no').style.background = "#dddd";
                                document.getElementById('time-no').style.background = "#dddd";
                            </script>
                        </c:otherwise>
                    </c:choose>
                    <c:forEach var="categorySmall" items="${categorySmalls}" varStatus="loop">
                        <span><strong>${categorySmall}</strong></span>
                        <c:if test="${loop.index+1 < fn:length(categorySmalls)}">
                            <span><strong>,</strong></span>
                        </c:if>
                    </c:forEach>업종의 결제를 차단하였습니다.
                </div>
            </c:if>
        </div>
    </div>
    <button class="reg-Btn" onclick="modalCheck()"> 등록</button>
</div>
<!-- The Modal -->
<div id="myModal" class="modal">
    <!-- Modal content -->
    <div class="modal-content">
        <span class="close">&times;</span>
        <p>대상카드 : <%=session.getAttribute("cardId")%>
        </p>
        <div class="setting-result-modal"></div>
        <button class="modal-btn" onclick="safetySettingOk()"> 확인</button>
    </div>
</div>

</body>
<script>
    function noSelect(buttonElement) {
        if (buttonElement.style.background === '#dddd') {
            buttonElement.style.background = '';  // 원래의 배경색으로 변경
        } else {
            buttonElement.style.background = '#dddd';
        }
    }

    // 각 jsp에서 설정한 값들 넘겨받기
    var regions = [];
    <c:forEach var="region" items="${regions}">
    regions.push('${region}');
    </c:forEach>

    var times = [];
    <c:forEach var="time" items="${times}">
    times.push('${time}');
    </c:forEach>

    var categorySmalls = [];
    <c:forEach var="categorySmall" items="${categorySmalls}">
    categorySmalls.push('${categorySmall}');
    </c:forEach>

    function redirectToTimePage() {
        var url = "/safetyCard/time";
        if (regions.length > 0) {
            url += "?region=" + regions.join('&region=');
        }
        window.location.href = url;
    }

    function redirectToCategoryPage() {
        var url = "/safetyCard/category?";

        if (regions.length > 0) {
            var regionQueryString = regions.map(region => "region=" + region).join('&');
            url += regionQueryString;
        }

        if (times.length > 0) {
            // regions의 데이터가 있을 경우에만 &를 추가
            if (regions.length > 0) {
                url += '&';
            }

            var timeQueryString = times.map(time => "time=" + time).join('&');
            url += timeQueryString;
        }

        window.location.href = url;
    }


    // 확인모달
    // Get the modal
    var modal = document.getElementById("myModal");

    // Get the <span> element that closes the modal
    var span = document.getElementsByClassName("close")[0];

    // This function will be triggered when the button is clicked
    function modalCheck() {
        // Get all elements with class "setting-result"
        var settingResults = document.querySelectorAll(".setting-result");

        // Assuming you have only one .setting-result-modal, so using querySelector
        var modalContent = document.querySelector(".setting-result-modal");
        modalContent.innerHTML = "";  // Clearing any existing content in modalContent

        settingResults.forEach(function (settingResult) {
            modalContent.innerHTML += settingResult.innerHTML;
            modalContent.innerHTML += "<br>";

        });

        // Display the modal
        modal.style.display = "block";
    }


    // When the user clicks on <span> (x), close the modal
    span.onclick = function () {
        modal.style.display = "none";
    }

    // When the user clicks anywhere outside of the modal, close it
    window.onclick = function (event) {
        if (event.target == modal) {
            modal.style.display = "none";
        }
    }


    function collectSettings() {
        let settingsList = [];

        settingsList.push(regions);
        settingsList.push(times);
        settingsList.push(categorySmalls);

        return settingsList;
    }

    function safetySettingOk() {
        console.log("satetySetting");
        const settings = collectSettings();
        console.log("settingList", settings);
        $.ajax({
            url: '/safetyCard/insertSetting',
            type: 'POST',
            contentType: 'application/json',
            data: JSON.stringify(settings),
            dataType: 'text',
            success: function (response) {
                console.log(response);
                console.log("sss");
                if (response === "insert성공") {
                    location.href = "/safetyCard/safetySettingOk";
                } else {
                    console.error('insert실패');
                }
            },
            error: function (error) {
                console.error('Error:', error);
            }
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