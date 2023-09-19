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
<style>


</style>
<body>
<jsp:include page="adminHeader.jsp"/>
<hr>
<div class="details">
    <jsp:include page="adminSideBar.jsp"/>
    <div class="detail__right">
        <h2 class="details____title">이상소비서비스관리</h2>
        <div class="box-container">
            <div class="info-box" onclick="window.location.href='/admin/fds'">
                <div class="info-content">서비스사용자관리</div>
            </div>
            <div class="info-box" onclick="window.location.href='/admin/fdsData'">
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
                    <th>아이디</th>
                    <th>카드번호</th>
                    <th>서비스 시작일자</th>
                    <th>서비스상태</th>
                    <!-- 필요한 다른 컬럼들도 여기에 추가 -->
                </tr>
                </thead>

                <tbody>
                <c:forEach items="${FdsMemberList}" var="fdsmember">
                    <tr>

                        <td>${fn:split(fdsmember.serRegDate, ' ')[0]}</td>
                        <td onclick="showMemberDetails('${fdsmember.member.email}','${fdsmember.member.name}','${fdsmember.member.address}','${fdsmember.member.phone}','${fdsmember.member.age}','${fdsmember.member.gender}')" style="cursor: pointer;">${fdsmember.member.email}</td>
                        <td>${fdsmember.cardId}</td>

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
<%--멤버정보띄우는 모달--%>
<div id="memberModal" class="modal">
    <div class="modal-content">
        <span class="close" onclick="closeModal()">&times;</span>
<%--        <table id="memberDetailsTable">--%>
<%--            <!-- 테이블 헤더 -->--%>
<%--            <thead>--%>
<%--            <tr>--%>
<%--                <th>아이디</th>--%>
<%--                <th>이름</th>--%>
<%--                <th>주소</th>--%>
<%--                <th>전화번호</th>--%>
<%--                <th>나이</th>--%>
<%--                <th>성별</th>--%>
<%--            </tr>--%>
<%--            </thead>--%>
<%--            <!-- 테이블 내용 -->--%>
<%--            <tbody>--%>
<%--            <!-- 여기에 행이 삽입될 것입니다 -->--%>
<%--            </tbody>--%>
<%--        </table>--%>
        <table id="memberDetailsTable">
            <!-- 테이블 헤더 -->
            <thead>
            <tr>
                <th colspan="2">회원 세부 정보</th>
            </tr>
            </thead>
            <!-- 테이블 내용 -->
            <tbody>
            <tr>
                <td>아이디</td>
                <td><!-- 아이디 값 --></td>
            </tr>
            <tr>
                <td>이름</td>
                <td><!-- 이름 값 --></td>
            </tr>
            <tr>
                <td>주소</td>
                <td><!-- 주소 값 --></td>
            </tr>
            <tr>
                <td>전화번호</td>
                <td><!-- 전화번호 값 --></td>
            </tr>
            <tr>
                <td>나이</td>
                <td><!-- 나이 값 --></td>
            </tr>
            <tr>
                <td>성별</td>
                <td><!-- 성별 값 --></td>
            </tr>
            <tr>
                <td>이상소비알림횟수</td>
                <td></td>
            </tr>

            </tbody>
        </table>

    </div>
</div>
<script>

    function showMemberDetails(email, name, address, phone, age, gender) {
        console.log("onclick");

        // 모달 표시
        document.getElementById('memberModal').style.display = "block";

        // 테이블 요소 찾기
        const tableBody = document.getElementById('memberDetailsTable').getElementsByTagName('tbody')[0];

        // 기존 행 삭제
        tableBody.innerHTML = "";

        // 데이터와 라벨을 쌍으로 관리
        const dataPairs = [
            { label: "이메일", value: email },
            { label: "이름", value: name },
            { label: "주소", value: address },
            { label: "전화번호", value: phone },
            { label: "나이", value: age },
            { label: "성별", value: gender },
            { label: "이상소비감지횟수", value: 3 }
        ];

        // 각 데이터 쌍에 대해 테이블 행 추가
        dataPairs.forEach(pair => {
            const newRow = tableBody.insertRow(tableBody.rows.length);
            newRow.insertCell(0).innerHTML = pair.label;
            newRow.insertCell(1).innerHTML = pair.value;
        });
    }


    function closeModal() {
        document.getElementById('memberModal').style.display = "none";
    }

    function learningData(cardId) {
        console.log("cardId" + cardId)

        // AJAX로 데이터 전송
        $.ajax({
            type: "POST", // 또는 POST, PUT, DELETE 등 다른 HTTP 메서드
            url: "/admin/learning",
            data: {cardId: cardId},
            success: function (response) {
                alert(response);
                window.location.href = "/admin/fds";
            },
            error: function (error) {
                console.error("Error:", error);
            }
        });
    }

</script>
</body>
</html>