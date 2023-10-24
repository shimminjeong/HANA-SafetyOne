<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<html>
<head>
    <title>Title</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <link href="../../../resources/css/common.css" rel="stylesheet">
    <link href="../../../resources/css/member/fdsCardSelect.css" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
</head>
<body>
<%@ include file="../include/header.jsp" %>
<div class="container">
    <div class="content-div">
        <div class="content-header">
            <h2>안심서비스 카드 선택</h2>
        </div>
        <span class="sub-container-hearder">보유카드 목록</span><span class="fds-info-text hidden">사용기간이 6개월 이상 지난 카드만 신청 가능합니다.</span>
        <hr class="sub-hr">
        <div class="cardAll-div">
            <div class="cardAll-img-div"><img src="../../../resources/img/circle.png" onclick="AllCard()"></div>
            <div class="all-text">전체선택</div>
        </div>
        <hr>
        <c:forEach items="${cards}" var="card" varStatus="loop">
            <div class="lostcard-list">
                <div class="card-list-info" id="${card.cardId}">
                    <div class="card-list-info-img-div">
                        <img src="../../../resources/img/circle.png" onclick="changeImage(this, '${card.cardId}')">
                    </div>
                    <img class="card-img" src="../../../resources/img/${card.cardName}.png">
                    <div class="card-info-text">
                        <div class="card-info-text1">
                            <div class="safetycard-info-cardname">${card.cardName}</div>

                            <div class="card-info-name">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[본인]
                            </div>
                        </div>
                        <div class="card-info-text2">
                            <span class="card-info-cardid">${fn:substring(card.cardId, 0, 4)}-****-****-${fn:substring(card.cardId, 15,20)}</span>
                            <span class="card-info-regDate">[유효 기간] ${fn:substring(card.cardRegDate, 0,10)}&nbsp;~&nbsp;${fn:substring(card.validDate, 0, 10)}</span>
                        </div>
                    </div>
                    <c:if test="${card.selffdsSerStatus eq 'Y'}">
                        <img class="service-status-img" src="../../../resources/img/padlock.png">
                    </c:if>
                </div>

            </div>
            <hr>
        </c:forEach>
        <div class="sub-container-hearder" style="margin-top: 50px;">서비스 약관 동의</div>
        <hr class="sub-hr">
        <div class="cardAll-div">
            <div class="check-div"><input type="checkbox" class="master-checkbox"></div>
            <div class="agree-All">전체 동의</div>
        </div>
        <div class="sub-agree-div">
            <div class="agree-div">
                <div class="check-div"><input type="checkbox" class="sub-checkbox"></div>
                <div class="agree-text">개인정보 동의</div>
                <button class="agree-content-btn">개정약관</button>
            </div>
            <div class="agree-div">
                <div class="check-div"><input type="checkbox" class="sub-checkbox"></div>
                <div class="agree-text">하나카드 마이데이터 서비스 이용약관</div>
                <button class="agree-content-btn">개정약관</button>
            </div>
        </div>
        <div class="reg-btn-div" style="margin-top: 40px; margin-bottom: 50px;">
            <button class="fds-can-Btn" onclick="cancleCard()">해제</button>
            <button class="fds-reg-Btn" onclick="registerCard()">신청</button>
        </div>

    </div>
</div>

</body>
<script>

    function regSafety() {

        let clickRegFds = document.querySelector('.clickRegFds');
        if (clickRegFds.classList.contains('hidden')) {
            clickRegFds.classList.remove('hidden');
        } else {
            clickRegFds.classList.add('hidden');
        }

        let regBtnDiv = document.querySelector('.reg-btn-div');
        if (regBtnDiv.classList.contains('hidden')) {
            regBtnDiv.classList.remove('hidden');
        } else {
            regBtnDiv.classList.add('hidden');
        }

    }

    function agreeSafetyPhone() {

        let modal = document.getElementById('authModal');
        modal.style.display = 'block';
    }

    window.onclick = function (event) {
        let modal = document.getElementById('authModal');
        if (event.target == modal || event.target == document.querySelector('.close-btn')) {
            modal.style.display = 'none';
        }
    }


    let selectedCardIds = [];

    function AllCard() {

        let allImages = document.querySelectorAll('.cardAll-img-div img, .card-list-info-img-div img');

        allImages.forEach(function (img) {

            if (img.parentElement.classList.contains('cardAll-img-div')) {
                changeImage(img, null);
            } else {
                let cardId = img.parentElement.parentElement.id;
                changeImage(img, cardId);
            }
        });
    }

    function changeImage(imgElement, cardId) {
        if (imgElement.src.endsWith('circle.png')) {
            imgElement.src = "../../../resources/img/check-mark.png";
            if (cardId) {
                selectedCardIds.push(cardId);
            }
        } else {
            imgElement.src = "../../../resources/img/circle.png";
            if (cardId) {
                const index = selectedCardIds.indexOf(cardId);
                if (index > -1) {
                    selectedCardIds.splice(index, 1);
                }
            }
        }

    }

    $(document).ready(function () {

        $('.master-checkbox').change(function () {
            if ($(this).is(':checked')) {
                $('.sub-checkbox').prop('checked', true);
            } else {
                $('.sub-checkbox').prop('checked', false);
            }
        });
    });

    function registerCard() {

        console.log("selectedCardIds", selectedCardIds);
        $.ajax({
                url: '/safetyCard/registerCard',
                type: 'POST',
                data: JSON.stringify(selectedCardIds),
                contentType: 'application/json',
                success: function (response) {
                    const ajaxContent = document.querySelector('.ajax-content');
                    if (response === "안심서비스 신청 성공") {

                        window.location.href = "/safetyCard/safetySettingNew";
                    } else {
                        ajaxContent.textContent = "선택하신 카드는 안심카드로 이미 신청이 완료된 카드입니다.";
                        ajaxContent.style.color = "red";
                        selectedCards.forEach(card => {
                                card.checked = false;

                            }
                        )
                    }
                    ;
                }
            }
        )
        ;
    }

    function cancleCard() {
        $.ajax({
            url: '/safetyCard/cancleCard',
            type: 'POST',
            data: JSON.stringify(selectedCardIds),
            contentType: 'application/json',
            success: function (response) {
                const ajaxContent = document.querySelector('.ajax-content');
                if (response === "안심서비스 해제 성공") {

                    window.location.href = "/";
                } else {

                    ajaxContent.textContent = "선택하신 카드는 해당 서비스 등록내역이 존재하지 않습니다.";
                    ajaxContent.style.color = "red";
                    selectedCards.forEach(card => {
                        card.checked = false;
                    })
                }
                ;
            }
        });
    }


</script>
</html>


