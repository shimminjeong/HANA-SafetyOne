<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Document</title>
    <link rel="stylesheet" href="../../../resources/css/admin/adminCommon.css"/>
    <link rel="stylesheet" href="../../../resources/css/admin/adminFds.css"/>
    <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>

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
                <div class="info-content">서비스사용자관리</div>
            </div>
            <div class="info-box">
                <div class="info-content">이상소비데이터관리</div>
            </div>

        </div>

        <div class="table-container">
            <h3>신규 신청</h3>
            <br>
            <!-- 테이블로 데이터베이스 데이터 표시 -->
            <span>*학습시작 버튼을 누르고 학습이 완료된 후 해당 고객은 서비스를 이용할 수 있습니다.</span>
            <table class="data-table">
                <thead>
                <tr>
                    <th>서비스 신청일자</th>
                    <th>cardId</th>
                    <th>이름</th>
                    <th>서비스 시작일자</th>
                    <th>서비스상태</th>
                    <!-- 필요한 다른 컬럼들도 여기에 추가 -->
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${FdsMemberList}" var="fdsmember">
                    <%--                    <tr onclick="window.location.href='/loanDetails?id=${loan.id}';" style="cursor: pointer;">--%>
                    <tr>
                        <td>${fn:split(fdsmember.serRegDate, ' ')[0]}</td>
                        <td>${fdsmember.cardId}</td>
                        <td>${fdsmember.member.name}</td>
                        <td>${fn:split(fdsmember.learningDate, ' ')[0]}</td>
                        <!-- JSTL if문 -->
                        <td>
                            <c:if test="${fdsmember.serviceStatus eq '학습대기'}">
                                <button onclick="learningData('${fdsmember.cardId}')">학습시작</button>
                            </c:if>
                            <c:if test="${fdsmember.serviceStatus eq '학습완료'}">
                                ${fdsmember.serviceStatus}
                            </c:if>
                        </td>

                        <!-- 필요한 다른 컬럼들의 데이터도 여기에 추가 -->
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>

    </div>
</div>
<script>
    function learningData(cardId) {
        console.log("cardId"+cardId)

        // AJAX로 데이터 전송
        $.ajax({
            type: "POST", // 또는 POST, PUT, DELETE 등 다른 HTTP 메서드
            url: "/admin/learning",
            data: {cardId: cardId},
            success: function(response) {
                alert(response);
                window.location.href = "/admin/fds";
            },
            error: function(error) {
                console.error("Error:", error);
            }
        });
    }

</script>
</body>
</html>