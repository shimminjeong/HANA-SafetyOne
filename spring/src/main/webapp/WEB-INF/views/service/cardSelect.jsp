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
        width: 20px;
        height: 20px;
        background-color: white;
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

    .card-box {
        border: 1px solid #ccc; /* 테두리 스타일 설정 */
        padding: 10px; /* 내부 여백 설정 */
        margin: 10px 0; /* 바깥쪽 여백 설정 */
        display: flex;
        flex-direction: row;
        justify-content: space-between;
        align-items: center;
        font-size: 18px;
        border-radius: 3px;
    }

    .card-img {
        width: 90px;
    }

    .ajax-content {
        font-size: 14px;
        display: flex;
        justify-content: center
    }

    .formsize {
        margin: 50px auto;
        display: flex;
        flex-direction: column;
        justify-content: center;
        color: black; /* 글자색 변경 */
        padding: 30px 80px; /* 패딩 */
        border: none; /* 테두리 없음 */
        border-radius: 10px; /* 둥근 모서리 */
        text-decoration: none;
        font-size: 12px; /* 폰트 크기 변경 */
        cursor: pointer;
        background-color: #ffffff; /* 배경색 추가 */
        transition: background-color 0.3s, transform 0.3s; /* 부드러운 전환 효과 추가 */
        box-shadow: 0 4px 6px rgba(0, 0, 0, 0.4); /* 그림자 추가 */
        max-width: 600px; /* 가로 크기 */
        max-height: 500px; /* 세로 크기 */
    }


    /*모달*/
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
        background-color: white;
    }

    .modal-content {
        background-color: white;
        width: 400px;
        height: 450px;
        padding: 20px;
        position: absolute;
        top: 50%;
        left: 50%;
        transform: translate(-50%, -50%);
        text-align: center;
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
                <div class="card-box">
                    <div>
                        <input type="checkbox" name="selectedCards" value="${card.cardId}">
                    </div>
                    <div>본인</div>
                    <div>${card.cardId}</div>
                    <img class="card-img" src="../../../resources/img/cardImg${loop.index + 1}.png">
                </div>
            </c:forEach>
        </div>
        <div class="ajax-content"></div>
        <div class="reg-cancle-btn">
            <button class="cancle-Btn" onclick="cancleCard()">해제</button>
            <button class="reg-Btn" onclick="registerCard()">등록</button>
        </div>
    </div>
    <div id="selectModal" class="modal" style="display: none;">
        <div class="modal-content">
            <div class="modal-header">안심카드설정</div>
            <div class="modal-message">
                <span>안녕하세요</span>
                <span class="spancon">차단할 항목을 선택하세요</span>
                <span class="spancon">원하시는 조합을 엮어보세요</span>
                <%--                <div class="venn-container">--%>
                <%--        <span id="circle1" class="circle">--%>
                <%--            <img class="img-select1" src="../../resources/img/category.png" alt="Option Lines">--%>
                <%--        </span>--%>
                <%--                    <span id="circle2" class="circle">--%>
                <%--            <img class="img-select2" src="../../resources/img/region.png" alt="Location">--%>
                <%--        </span>--%>
                <%--                    <span id="circle3" class="circle">--%>
                <%--            <img class="img-select3" src="../../resources/img/time.png" alt="Clock">--%>
                <%--        </span>--%>
                <%--                </div>--%>

                <div class="modal-grid">
                    <div class="select-content" onclick="window.location.href='/safetyCard/region';">
                        <img class="img-select" src="../../resources/img/location.png" height="60">
                        <div>위치</div>
                    </div>
                    <div class="select-content" onclick="window.location.href='/safetyCard/category';">
                        <img class="img-select" src="../../resources/img/optionslines.png" height="60">
                        <div>업종</div>
                    </div>
                    <div class="select-content" onclick="window.location.href='/safetyCard/time';">
                        <img class="img-select" src="../../resources/img/clock.png" height="60">
                        <div>시간</div>
                    </div>
                </div>
            </div>
            <button class="close-button" onclick="closeSelectModal()">&times;</button>

        </div>
    </div>
</div>

</body>
<script>

    function openSelectModal() {
        // 모달 열기 코드를 여기에 작성합니다.
        // 예시: 모달 엘리먼트를 선택하고 display 스타일을 변경하여 모달을 표시합니다.
        var successModal = document.getElementById("selectModal");
        if (successModal) {
            successModal.style.display = "block";
        }
    }

    // 모달 닫기 함수
    function closeSelectModal() {
        var successModal = document.getElementById("selectModal");
        if (successModal) {
            successModal.style.display = "none";
        }
    }


    function registerCard() {
        const selectedCards = document.querySelectorAll('input[name="selectedCards"]:checked');
        const selectedIds = Array.from(selectedCards).map(card => card.value).join(',');

        console.log("Selected card ID:", selectedIds); // cardId 출력
        $.ajax({
            url: '/safetyCard/registerCard',
            type: 'POST',
            data: selectedIds,
            contentType: 'application/json',
            success: function (response) {
                const ajaxContent = document.querySelector('.ajax-content');
                if (response === "selffds 서비스 신청 성공") {
                    // 모달 열기
                    openSelectModal();

                } else
                    ajaxContent.textContent = "이미 신청이 완료된 카드입니다.";
                ajaxContent.style.color = "red";
                selectedCards.forEach(card => {
                    card.checked = false; // 이미 체크된 카드 체크 해제
                });
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
                if (response === "selffds 서비스 해제 성공") {
                    ajaxContent.textContent = "selffds 서비스가 해제되었습니다.";
                    ajaxContent.style.color = "green";
                    // 페이지 옮기기
                } else

                    ajaxContent.textContent = "이 카드는 해당 서비스 신청내역이 존재하지 않습니다.";
                ajaxContent.style.color = "red";
                selectedCards.forEach(card => {
                    card.checked = false; // 이미 체크된 카드 체크 해제
                });
            }
        });
    }


</script>
</html>


