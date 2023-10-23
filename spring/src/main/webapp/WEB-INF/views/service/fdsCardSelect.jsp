<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<html>
<head>
    <title>Title</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <%--    <link href="../../../resources/css/common.css" rel="stylesheet">--%>
    <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
    <%--    <link href="../../../resources/css/cardSelectCommon.css" rel="stylesheet">--%>
    <link href="../../../resources/css/fdsCardSelect.css" rel="stylesheet">
    <link href="../../../resources/css/modalStyle.css" rel="stylesheet">
    <script src="../../../resources/js/userOuath.js" type="text/javascript"></script>
</head>
<body>
<%@ include file="../include/header.jsp" %>
<div class="container">
    <div class="content-div">
        <div class="content-header">
            <h2>이상소비알림서비스 카드 선택</h2>
            <span style="align-self: flex-start; font-size: 18px; margin-bottom: 30px; margin-top:10px;">선택한 카드의 거래내역으로 소비패턴을 학습합니다.</span>
        </div>
        <span class="sub-container-hearder">보유카드 목록</span><span class="fds-info-text" style="text-align: right">※ 사용기간이 6개월 이상 지난 카드만 신청 가능합니다.</span>
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
                            <div class="card-info-cardname">${card.cardName}</div>

                            <div class="card-info-name">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[본인]
                            </div>
                        </div>
                        <div class="card-info-text2">
                            <span class="card-info-cardid">${fn:substring(card.cardId, 0, 4)}-****-****-${fn:substring(card.cardId, 15,20)}</span>
                            <span class="card-info-regDate">[유효 기간] ${fn:substring(card.cardRegDate, 0,10)}&nbsp;~&nbsp;${fn:substring(card.validDate, 0, 10)}  </span>
                        </div>
                    </div>
                    <c:if test="${card.fdsSerStatus eq 'Y'}">
                        <img class="service-status-img" src="../../../resources/img/notification.png">
                    </c:if>
                        <%--                    <c:if test="${card.fdsSerStatus eq 'N'}">--%>
                        <%--                        <img class="service-status-img" src="../../../resources/img/silent.png">--%>
                        <%--                    </c:if>--%>
                </div>
            </div>
            <hr>
        </c:forEach>


        <div class="reg-btn-div">
            <button class="fds-can-Btn" onclick="cancleCard()">해제</button>
            <button class="fds-reg-Btn" onclick="regFds()">신청</button>
        </div>
        <div class="clickRegFds hidden">
            <div style="height: 40px"></div>
            <div class="sub-container-hearder">알림 받을 휴대번호</div>
            <hr class="sub-hr">
            <%
                String phone = (String) session.getAttribute("phone");
                phone = phone.substring(0, phone.length() - 4) + "****";
            %>
            <div class="sub-content-div">
                <div class="phoneNumber-text"><%=phone%>
                </div>
                <button class="updateMyInfo">개인정보변경</button>
            </div>
            <hr>
            <div style="height: 40px"></div>
            <div class="sub-container-hearder">서비스 약관 동의</div>
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
                    <div class="agree-text">휴대폰 메시지 표준약관</div>
                    <button class="agree-content-btn">개정약관</button>
                </div>
            </div>

            <hr>
            <%--    <div class="ajax-content"></div>--%>
            <div class="reg-confirm-div">
                <button class="fds-back-Btn" onclick="window.location.href='/'">취소</button>
                <%--                <button class="fds-agree-Btn" onclick="registerCard()">확인</button>--%>
                <button class="fds-agree-Btn" onclick="agreePhone()">확인</button>
            </div>
        </div>
    </div>
</div>

