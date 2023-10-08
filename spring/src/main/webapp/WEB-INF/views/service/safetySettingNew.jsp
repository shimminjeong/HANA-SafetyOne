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
    <%--    <link href="../../../resources/css/safetyCardCommon.css" rel="stylesheet">--%>
    <link href="../../../resources/css/safetySettingNew.css" rel="stylesheet">
    <link href="../../../resources/css/fdsCardSelect.css" rel="stylesheet">


</head>
<body>
<%@ include file="../include/header.jsp" %>
<div class="setting-container">
    <div class="content-div">
        <div class="content-header">
            <h2>안심 서비스 설정</h2>
            <h3>거래를 허용하거나 차단할 항목을 설정해주세요</h3>
        </div>
        <%--        <div style="margin-bottom: 10px; color: red;">※ 거래 지정하여 금융사고를 예방하는 서비스입니다.</div>--%>

        <div class="lostcard-list">
            <div class="card-list-info">
                <img class="card-img" src="../../../resources/img/<%=session.getAttribute("cardName")%>.png">
                <div class="card-list-info-cardid"><%=session.getAttribute("cardId")%>
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
                <%--                <span class="img-div"><img src="../../../resources/img/steps_2192581%201.png"></span>--%>
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


            <div class="setting-region-no-info hidden"><img src="../../../resources/img/right-arrow.png"><span style="color:red;">차단</span>하고 싶은 시간이 있다면 선택해주세요</div>
            <div class="setting-buttons">
                <%--                <span class="img-div"><img src="../../../resources/img/steps_2192581%202.png"></span>--%>
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
                            <button class="select-no" id="time-no" onclick="noSelect(this)">선택안함</button>
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
                        <script>
                            document.getElementById('select-region').style.background = "#404b57";
                            document.getElementById('select-region').style.color = "white";
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
                <div id="category-info-div" class="setting-category-info"><img src="../../../resources/img/right-arrow.png">나만의 Rule에&nbsp; <span style="color:red;">차단</span>하고 싶은 업종이 있다면 추가하세요</div>
            </c:if>
            <div class="setting-buttons">
                <%--                <span class="img-div"><img src="../../../resources/img/steps_2192581%203.png"></span>--%>
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
            <c:if test="${not empty regions}">
                <script>
                    document.getElementById('select-region').style.background = "#404b57";
                    document.getElementById('select-region').style.color = "white";
                </script>
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
                <script>document.getElementById('select-category').style.background = "#404b57";</script>
                <div class="setting-result-category">
                    <script>
                        document.getElementById('select-category').style.color = "white";
                    </script>
                    <c:choose>
                        <c:when test="${not empty regions && not empty times}">
                            <script>
                                document.getElementById('select-region').style.background = "#404b57";
                                document.getElementById('select-region').style.color = "white";
                                document.getElementById('select-time').style.background = "#404b57";
                                document.getElementById('select-time').style.color = "white";
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
                                document.getElementById('select-region').style.background = "#404b57";
                                document.getElementById('select-region').style.color = "white";
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
    </div>
    <div class="btn-div">
        <button class="prev-Btn" onclick="reset()">취소</button>
        <button class="next-Btn" onclick="modalCheck()">등록</button>
    </div>
</div>
<!-- The Modal -->
<%--<div id="myModal" class="modal">--%>
<%--    <!-- Modal content -->--%>
<%--    <div class="modal-content">--%>
<%--        <span class="close">&times;</span>--%>
<%--        <p>대상카드 : <%=session.getAttribute("cardId")%>--%>
<%--        </p>--%>
<%--        <div class="setting-result-modal">--%>
<%--        </div>--%>
<%--        <button class="modal-btn" onclick="safetySettingOk()"> 확인</button>--%>
<%--    </div>--%>
<%--</div>--%>
<div id="myModal" class="modal">
    <div class="modal-content">
        <span class="close-btn" onclick="closeModal()">&#10006;</span>
        <div class="modal-header">나만의 Rule 확인</div>
        <div class="ok-div"><span class="text"> 카드 번호 : </span><span><%=session.getAttribute("cardId")%></span></div>
        <div class="setting-result-modal"></div>
        <div class="ok-div"><span class="text"> 허용 지역 : </span><span class="ok"></span></div>
        <div class="ok-div"><span class="text"> 차단 조합 : </span><span class="no"></span></div>
        <div class="btn-div" style="">
            <button class="confirm-btn" onclick="safetySettingOk()">확인</button>
        </div>
    </div>
    <%--        <button onclick="closeModal()">취소</button>--%>
