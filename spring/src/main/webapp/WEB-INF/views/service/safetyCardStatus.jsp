<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
    <title>Title</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <link href="../../../resources/css/common.css" rel="stylesheet">
    <link href="../../../resources/css/safetyCardStatus.css" rel="stylesheet">
    <link href="../../../resources/css/service.css" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
</head>
<body>
<%@ include file="../include/header.jsp" %>
<div class="container">
    <div class="formsize">
        <div class="content-div">
            <h1>안심카드설정</h1>
            <h2>안심카드서비스 이용현황</h2>
            <h3>설정할 카드를 선택 후 [등록] 또는 [해제]를 선택해주세요 / 일시정지</h3></ㅗ4>
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
    // var acc = document.getElementsByClassName("accordion");
    // var i;
    // for (i = 0; i < acc.length; i++) {
    //     acc[i].addEventListener("click", function () {
    //         this.classList.toggle("active");
    //         var panel = this.nextElementSibling;
    //         if (panel.style.display === "block") {
    //             panel.style.display = "none";
    //         } else {
    //             panel.style.display = "block";
    //             var cardId = this.id; // 클릭한 accordion의 id를 가져옵니다.
    //             console.log("cardid",cardId);
    //             // 클릭한 accordion의 cardId를 서버에 전달하고 정보를 가져오는 Ajax 요청
    //             $.ajax({
    //                 url: "/safetyCard/selectSafetyInfo",
    //                 type: 'POST',
    //                 data: JSON.stringify({cardId: cardId}),
    //                 contentType: 'application/json',
    //                 success: function (data) {
    //                     console.log("data : "+data);
    //                     var cardInfoList = $("#cardInfo-" + cardId);
    //                     cardInfoList.append()
    //                     for(let i = 0; i < data.length; i++) {
    //                         let card = data[i];
    //                         console.log(card.cardId)
    //                         console.log(card.regionName)
    //                         console.log(card.categorySmall)
    //                         // 예시: 각 데이터를 화면의 `#output` 요소에 추가합니다.
    //                         $('#output').append('<div>Card ID: ' + card.cardId + '</div>');
    //                         $('#output').append('<div>Region Name: ' + card.regionName + '</div>');
    //                         $('#output').append('<div>Category: ' + card.categorySmall + '</div>');
    //                         $('#output').append('<hr>'); // 각 항목을 구분하기 위한 수평선
    //                     }
    //
    //                 }
    //             });
    //         }
    //     });
    // }


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


                            cardInfoList.append(
                                "<hr><div class='info-list'><div class='info-header'>선택카드</div>" +
                                "<span class='info-content'>" + enroll.cardId + "</span></div>" +
                                "<div class='info-list'><div class='info-header'>사용가능기간 </div>" +
                                "<span class='info-content'>" + enroll.safetyStartDate + " ~ " + enroll.safetyEndDate + "</span></div>"
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

    //
    //
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
    //
    //
    // function registerCard() {
    //     const selectedCards = document.querySelectorAll('input[name="selectedCards"]:checked');
    //     const selectedIds = Array.from(selectedCards).map(card => card.value).join(',');
    //
    //     console.log("Selected card ID:", selectedIds);
    //     $.ajax({
    //         url: '/safetyCard/registerCard',
    //         type: 'POST',
    //         data: selectedIds,
    //         contentType: 'application/json',
    //         success: function (response) {
    //             const ajaxContent = document.querySelector('.ajax-content');
    //             if (response === "안심카드 서비스 신청 성공") {
    //                 openSelectModal();
    //             };
    //                 // else
    //             //     ajaxContent.textContent = "선택하신 카드는 안심카드설정이 이미 신청이 완료된 카드입니다.";
    //             // ajaxContent.style.color = "red";
    //             // selectedCards.forEach(card => {
    //             //         card.checked = false; // 이미 체크된 카드 체크 해제
    //             //
    //             //     }
    //             // )
    //
    //         }
    //     });
    // }
    //
    //
    // function cancleCard(cardId) {
    //     const selectedCards = document.querySelectorAll('input[name="selectedCards"]:checked');
    //     const selectedIds = Array.from(selectedCards).map(card => card.value).join(',');
    //     console.log("Selected card ID:", selectedIds); // cardId 출력
    //     $.ajax({
    //         url: '/safetyCard/cancleCard',
    //         type: 'POST',
    //         data: selectedIds,
    //         contentType: 'application/json',
    //         success: function (response) {
    //             const ajaxContent = document.querySelector('.ajax-content');
    //             if (response === "안심카드 서비스 해제 성공") {
    //                 ajaxContent.textContent = "안심카드 서비스가 해제되었습니다.";
    //                 ajaxContent.style.color = "green";
    //             } else
    //
    //                 ajaxContent.textContent = "선택하신 카드는 해당 서비스 등록내역이 존재하지 않습니다.";
    //             ajaxContent.style.color = "red";
    //             selectedCards.forEach(card => {
    //                 card.checked = false; // 이미 체크된 카드 체크 해제
    //             });
    //         }
    //     });
    // }
    //
    // function openSelectModal() {
    //     var successModal = document.getElementById("selectModal");
    //     if (successModal) {
    //         successModal.style.display = "block";
    //     }
    // }
    //
    // function closeSelectModal() {
    //     var successModal = document.getElementById("selectModal");
    //     if (successModal) {
    //         successModal.style.display = "none";
    //     }
    // }


</script>
</html>