<div class="modal-2" id="termsModal">
    <div class="modal-content-2">
        <div class="text-header">휴대폰 메시지 표준약관&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&times;</div>
        <div class="text">
            <div style="margin-top:10px; font-size: 18px; font-weight: 700;">제1조(목적)</div>
            <span>이 약관은 하나카드 주식회사(이하 “회사”라 함)와 이용자 사이의 휴대폰 메시지 서비스
            이용조건 및 절차 등에 관한 사항을 규정함으로써 이용자의 권익을 보호하고 거래 당사자
                상호 간 이해관계를 합리적으로 조정하는 것을 목적으로 합니다.</span>

            <div style="margin-top:10px; font-size: 18px; font-weight: 700;">제2조(정의)</div>
            <span>이 약관에서 사용하는 용어의 정의는 다음과 같습니다.<br>
            1. 휴대폰 메시지란 통신사 및 인터넷망 사업자 등의 통신 및 데이터 전송 기능을 통해
            송부되는 문자, 전자문서 등을 말하며, 휴대폰 문자메시지(SMS 등)와 모바일 메시징
            서비스를 통한 모바일 메시지를 의미합니다.<br>
            2. 휴대폰 메시지 서비스란 회사가 이용자로부터 일정 수수료를 대가로 이용자가
            지정한 휴대폰 번호 또는 다른 통신단말기 번호(이하 “휴대폰 번호”라 함)에 해당하는
            무선단말기(이하 “휴대폰 ”이라 함)에 회사가 휴대폰 메시지를 이용하여 이용자의 승인,
            결제 및 기타 서비스 정보 등을 제공하는 것을 말합니다.<br>
            3. 휴대폰 메시지 서비스 이용자(이하 “이용자”라 한다)란 회사에 카드이용 등과 관련하여
                본인이 선택한 방법으로 휴대폰 메시지 서비스 이용을 신청한 자를 말합니다.</span>

            <div style="margin-top:10px; font-size: 18px; font-weight: 700;">제3조(서비스 이용계약)</div>
            <span>① 휴대폰 메시지 서비스를 이용하려는 자는 카드회원 가입 시 서비스 이용을
            신청하거나 회사 전화, 홈페이지 등을 통해 가입을 신청해야 하고 유효한 휴대폰 번호를
            회사에 제공해야 합니다.<br>
            ② 휴대폰 메시지 서비스는 연중무휴, 1일 24시간 제공되며 회사 시스템의
            유지‧보수‧점검(업무 위‧수탁 업체를 포함한다), 이동통신사 또는 인터넷망 사업자의 시스템
            유지‧보수‧점검 등으로 휴대폰 메시지 서비스 이용이 제한, 지연, 누락될 경우 1개월
            전에 이용자에게 이용대금명세서, 서면, 전화, 전자우편(E-mail), 휴대폰 메시지 등으로 동
            내용을 안내해야 합니다. 다만, 긴급한 사정으로 휴대폰 메시지 서비스 이용이 제한, 지연,
            누락된 사실을 미리 안내할 수 없는 경우에는 전달되지 못한 휴대폰 메시지 서비스
            내용을 이용자에게 즉시 다시 전송해야 하며 사후적으로 휴대폰 메시지 서비스 이용이
            제한, 지연, 누락되어 이용자에게 손해가 발생한 경우에는 이를 배상하도록 합니다.<br>
            ③ 제2항 단서에도 불구하고 다음 각 호의 경우에는 이용자가 손해배상을 청구할 수
            없습니다.<br>
            1. 이용자의 휴대폰 분실, 도난, 파손, 고장 등 이용자의 책임있는 사유로 휴대폰 메시지를
            정상적으로 수신할 수 없는 경우<br>
            2. 이용자의 휴대폰 전원이 꺼져있거나, 이용자의 책임있는 사유로 휴대폰이 정지 또는
            해지된 경우<br>
            3. 이용자의 휴대폰 번호가 변경된 사실을 회사에 알리지 않은 경우<br>
            ④ 회사는 휴대폰 메시지 서비스 제공 범위에 따라 이용자별로 개인회원(본인회원 및
            가족회원별) 300원의 수수료를 청구할 수 있습니다. 수수료를 변경할 경우 변경 전
            3개월부터 매월 홈페이지, 이용대금명세서, 서면, 우편, 전화, 전자우편(E-mail), 휴대폰
            메시지 중 2가지 이상의 방법으로 이용자에게 수수료 변경 사유와 변경 내용, 수수료
            변경에 따른 계약해지 방법을 안내해야 합니다.</span>
        </div>
        <button class="close-btn-2">확인</button>
    </div>
