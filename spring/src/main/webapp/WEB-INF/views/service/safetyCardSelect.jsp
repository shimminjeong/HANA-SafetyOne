<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
    <title>Title</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <link href="../../../resources/css/common.css" rel="stylesheet">
    <link href="../../../resources/css/service.css" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
</head>
<style>

    input[type="checkbox"] {
        -webkit-appearance: none;
        appearance: none;
        width: 22px;
        height: 22px;
        background-safetyCardSelect: white;
        border: 2px solid #ccc;
        border-radius: 3px;
        cursor: pointer;
    }

    input[type="checkbox"]:checked {
        background-color: #00857F;
        border: 2px solid #00857F;
    }

    .reg-cancle-btn {
        display: flex;
        flex-direction: row;
        justify-content: center;
        margin-top: 30px;
    }

    .reg-Btn, .cancle-Btn {
        color: white;
        border: none;
        padding: 12px 40px 12px 40px;
        border-radius: 5px;
        cursor: pointer;
        text-decoration: none;
        background-color: #00857F;
        font-size: 16px;
        transition: background-color 0.3s;
        display: block; /* 버튼을 블록 레벨로 설정하여 가운데 정렬을 위한 설정 */
    }

    .reg-Btn {
        margin-left: 40px;
    }

    .card-img {
        width: 90px;
    }

    .lock-img {
        width: 40px;
    }

    .ajax-content {
        font-size: 14px;
        display: flex;
        justify-content: center
    }

    .formsize {
        width: 80%;
        margin: 20px auto;
        display: flex;
        flex-direction: column;
        justify-content: center;
        color: black; /* 글자색 변경 */
        padding: 30px 80px; /* 패딩 */
        text-decoration: none;
        font-size: 12px; /* 폰트 크기 변경 */
        cursor: pointer;
    }

    .modal {
        display: none;
        position: fixed;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        background-color: rgba(0, 0, 0, 0.5);
        display: flex;
        justify-content: center;
        align-items: center;
    }

    .close-button {
        position: absolute;
        top: 10px;
        right: 10px;
        font-size: 25px;
        cursor: pointer;
        border: none;
        background-color: #f8f8f8;
    }

    .modal-content {
        background-color: #f8f8f8; /* Slightly off-white for a softer appearance */
        width: 450px;
        height: 400px;
        padding: 20px;
        position: absolute;
        top: 50%;
        left: 50%;
        transform: translate(-50%, -50%);
        text-align: center;
        box-shadow: 0 5px 15px rgba(0, 0, 0, 0.3); /* Box shadow for depth */
        border-radius: 8px; /* Rounded corners */
        font-size: 16px; /* Larger font size for readability */
        font-weight: 400; /* Regular font weight */
    }

    .modal-header {
        margin-top: 25px;
        font-size: 24px;
        margin-bottom: 10px;
    }

    .modal-message {
        font-size: 18px;
        margin: 30px;
        display: flex;
        flex-direction: column;
        align-items: center;
    }

    .modal-button {
        background-color: #007bff;
        color: white;
        border: none;
        padding: 10px 20px;
        border-radius: 5px;
        cursor: pointer;
    }

    .modal-grid {
        display: grid;
        grid-template-columns: 1fr 1fr 1fr;
        gap: 45px;
        margin: 10px;
    }

    .select-content img {
        margin-bottom: 20px;
    }

    .select-content {
        border: 1px solid #ccc; /* 그리드 간격 사이에 테두리 설정 */
        padding: 20px;
    }


    .spancon {
        margin-bottom: 30px;
        margin-top: 15px;
    }

    .select-content.selected {
        background-color: lightblue; /* 선택한 옵션의 배경색을 변경할 스타일 지정 */
    }


    .setting-btn {
        width: 80px;
        height: 40px;
        background-color: #3498db; /* Vivid blue */
        color: white; /* White text */
        margin: 30px;
        padding: 10px 15px; /* Padding for size */
        border: none; /* No border */
        border-radius: 5px; /* Rounded corners */
        font-size: 16px; /* Font size */
        font-weight: 600; /* Slightly bold font weight */
        cursor: pointer; /* Hand cursor on hover */
        transition: background-color 0.3s; /* Smooth background color transition */
    }

    .setting-btn:hover {
        background-color: #2980b9; /* Darker blue on hover */
    }

    .accordion {
        padding: 10px;
        display: flex;
        flex-direction: row;
        justify-content: space-between;
        align-items: center;
        font-size: 18px;
        border-radius: 8px; /* 상단의 둥근 모서리 지정 */
        background-color: #ffffff;
        transition: background-color 0.3s, transform 0.3s;
        box-shadow: 0 4px 6px rgba(0, 0, 0, 0.3);
        margin-top: 20px;

    }


    /* Style the accordion panel. Note: hidden by default */
    .panel {
        padding: 0 18px;
        background-color: #eeeeee;
        display: none;
        overflow: hidden;

    }

    .info-list {
        margin-top: 12px;
        margin-bottom: 12px;
        display: flex;
        flex-direction: row;
        font-size: 14px;
    }

    .info-header {
        width: 100px;
    }

    .ajax-content {
        margin-top: 30px;
    }

