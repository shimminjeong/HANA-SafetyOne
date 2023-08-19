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

        width: 100px;
    }

    .content-div {
        margin-bottom: 20px;
    }
</style>


</style>
<body>
<%@ include file="../include/header.jsp" %>
<div class="container">
    <div class="formsize">
        <div class="content-div">
            <h1>안심결제(SelfFDS)</h1>
            <h2>안심결제(SelfFDS) 이용현황</h2>
            <h3>설정할 카드를 선택 후 [등록] 또는 [해제]를 선택해주세요</h3></ㅗ4>
        </div>
        <div class="card-list">
            <c:forEach items="${cards}" var="card" varStatus="loop">
                <div class="card-box">
                    <div>
                        <input type="checkbox" name="selectedCards" value="${card.card_id}">
                    </div>
                    <div>본인</div>
                    <div>${card.card_id}</div>
                    <img class="card-img" src="../../../resources/img/cardImg${loop.index + 1}.png">
                        <%--                <div>${card.card_reg_date}</div>--%>
                </div>
            </c:forEach>
        </div>
        <div class="reg-cancle-btn">
            <button class="cancle-Btn" onclick="cancleCard()">해제</button>
            <button class="reg-Btn" onclick="registerCard()">등록</button>
        </div>
    </div>
</div>
</body>
<script>
    function registerCard() {
        const selectedCards = document.querySelectorAll('input[name="selectedCards"]:checked');
        const selectedIds = Array.from(selectedCards).map(card => card.value).join(',');

        console.log("Selected card ID:", selectedIds); // cardId 출력
        $.ajax({
            url: '/service/registerCard',
            type: 'POST',
            data: selectedIds,
            contentType: 'application/json',
            success: function (response) {
                if (response === "selffds 서비스 신청 성공") {
                    alert("selffds 서비스 신청 성공");
                    var link = document.createElement("a");
                    link.href = "/service/selffdsRegion";
                    link.click();
                } else
                    alert("이미 신청이 완료된 카드입니다.");
            }
        });
    }


    function cancleCard(card_id) {
        const selectedCards = document.querySelectorAll('input[name="selectedCards"]:checked');
        const selectedIds = Array.from(selectedCards).map(card => card.value).join(',');
        console.log("Selected card ID:", selectedIds); // cardId 출력
        $.ajax({
            url: '/service/cancleCard',
            type: 'POST',
            data: selectedIds,
            contentType: 'application/json',
            success: function (response) {
                if (response === "selffds 서비스 해제 성공") {
                    alert("selffds 서비스 해제 성공");
                } else
                    alert("해당 서비스 신청안된 카드입니다.");
            }
        });
    }

</script>
</html>