</div>

<script>
    document.querySelector(".agree-content-btn").addEventListener("click", function () {
        document.getElementById("termsModal").style.display = "block";
    });

    document.querySelector(".close-btn-2").addEventListener("click", function () {
        document.getElementById("termsModal").style.display = "none";
    });

    window.addEventListener("click", function (event) {
        if (event.target === document.getElementById("termsModal")) {
            document.getElementById("termsModal").style.display = "none";
        }
    });

</script>
<div id="authModal" class="modal">
    <div class="auth-container">
        <span class="close-btn">&times;</span>
        <div class="auth-header">본인인증</div>
        <div class="auth-content">
            <div class="content-row">
                <div class="content-div-header" style="margin: auto 0;">이름</div>
                <div class="content-div-input"><input type="text" placeholder="이름"></div>
            </div>
            <%--            <div class="content-row">--%>
            <%--                <div class="content-div-header" style="margin: auto 0;">생년월일</div>--%>
            <%--                <div class="content-div-input"><input type="text" placeholder="19981223 형식으로 입력"></div>--%>
            <%--            </div>--%>
            <div class="content-row">
                <div class="content-div-header" style="margin-top: 10px;">휴대전화</div>
                <div class="content-div-phone">
                    <%--                    <div class="agree-form">--%>
                    <%--                        <div class="accordion-header">--%>
                    <%--                            <span class="toggle-icon">V</span>--%>
                    <%--                            본인인증 약관 전체동의--%>
                    <%--                            <span class="accordion-indicator">▼</span>--%>
                    <%--                        </div>--%>

                    <%--                        <div class="accordion-content">--%>
                    <%--                            <hr>--%>
                    <%--                            <div><span class="toggle-icon">v</span> 개인정보 제공 및 이용</div>--%>
                    <%--                            <div><span class="toggle-icon">v</span> 고유식별 정보처리</div>--%>
                    <%--                            <div><span class="toggle-icon">v</span> 통신사 이용약관</div>--%>
                    <%--                        </div>--%>
                    <%--                    </div>--%>
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
                        <div class="btn-div">
                            <button class="send-authNumber" onclick="sendSmsRequest()">인증번호 받기</button>
                        </div>
                    </div>
                    <div class="auth-number-input"><input type="text" id="userOuathNum"
                                                          placeholder="인증번호 숫자만 6자리 입력">
                    </div>
                </div>
            </div>
        </div>
        <button onclick="verifySmsCode()" class="auth-confirm">확인</button>
    </div>
    <div id="result"></div>
