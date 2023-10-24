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
    <link href="../../../resources/css/member/safetySettingNew.css" rel="stylesheet">
    <link href="../../../resources/css/member/fdsCardSelect.css" rel="stylesheet">
    <link href="../../../resources/css/member/modalStyle.css" rel="stylesheet">
    <script src="../../../resources/js/userOuath.js" type="text/javascript"></script>


</head>
<body>
<%@ include file="../include/header.jsp" %>
<div class="setting-container">
    <div class="content-div">
        <div class="content-header">
            <h2>안심서비스 설정</h2>
            <h3>거래를 허용하거나 차단할 항목을 설정해주세요</h3>
        </div>
        <div class="lostcard-list">
            <div class="card-list-info">
                <img class="card-img" src="../../../resources/img/<%=session.getAttribute("cardName")%>.png">
                <div class="card-list-info-cardid">${fn:substring(sessionScope.cardId, 0, 4)}-****-****-${fn:substring(sessionScope.cardId, 15,19)}

                </div>
                <div class="card-list-info-name">본인 | &nbsp;
                </div>
                <div class="card-list-info-cardname"><%=session.getAttribute("cardName")%>
                </div>

            </div>
        </div>
        <div class="setting-options">
            <c:if test="${empty regions && empty categorySmalls && empty times}">
                <div id="result-info-div" class="setting-result-info"><img src="../../../resources/img/right-arrow.png">거래를&nbsp;<span style="color: green">허용</span>할 지역을 선택하세요.
                </div>
            </c:if>
            <div class="setting-buttons">
                <div class="step-div">STEP1</div>
                <div class="select-header"><span style="color: green">허용</span>지역</div>
                <div class="select-content">
                    <div class="select-button">
                        <c:if test="${not empty regions}">
                            <c:forEach var="region" items="${regions}" varStatus="loop">
                                <span><strong>${region}</strong></span>
                                <c:if test="${loop.index+1 < fn:length(regions)}">
                                    <span>,&nbsp;</span>
                                </c:if>
                            </c:forEach>
                        </c:if>
                        <c:if test="${empty regions}">
                            <button class="select-no" id="region-no" onclick="noSelect(this); nextStep();">선택안함</button>
                            <button class="select-thing" id="select-region" onclick="window.location.href='/safetyCard/region'">지역선택</button>
                        </c:if>
                    </div>

                </div>
            </div>

            <c:if test="${not empty regions && empty categorySmalls && empty times}">
                <div class="setting-region-no-info"><img src="../../../resources/img/right-arrow.png">허용지역 내에서&nbsp;<span style="color:red;">차단</span>할 시간을 선택하세요.</div>
            </c:if>
            <c:if test="${empty regions && empty categorySmalls && empty times}">
                <div class="setting-region-no-info hidden"><img src="../../../resources/img/right-arrow.png"><span style="color:red;">차단</span>할 시간을 선택하세요.</div>
            </c:if>
            <div class="setting-buttons">

                <div class="step-div">STEP2</div>
                <div class="select-header"><span style="color:red;">차단</span>시간</div>
                <div class="select-content">
                    <div class="select-button">
                        <c:if test="${not empty times}">
                            <c:forEach var="time" items="${times}" varStatus="loop">
                                <span><strong>${time}</strong></span>
                                <c:if test="${loop.index+1 < fn:length(times)}">
                                    <span>,</span>
                                </c:if>
                            </c:forEach>
                        </c:if>
                        <c:if test="${empty times}">
                            <button class="select-no" id="time-no" onclick="noSelect(this); nextcategoryStep();">선택안함</button>
                            <button class="select-thing" id="select-time" onclick="redirectToTimePage()">시간선택</button>
                        </c:if>
                    </div>
                </div>

            </div>
            <c:if test="${not empty times && empty categorySmalls}">
                <script>
                    document.getElementById('select-time').style.background = "#404b57";
                    document.getElementById('select-time').style.color = "white";
                </script>
                <div class="setting-result-time">
                    <c:if test="${not empty regions}">

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
                            document.getElementById('region-no').style.background = "#404b57";
                            document.getElementById('region-no').style.color = "white";
                        </script>
                    </c:if>
                    <c:forEach var="time" items="${times}" varStatus="loop">
                        <span><strong>${time}</strong></span>
                        <c:if test="${loop.index+1 < fn:length(times)}">
                            <span><strong>,</strong></span>
                        </c:if>
                    </c:forEach>까지 거래를 &nbsp;<strong><span style="color:red;">차단</span></strong>하였습니다.
                </div>
            </c:if>
            <c:if test="${not empty times && empty categorySmalls}">
                <div id="category-info-div" class="setting-category-info"><img src="../../../resources/img/right-arrow.png">차단 Rule에서&nbsp;<span style="color:red;">차단</span>할 업종을 선택하세요</div>
            </c:if>
            <div class="setting-categoryselect-info hidden"><img src="../../../resources/img/right-arrow.png"><span style="color: green">허용</span>지역 내에서&nbsp;<span style="color:red;">차단</span>할 업종을 선택하세요</div>
            <div class="setting-buttons">

                <div class="step-div">STEP3</div>
                <div class="select-header"><span style="color:red;">차단</span>업종</div>
                <div class="select-content">
                    <div class="select-button">
                        <c:if test="${not empty categorySmalls}">
                            <c:forEach var="categorySmall" items="${categorySmalls}" varStatus="loop">
                                <span><strong>${categorySmall}</strong></span>
                                <c:if test="${loop.index+1 < fn:length(categorySmalls)}">
                                    <span>,&nbsp;</span>
                                </c:if>
                            </c:forEach>
                        </c:if>
                        <c:if test="${empty categorySmalls}">
                            <button class="select-no" id="category-no" onclick="noSelect(this); finishStep();">선택안함</button>
                            <button class="select-thing" id="select-category" onclick="redirectToCategoryPage()">업종선택</button>
                        </c:if>
                    </div>


                </div>
            </div>


        </div>
        <div class="myRule-confirm"><strong>안심서비스 설정내역</strong></div>
        <hr>
        <c:if test="${not empty regions}">

            <div class="setting-result-ok">
                <c:forEach var="region" items="${regions}" varStatus="loop">
                    <span><strong>${region}</strong></span>
                    <c:if test="${loop.index+1 < fn:length(regions)}">
                        <span>,</span>
                    </c:if>
                </c:forEach> 지역의 거래만 <strong><span style="color: green">허용</span></strong>합니다.
            </div>

        </c:if>
        <div class="setting-result hidden"></div>
        <c:if test="${not empty categorySmalls}">
            <div class="setting-result-category">

                <c:choose>
                    <c:when test="${not empty regions && not empty times}">

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
                            document.getElementById('region-no').style.background = "#404b57";
                            document.getElementById('region-no').style.color = "white";
                            document.getElementById('select-time').style.background = "#404b57";
                            document.getElementById('select-time').style.color = "white";
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

                            document.getElementById('time-no').style.background = "#404b57";
                            document.getElementById('time-no').style.color = "white";
                        </script>
                        <c:forEach var="region" items="${regions}" varStatus="loop">
                            <span><strong>${region}</strong></span>
                            <c:if test="${loop.index+1 < fn:length(regions)}">
                                <span><strong>,</strong></span>
                            </c:if>
                        </c:forEach> 에서
                    </c:when>
                    <c:when test="${not empty regions && empty times && not empty categorySmalls}">
                        <script>

                            document.getElementById('time-no').style.background = "#404b57";
                            document.getElementById('time-no').style.color = "white";
                        </script>
                    </c:when>
                    <c:otherwise>
                        <script>
                            document.getElementById('region-no').style.background = "#404b57";
                            document.getElementById('region-no').style.color = "white";
                            document.getElementById('time-no').style.background = "#404b57";
                            document.getElementById('time-no').style.color = "white";
                        </script>
                    </c:otherwise>
                </c:choose>
                <c:forEach var="categorySmall" items="${categorySmalls}" varStatus="loop">
                    <span><strong>${categorySmall}</strong></span>
                    <c:if test="${loop.index+1 < fn:length(categorySmalls)}">
                        <span><strong>,</strong></span>
                    </c:if>
                </c:forEach>업종의 거래를 &nbsp;<strong><span style="color:red;">차단</span></strong>하였습니다.
            </div>
        </c:if>
    </div>

    <div class="btn-div" style="margin-top:40px; margin-bottom:40px;">
        <button class="prev-Btn" onclick="reset()">취소</button>
        <button class="next-Btn" onclick="modalCheck()">등록</button>
    </div>
