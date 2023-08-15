<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
    <title>Title</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <link href="../../../resources/css/common.css" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
</head>
<style>
    /* 체크박스 스타일링 */
    input[type="checkbox"] {
        -webkit-appearance: none;
        appearance: none;
        width: 16px;
        height: 16px;
        background-color: white;
        border: 2px solid #ccc;
        border-radius: 3px;
        cursor: pointer;
    }

    input[type="checkbox"]:checked {
        background-color: #1e87f0;
        border: 2px solid #1e87f0;
    }

    input[type="checkbox"]:hover {
        border: 2px solid #1e87f0;
    }
</style>
<body>
<%@ include file="../include/header.jsp" %>
<div class="container">
    <table>
        <c:forEach items="${cards}" var="card">
            <tr>
                <td>
                    <input type="checkbox" name="selectedCards" value="${card.card_id}">
                </td>
                <td>${card.card_id}</td>
                <td>${card.card_reg_date}</td>
            </tr>
        </c:forEach>
    </table>
    <div class="btn">
        <button class="cancleBtn" onclick="cancleCard()">해제</button>
        <button class="regBtn" onclick="registerCard()">등록</button>
    </div>

</div>
</body>
<script>
    function registerCard(){
        const selectedCards = document.querySelectorAll('input[name="selectedCards"]:checked');
        const selectedIds = Array.from(selectedCards).map(card => card.value).join(',');

        console.log("Selected card ID:", selectedIds); // cardId 출력
        $.ajax({
            url: '/service/registerCard',
            type: 'POST',
            data: selectedIds,
            contentType: 'application/json',
            success: function(response) {
                if (response === "selffds 서비스 신청 성공") {
                    alert("selffds 서비스 신청 성공");
                    window.location.href = '/service/selffdsRegion';
                } else
                    alert("이미 신청이 완료된 카드입니다.");
            }
        });
    }


    function cancleCard(card_id){
        const selectedCards = document.querySelectorAll('input[name="selectedCards"]:checked');
        const selectedIds = Array.from(selectedCards).map(card => card.value).join(',');
        console.log("Selected card ID:", selectedIds); // cardId 출력
        $.ajax({
            url: '/service/cancleCard',
            type: 'POST',
            data: selectedIds,
            contentType: 'application/json',
            success: function(response) {
                if (response === "selffds 서비스 해제 성공") {
                    alert("selffds 서비스 해제 성공");
                    window.location.href = '/service/serviceInfo';
                } else
                    alert("해당 서비스 신청안된 카드입니다.");
            }
        });
    }




</script>
</html>