</style>

<body>
<%@ include file="../include/header.jsp" %>
<div class="container">
    <div class="formsize">
        <div class="content-div">
            <h1>안심카드설정</h1>
            <h2>안심카드서비스 이용현황</h2>
            <h3>설정할 카드를 선택 후 [등록] 또는 [해제]를 선택해주세요</h3></ㅗ4>
        </div>
        <div class="card-list">
            <c:forEach items="${cards}" var="card" varStatus="loop">
                <div class="accordion" id="${card.cardId}">
                    <div>
                        <input type="checkbox" name="selectedCards" value="${card.cardId}">
                    </div>
                    <div>본인 | ${card.cardId}</div>
                    <img class="card-img" src="../../../resources/img/cardImg${loop.index + 1}.png">
                    <c:if test="${card.selffdsSerStatus eq 'Y'}">
                        <img class="lock-img" src="../../../resources/img/padlock.png">
                    </c:if>
                    <c:if test="${card.selffdsSerStatus eq 'N'}">
                        <img class="lock-img" src="../../../resources/img/unlock.png">
                    </c:if>
                </div>
                <div class="panel">
                    <div id="cardInfo-${card.cardId}">
                        <!-- 서버로부터 받아온 정보가 이곳에 추가될 것입니다. -->
                    </div>
                </div>
            </c:forEach>
        </div>
        <div class="ajax-content"></div>
        <div class="reg-cancle-btn">
            <button class="cancle-Btn" onclick="cancleCard()">해제</button>
            <button class="reg-Btn" onclick="registerCard()">등록</button>
        </div>
    </div>
    <%--    <div id="selectModal" class="modal" style="display: none;">--%>
    <%--        <div class="modal-content">--%>
    <%--            <div class="modal-header">안심카드설정</div>--%>
    <%--            <div class="modal-message">--%>
    <%--                <span>안녕하세요</span>--%>
    <%--                <span class="spancon">차단할 항목을 선택하세요</span>--%>
    <%--                <div class="modal-grid">--%>
    <%--                    <button class="select-content" id="region">--%>
    <%--                        <img class="img-select" src="../../resources/img/location.png" height="60">--%>
    <%--                        <div>위치</div>--%>
    <%--                    </button>--%>
    <%--                    <button class="select-content" id="category">--%>
    <%--                        <img class="img-select" src="../../resources/img/optionslines.png" height="60">--%>
    <%--                        <div>업종</div>--%>
    <%--                    </button>--%>
    <%--                    <button class="select-content" id="time">--%>
    <%--                        <img class="img-select" src="../../resources/img/clock.png" height="60">--%>
    <%--                        <div>시간</div>--%>
    <%--                    </button>--%>
    <%--                </div>--%>
    <%--                <button class="setting-btn" onclick="selectSetting()">설정</button>--%>
    <%--            </div>--%>
    <%--            <button class="close-button" onclick="closeSelectModal()">&times;</button>--%>
    <%--        </div>--%>
    <%--    </div>--%>