</div>
</body>
<script>

    function regFds() {
        // Toggle visibility for clickRegFds
        let clickRegFds = document.querySelector('.clickRegFds');
        if (clickRegFds.classList.contains('hidden')) {
            clickRegFds.classList.remove('hidden');
        } else {
            clickRegFds.classList.add('hidden');
        }

        // Toggle visibility for reg-btn-div
        let regBtnDiv = document.querySelector('.reg-btn-div');
        if (regBtnDiv.classList.contains('hidden')) {
            regBtnDiv.classList.remove('hidden');
        } else {
            regBtnDiv.classList.add('hidden');
        }

    }


    // 모달
    function agreePhone() {
        // 모달 창을 표시합니다.
        let modal = document.getElementById('authModal');
        modal.style.display = 'block';
    }

    // 모달 외부를 클릭하면 모달을 닫습니다.
    window.onclick = function (event) {
        let modal = document.getElementById('authModal');
        if (event.target == modal || event.target == document.querySelector('.close-btn')) {
            modal.style.display = 'none';
        }
    }


    //
    $(document).ready(function () {
        // 전체 동의 체크박스가 변경될 때 실행
        $('.master-checkbox').change(function () {
            if ($(this).is(':checked')) {
                // 전체 동의 체크박스가 체크되면 모든 서브 체크박스 체크
                $('.sub-checkbox').prop('checked', true);
            } else {
                // 전체 동의 체크박스가 체크 해제되면 모든 서브 체크박스 체크 해제
                $('.sub-checkbox').prop('checked', false);
            }
        });
    });

    let selectedCardIds = [];
    console.log("selectedCardIds", selectedCardIds)

    function AllCard() {
        // 'cardAll-img-div' 클래스를 가진 div의 이미지와
        // 'card-list-info-img-div' 클래스를 가진 모든 div의 이미지를 선택합니다.
        let allImages = document.querySelectorAll('.cardAll-img-div img, .card-list-info-img-div img');

        // 각 이미지 요소에 대해 changeImage() 함수를 호출합니다.
        allImages.forEach(function (img) {
            // 이미지가 전체 선택 이미지인 경우와 카드 이미지인 경우를 구분합니다.
            if (img.parentElement.classList.contains('cardAll-img-div')) {
                changeImage(img, null); // 전체 선택 이미지의 경우 cardId는 null로 처리합니다.
            } else {
                let cardId = img.parentElement.parentElement.id; // 카드 ID를 가져옵니다.
                changeImage(img, cardId);
            }
        });
    }

    function changeImage(imgElement, cardId) {
        if (imgElement.src.endsWith('circle.png')) {
            imgElement.src = "../../../resources/img/check-mark.png";
            if (cardId) { // cardId가 있는 경우만 배열에 추가
                selectedCardIds.push(cardId);
            }
        } else {
            imgElement.src = "../../../resources/img/circle.png";
            if (cardId) { // cardId가 있는 경우만 배열에서 제거
                const index = selectedCardIds.indexOf(cardId);
                if (index > -1) {
                    selectedCardIds.splice(index, 1);
                }
            }
        }
        console.log("selectedCardIds", selectedCardIds);
    }

    function registerCard() {

        console.log("Selected card ID:", selectedCardIds);
        $.ajax({
            url: '/fds/registerCard',
            type: 'POST',
            data: JSON.stringify(selectedCardIds),
            contentType: 'application/json',
            success: function (response) {
                const ajaxContent = document.querySelector('.ajax-content');
                if (response === "이상 소비 알림 서비스 신청 성공") {
                    window.location.href = "/fds/fdsRegisterOk";
                } else
                    ajaxContent.textContent = "이미 신청이 완료된 카드입니다.";
                ajaxContent.style.color = "red";
                selectedCards.forEach(card => {
                        card.checked = false; // 이미 체크된 카드 체크 해제
                    }
                )
                ;
            }
        });
    }


    function cancleCard(cardId) {

        $.ajax({
            url: '/fds/cancleCard',
            type: 'POST',
            data: JSON.stringify(selectedCardIds),
            contentType: 'application/json',
            success: function (response) {
                console.log(response)
                // const ajaxContent = document.querySelector('.ajax-content');
                // if (response === "이상 소비 알림 서비스 해제 성공") {
                //     ajaxContent.textContent = "이상 소비 알림 서비스가 해제되었습니다.";
                //     ajaxContent.style.color = "green";
                // } else
                //
                //     ajaxContent.textContent = "이 카드는 해당 서비스 신청내역이 존재하지 않습니다.";
                // ajaxContent.style.color = "red";
                // selectedCards.forEach(card => {
                //     card.checked = false; // 이미 체크된 카드 체크 해제
                // });
            }
        });
    }

</script>
</html>