</div>

<div id="myModal" class="modal">
    <div class="modal-content">
        <span class="close-btn" onclick="closeModal()">&#10006;</span>
        <div class="modal-header">안심서비스 설정 확인</div>
        <div class="ok-div"><span class="text-confirm"> 카드 번호 : </span><span><%=session.getAttribute("cardId")%></span></div>
        <div class="setting-result-modal"></div>
        <div class="ok-div"><span class="text-confirm"> 허용 지역 : </span><span class="ok"></span></div>
        <div class="ok-div"><span class="text-confirm"> 차단 조합 : </span><span class="no"></span></div>
        <div class="btn-div">
            <button class="confirm-btn"  onclick="agreePhone()">확인</button>
        </div>
    </div>

</div>
<div id="authModal" class="modal">
    <div class="auth-container">
        <span class="close-btn">&times;</span>
        <div class="auth-header">본인인증</div>
        <div class="auth-content">
            <div class="content-row">
                <div class="content-div-header" style="margin: auto 0;">이름</div>
                <div class="content-div-input"><input type="text" placeholder="이름"></div>
            </div>

            <div class="content-row">
                <div class="content-div-header" style="margin-top: 10px;">휴대전화</div>
                <div class="content-div-phone">

                    <div class="phone-div">
                        <div class="company-select">
                            <select>
                                <option value="skt" selected>SKT</option>
                                <option value="lg">LG</option>
                                <option value="kt">KT</option>
                            </select>
                        </div>
                        <div class="phone-select">
                            <select>
                                <option value="010" selected>010</option>
                                <option value="070">070</option>
                                <option value="012">012</option>
                                <option value="031">031</option>
                            </select>
                        </div>
                        <div class="number"><input type="text" id="phoneNumber" placeholder="'-' 제외하고 입력"></div>
                        <div class="btn-div-safety">
                            <button class="send-authNumber" onclick="sendSmsRequest()">인증번호 받기</button>
                        </div>
                    </div>
                    <div class="auth-number-input"><input type="text" id="userOuathNum"
                                                          placeholder="인증번호 숫자만 6자리 입력">
                    </div>
                </div>
            </div>
        </div>
        <button onclick="verifySmsSafetyCode()" class="auth-confirm">확인</button>
    </div>
    <div id="result"></div>