</div>
</body>
<script>

    var acc = document.getElementsByClassName("accordion");
    var i;
    for (i = 0; i < acc.length; i++) {
        acc[i].addEventListener("click", function () {
            this.classList.toggle("active");
            var panel = this.nextElementSibling;
            if (panel.style.display === "block") {
                panel.style.display = "none";
            } else {
                panel.style.display = "block";
                var cardId = this.id; // 클릭한 accordion의 id를 가져옵니다.
                console.log("cardid", cardId);
                // 클릭한 accordion의 cardId를 서버에 전달하고 정보를 가져오는 Ajax 요청
                $.ajax({
                    url: "/safetyCard/selectSafetyInfo",
                    type: 'POST',
                    data: JSON.stringify({cardId: cardId}),
                    contentType: 'application/json',
                    success: function (data) {
                        console.log("data : " + data);
                        var cardInfoList = $("#cardInfo-" + cardId);
                        cardInfoList.empty();
                        cardInfoList.append("<h2>안심카드 맞춤설정 이용중입니다.</h2>");

                        // Create a mapping of enrollSeq to regions, times, and categories
                        let enrollMap = {};

                        data.forEach(function (item) {
                            if (!enrollMap[item.enrollSeq]) {
                                enrollMap[item.enrollSeq] = {
                                    cardId: item.cardId,
                                    safetyStartDate: item.safetyStartDate,
                                    safetyEndDate: item.safetyEndDate,
                                    regions: [],
                                    times: [],
                                    categories: []
                                };
                            }

                            if (item.regionName && !enrollMap[item.enrollSeq].regions.includes(item.regionName)) {
                                enrollMap[item.enrollSeq].regions.push(item.regionName);
                            }

                            let timeStr = item.startTime + " ~ " + item.endTime;
                            if (item.startTime && !enrollMap[item.enrollSeq].times.includes(timeStr)) {
                                enrollMap[item.enrollSeq].times.push(timeStr);
                            }

                            if (item.categorySmall && !enrollMap[item.enrollSeq].categories.includes(item.categorySmall)) {
                                enrollMap[item.enrollSeq].categories.push(item.categorySmall);
                            }
                        });

                        let seenRegions = new Set(); // To keep track of already appended regionStr
                        let seenTimes = new Set(); // To keep track of already appended regionStr
                        let seenCategorys = new Set(); // To keep track of already appended regionStr

                        // Now, for each enrollSeq group, add the information to cardInfoList
                        for (let enroll of Object.values(enrollMap)) {
                            let regionStr = enroll.regions.join(', ');
                            let timeStr = enroll.times.join(', ');
                            let categoryStr = enroll.categories.join(', ');

                            let startDatePart = enroll.safetyStartDate.split(' ')[0];
                            let endDatePart = enroll.safetyEndDate.split(' ')[0];


                            cardInfoList.append(
                                "<hr><div class='info-list'><div class='info-header'>사용가능기간 </div>" +
                                "<span class='info-content'>" + startDatePart + " ~ " + endDatePart + "</span></div>"
                            );

                            if (regionStr && !seenRegions.has(regionStr)) {
                                seenRegions.add(regionStr);
                                cardInfoList.append(
                                    "<div class='info-list'><div class='info-header'>결제차단지역 </div>" +
                                    "<span class='info-content'>" + regionStr + "</span></div>"
                                );
                            }

                            if (timeStr && !seenTimes.has(timeStr)) {
                                seenTimes.add(timeStr);
                                cardInfoList.append(
                                    "<div class='info-list'><div class='info-header'>결제차단시간 </div>" +
                                    "<span class='info-content'>" + timeStr + "</span></div>"
                                );
                            }

                            if (categoryStr && !seenCategorys.has(categoryStr)) {
                                seenCategorys.add(categoryStr);
                                cardInfoList.append(
                                    "<div class='info-list'><div class='info-header'>결제차단업종 </div>" +
                                    "<span class='info-content'>" + categoryStr + "</span></div>"
                                );
                            }

                        }
                    }

                });
            }
        });
    }

    // const selectedButtons = [];
    // // 버튼 요소들을 가져옴
    // const button1 = document.getElementById("region");
    // const button2 = document.getElementById("category");
    // const button3 = document.getElementById("time");
    // // 클릭 이벤트 리스너를 추가
    // button1.addEventListener("click", () => handleButtonClick(button1));
    // button2.addEventListener("click", () => handleButtonClick(button2));
    // button3.addEventListener("click", () => handleButtonClick(button3));
    //
    // function handleButtonClick(clickedButton) {
    //
    //     const buttonText = clickedButton.id;
    //     const index = selectedButtons.indexOf(buttonText);
    //
    //     if (index === -1) {
    //         selectedButtons.push(buttonText);
    //         clickedButton.classList.add("selected");
    //
    //     } else {
    //         selectedButtons.splice(index, 1);
    //         clickedButton.classList.remove("selected");
    //     }
    //     console.log(selectedButtons);
    // }
    //
    //
    // function selectSetting() {
    //
    //     let url = '/safetyCard/safetySetting?selectedButtons=' + selectedButtons;
    //     window.location.href = url;
    // }


    function registerCard() {
        const selectedCards = document.querySelectorAll('input[name="selectedCards"]:checked');
        const selectedIds = Array.from(selectedCards).map(card => card.value).join(',');

        console.log("Selected card ID:", selectedIds);
        $.ajax({
            url: '/safetyCard/registerCard',
            type: 'POST',
            data: selectedIds,
            contentType: 'application/json',
            success: function (response) {
                const ajaxContent = document.querySelector('.ajax-content');
                if (response === "안심카드 서비스 신청 성공") {
                    // openSelectModal();
                    // window.location.href = "/safetyCard/safetySetting";
                    window.location.href = "/safetyCard/safetySettingNew";
                };

                // else
                //     ajaxContent.textContent = "선택하신 카드는 안심카드설정이 이미 신청이 완료된 카드입니다.";
                // ajaxContent.style.color = "red";
                // selectedCards.forEach(card => {
                //         card.checked = false; // 이미 체크된 카드 체크 해제
                //
                //     }
                // )

            }
        });
    }


    function cancleCard(cardId) {
        const selectedCards = document.querySelectorAll('input[name="selectedCards"]:checked');
        const selectedIds = Array.from(selectedCards).map(card => card.value).join(',');
        console.log("Selected card ID:", selectedIds); // cardId 출력
        $.ajax({
            url: '/safetyCard/cancleCard',
            type: 'POST',
            data: selectedIds,
            contentType: 'application/json',
            success: function (response) {
                const ajaxContent = document.querySelector('.ajax-content');
                if (response === "안심카드 서비스 해제 성공") {
                    ajaxContent.textContent = "안심카드 서비스가 해제되었습니다.";
                    ajaxContent.style.color = "green";
                } else

                    ajaxContent.textContent = "선택하신 카드는 해당 서비스 등록내역이 존재하지 않습니다.";
                ajaxContent.style.color = "red";
                selectedCards.forEach(card => {
                    card.checked = false; // 이미 체크된 카드 체크 해제
                });
            }
        });
    }


</script>
</html>


