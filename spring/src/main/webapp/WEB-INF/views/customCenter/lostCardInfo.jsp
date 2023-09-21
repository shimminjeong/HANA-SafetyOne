<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"
          name="viewport" content="width=device-width, initial-scale=1"/>
    <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
    <link href="../../../resources/css/common.css" rel="stylesheet">
    <link href="../../../resources/css/lostcard.css" rel="stylesheet">
    <link href="../../../resources/css/cardSelectCommon.css" rel="stylesheet">
    <link rel="stylesheet" href="http://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
    <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
    <script src="../../../resources/js/userOuath.js" type="text/javascript"></script>
</head>
<body>
<%@ include file="../include/header.jsp" %>
<div class="active-container">
    <div class="cont_box_area">
        <nav class="tab_ty02">
            <li><a href="/customCenter/lostCardSelect" title="현재 선택 탭">카드분실/도난신고</a></li>
            <li><a href="#">카드분실신고해제</a></li>
            <li class="on"><a href="/customCenter/lostCardInfo">카드분실신고내역</a></li>
        </nav>
        <div class="lost-header"><h2>분실신고 카드내역</h2></div>
        <hr>
        <table>
            <colgroup>
                <col span="1" style="width:23%;">
                <col span="1" style="width:77%;">
            </colgroup>
            <tbody>
            <tr>
                <th scope="row" class="left">분실카드</th>
                <td class="left">
                    <div class="value">${lostCard.cardId} &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${cardInfo.cardName}</div>
                </td>
            </tr>
            <tr>
                <th scope="row" class="left">접수일</th>
                <td class="left">
                    <div class="value">${todayDate}</div>
                </td>
            </tr>
            <tr>
                <th scope="row" class="left">분실일자</th>
                <td class="left">
                    <div class="value">${lostCard.lostDate}</div>
                </td>
            </tr>
            <tr>
                <th scope="row" class="left">재발급 신청</th>
                <td class="left">
                    <div class="value">
                        <c:choose>
                            <c:when test="${lostCard.reissued == 'Y'}">신청</c:when>
                            <c:when test="${lostCard.reissued == 'N'}">미신청</c:when>
                            <c:otherwise>${lostCard.reissued}</c:otherwise>
                        </c:choose>
                    </div>

                </td>
            </tr>
            </tbody>
        </table>
        <hr>
    </div>
    <button class="registerLostBtn" onclick="registerLostCard()">다음</button>
</div>

<%--    알림문자보내기--%>
<div class="form-group">
    <label for="phoneNumber">전화번호</label>
    <div class="input-wrapper">
        <input type="tel" id="phoneNumber" name="phoneNumber" placeholder="010XXXXXXXX" required maxlength="11">
        <!-- <button type="submit" id="sendSmsButton">인증번호 전송</button> -->
        <button onclick="sendSmsRequest()" class="button">인증번호 전송</button>
    </div>
</div>

<input type="tel" id="userOuathNum" name="userOuathNum" placeholder="인증번호입력" required maxlength="5">
<button onclick="verifySmsCode()" class="button">인증번호 확인</button>
<div id="result"></div>
</body>


</html>