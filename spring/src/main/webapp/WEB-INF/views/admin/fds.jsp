<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Document</title>
    <link rel="stylesheet" href="../../../resources/css/admin/adminCommon.css"/>
    <link rel="stylesheet" href="../../../resources/css/admin/adminMain.css"/>

</head>
<body>
<jsp:include page="adminHeader.jsp"/>
<hr>
<div class="details">
    <jsp:include page="adminSideBar.jsp"/>
    <div class="detail__right">
        <h2 class="details____title">이상소비서비스관리</h2>
        <div class="box-container">
            <div class="info-box">
                <div class="info-content">현재 하나카드 이용자수</div>
            </div>
            <div class="info-box">
                <div class="info-content">신청</div>
            </div>
            <div class="info-box">
                <div class="info-content">차단된결제건수</div>
            </div>

        </div>
        <div class="table-container">
            <h3>신규 신청</h3>
            <br>
            <!-- 테이블로 데이터베이스 데이터 표시 -->
            <table class="data-table">
                <thead>
                <tr>
                    <th>ID</th>
                    <th>대출명</th>
                    <th>대출종류</th>
                    <th>신청일자</th>
                    <th>진행상황</th>
                    <!-- 필요한 다른 컬럼들도 여기에 추가 -->
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${loans}" var="loan">
                    <tr onclick="window.location.href='/loanDetails?id=${loan.id}';" style="cursor: pointer;">
                        <td>${loan.id}</td>
                        <td>${loan.newLoanName}</td>

                        <td>신용대출 갈아타기</td>
                        <td>${loan.applicationDate}</td>
                        <td>${loan.newLoanStatus}</td>
                        <!-- 필요한 다른 컬럼들의 데이터도 여기에 추가 -->
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>

    </div>
</div>
</body>
</html>