<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"
          name="viewport" content="width=device-width, initial-scale=1"/>
    <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
    <link href="../../../resources/css/common.css" rel="stylesheet">
    <link href="../../../resources/css/member/lostcard.css" rel="stylesheet">
    <link href="../../../resources/css/member/cardSelectCommon.css" rel="stylesheet">
    <link rel="stylesheet" href="http://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
    <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
    <script src="../../../resources/js/userOuath.js" type="text/javascript"></script>
</head>
<body>
<%@ include file="../include/header.jsp" %>
<div class="active-container">
    <div class="cont_box_area">
    <div class="title">분실신고/재발급</div>
        <div class="lost-header"><h3>분실신고 카드내역</h3></div>
        <table>
            <tbody>
            <tr>
                <th scope="row" class="left">분실카드</th>
                <td class="left">
                    <div class="value">${lostCard.cardId}&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;${cardInfo.cardName}</div>
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
    </div>
    <button class="confirm-btn">확인</button>
</div>

</body>


</html>