</div>
</body>
<script>

    function verifySmsSafetyCode() {
        const smsConfirmNum = document.getElementById('userOuathNum').value;

        const resultDiv = document.getElementById('result');

        $.ajax({
            url: '/sms/verify',
            type: 'POST',
            contentType: 'application/json',
            data: JSON.stringify({smsConfirmNum: smsConfirmNum}),
            success: function (data) {
                console.log('서버 응답:', data);
                if (data === '본인인증성공') {
                    safetySettingOk();
                } else {
                    resultDiv.textContent = '본인인증실패';
                }
            },
            error: function () {
                console.error("본인인증인증과정에러");
            }
        });

    }

    function agreePhone() {

        let modal = document.getElementById('authModal');
        modal.style.display = 'block';
    }

    window.onclick = function (event) {
        let modal = document.getElementById('authModal');
        if (event.target == modal || event.target == document.querySelector('.close-btn')) {
            modal.style.display = 'none';
        }
    }


    function reset() {
        window.location.href = "/safetyCard/safetySettingValue";
    }

    function nextStep(){
        var regionNoInfoDiv = document.querySelector(".setting-region-no-info");
        if (regionNoInfoDiv) {
            regionNoInfoDiv.classList.remove("hidden");
        }

        var resultInfoDiv = document.getElementById("result-info-div");
        if (resultInfoDiv) {
            resultInfoDiv.style.display = "none";
        }
    }

    function nextcategoryStep(){
        var regionNoInfoDiv = document.querySelector(".setting-region-no-info");
        if (regionNoInfoDiv) {
            regionNoInfoDiv.style.display="none";
        }
        var element = document.querySelector('.setting-categoryselect-info');
        if (element) {
            element.classList.remove('hidden');
        }
    }

    function finishStep(){

        var timeElements = document.querySelectorAll('.setting-result-time');

        console.log(timeElements);


        if (timeElements.length > 0) {
            console.log("if")

            timeElements.forEach(function(timeElement) {

                var content = timeElement.innerHTML;
                console.log(content);

                var settingResultElement = document.querySelector('.setting-result');

                settingResultElement.innerHTML = content;

                settingResultElement.classList.remove('hidden');

                timeElement.classList.add('hidden');
            });
        }




        var categoryInfoDiv = document.getElementById("category-info-div");
        if (categoryInfoDiv) {
            categoryInfoDiv.style.display = "none";
        }
    }



    function noSelect(buttonElement) {

        if (buttonElement.style.background === '#404b57') {
            buttonElement.style.background = '';
            buttonElement.style.color = "black";
        } else {
            buttonElement.style.background = '#404b57';
            buttonElement.style.color = "white";
        }
    }


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
            if (regions.length > 0) {
                url += '&';
            }

            var timeQueryString = times.map(time => "time=" + time).join('&');
            url += timeQueryString;
        }

        window.location.href = url;
    }


    var modal = document.getElementById("myModal");

    var span = document.getElementsByClassName("close-btn")[0];

    function modalCheck() {

        var settingResultsOk = document.querySelector(".setting-result-ok");
        var settingResultsCategory = document.querySelectorAll(".setting-result-category");
        var settingResults = document.querySelectorAll(".setting-result");


        var modalContent = document.querySelector(".setting-result-modal");
        var modalok = document.querySelector(".ok");
        var modalno = document.querySelector(".no");
        modalContent.innerHTML = "";

        if (settingResultsOk) {
            modalContent.innerHTML += settingResultsOk.innerHTML;
            modalContent.innerHTML += "<br>";
            modalok.innerHTML+=settingResultsOk.innerHTML;
        }

        settingResultsCategory.forEach(function (settingResult) {
            modalContent.innerHTML += settingResult.innerHTML;
            modalContent.innerHTML += "<br>";
            modalno.innerHTML+=settingResult.innerHTML;
        });

        if (settingResults.length > 0) {
            settingResults.forEach(function (settingResult) {
                modalContent.innerHTML += settingResult.innerHTML;
                modalContent.innerHTML += "<br>";
                modalno.innerHTML+=settingResult.innerHTML;
            });
        }

        modal.style.display = "block";
    }


    span.onclick = function () {
        modal.style.display = "none";
    }

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

        var safetyInfo2 = document.querySelector(".ok").innerText;
        var safetyInfo3 = document.querySelector(".no").innerText;


        var safetyInfo =safetyInfo2 + safetyInfo3;


        return {
            settingsList: settingsList,
            safetyStringInfo: safetyInfo
        };
    }


    function safetySettingOk() {
        console.log("satetySetting");
        const settings = collectSettings();
        console.log("safetyStringInfo", settings.safetyStringInfo);
        $.ajax({
            url: '/safetyCard/insertSetting',
            type: 'POST',
            contentType: 'application/json',
            data: JSON.stringify(settings),
            dataType: 'text',
            success: function (response) {

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
        let categoryButtons = document.querySelectorAll('#category-no,#select-category');
        categoryButtons.forEach(function (button) {
            button.addEventListener('click', function () {
                categoryButtons.forEach(function (btn) {
                    btn.classList.remove('active-button');
                });
                this.classList.add('active-button');
            });
        });

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