</div>

</body>
<script>

    function reset() {
        window.location.href = "/safetyCard/safetySettingValue";
    }

    function nextStep(){
        var regionNoInfoDiv = document.querySelector(".setting-region-no-info");
        if (regionNoInfoDiv) { // div가 있을 때만 클래스를 제거
            regionNoInfoDiv.classList.remove("hidden");
        }

        var resultInfoDiv = document.getElementById("result-info-div");
        if (resultInfoDiv) { // div가 있을 때만 숨김 처리
            resultInfoDiv.style.display = "none";
        }
    }

    function finishStep(){

        var timeElements = document.querySelectorAll('.setting-result-time');

        console.log(timeElements);

// .setting-result-time 요소가 존재하는지 확인합니다.
        if (timeElements.length > 0) {
            console.log("if")
            // .setting-result-time 요소가 있는 경우에만 처리합니다.
            timeElements.forEach(function(timeElement) {
                console.log("if")
                // .setting-result-time 요소 내의 내용을 가져옵니다.
                var content = timeElement.innerHTML;
                console.log(content);

                // .setting-result 요소를 선택합니다.
                var settingResultElement = document.querySelector('.setting-result');

                // .setting-result 요소에 content를 넣습니다.
                settingResultElement.innerHTML = content;

                // .setting-result 요소의 hidden 클래스를 제거합니다.
                settingResultElement.classList.remove('hidden');

                timeElement.classList.add('hidden');
            });
        }




        var categoryInfoDiv = document.getElementById("category-info-div");
        if (categoryInfoDiv) { // div가 있을 때만 숨김 처리
            categoryInfoDiv.style.display = "none";
        }
    }



    function noSelect(buttonElement) {
        // var settingResultInfo = document.querySelector(".setting-time-info");
        // settingResultInfo.style.display = "none";
        if (buttonElement.style.background === '#404b57') {
            buttonElement.style.background = '';  // 원래의 배경색으로 변경
            buttonElement.style.color = "black";
        } else {
            buttonElement.style.background = '#404b57';
            buttonElement.style.color = "white";
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
    var span = document.getElementsByClassName("close-btn")[0];

    // This function will be triggered when the button is clicked
    function modalCheck() {
        // Get all elements with class "setting-result"
        var settingResultsOk = document.querySelector(".setting-result-ok");
        var settingResultsCategory = document.querySelectorAll(".setting-result-category");
        var settingResults = document.querySelectorAll(".setting-result");

        // Assuming you have only one .setting-result-modal, so using querySelector
        var modalContent = document.querySelector(".setting-result-modal");
        var modalok = document.querySelector(".ok");
        var modalno = document.querySelector(".no");
        modalContent.innerHTML = "";  // Clearing any existing content in modalContent

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

        // var safetyInfo1 = document.querySelector(".setting-result-modal").innerText;
        var safetyInfo2 = document.querySelector(".ok").innerText;
        var safetyInfo3 = document.querySelector(".no").innerText;

        // console.log("collectSettingssafetyInfo",safetyInfo1)
        console.log("collectSettingssafetyInfo",safetyInfo2)
        console.log("collectSettingssafetyInfo",safetyInfo3)

        var safetyInfo =safetyInfo2 + safetyInfo3;
        console.log("safesssssssssssssstyInfo",safetyInfo)

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