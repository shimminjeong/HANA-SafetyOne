<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <%--    <link href="../../../resources/css/regionspot.css" rel="stylesheet">--%>
    <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/chart.js@3.5.1/dist/chart.min.js"></script>
    <link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
    <script src="../../../resources/js/region.js" type="text/javascript"></script>
    <link href="../../../resources/css/safetyCardCommon.css" rel="stylesheet">
    <link href="../../../resources/css/region.css" rel="stylesheet">
</head>
<body>
<%@ include file="../include/header.jsp" %>
<div class="container">
    <div class="main">
        <h2>안심카드설정</h2>
        <h3>대상카드</h3>
        <hr>
        <div class="card-info">
            <div class="card-details">
                <span>본인 | </span>
                <span><%=session.getAttribute("cardId")%></span>
            </div>
            <div class="card-type">
                <span>알뜰교통 S20(체크)</span>
            </div>
        </div>
        <div class="sub-container">
            <div class="sub-info">
                결제를 허용할 지역을 선택하세요
            </div>
            <div class="sub-main">
                <div class="sub-main-content1">
                    <div class="spot">
                        <img src="../../../resources/img/map1.png">
                        <button class="seoul-btn" onclick="selectRegion(this)" value="${regionList[0]}">서울</button>
                        <button class="gyeonggi-btn" onclick="selectRegion(this)" value="${regionList[1]}">경기도</button>
                        <button class="incheon-btn" onclick="selectRegion(this)" value="${regionList[2]}">인천</button>
                        <button class="gangwon-btn" onclick="selectRegion(this)" value="${regionList[3]}">강원도</button>
                        <button class="chungnam-btn" onclick="selectRegion(this)" value="${regionList[4]}">충청남도</button>
                        <button class="daejeon-btn" onclick="selectRegion(this)" value="${regionList[5]}">대전</button>
                        <button class="chungbuk-btn" onclick="selectRegion(this)" value="${regionList[6]}">충청북도</button>
                        <button class="sejong-btn" onclick="selectRegion(this)" value="${regionList[7]}">세종</button>
                        <button class="busan-btn" onclick="selectRegion(this)" value="${regionList[8]}">부산</button>
                        <button class="ulsan-btn" onclick="selectRegion(this)" value="${regionList[9]}">울산</button>
                        <button class="daegu-btn" onclick="selectRegion(this)" value="${regionList[10]}">대구</button>
                        <button class="gyeongbuk-btn" onclick="selectRegion(this)" value="${regionList[11]}">경상북도
                        </button>
                        <button class="gyeonggnam-btn" onclick="selectRegion(this)" value="${regionList[12]}"> 경상남도
                        </button>
                        <button class="jeollanam-btn" onclick="selectRegion(this)" value="${regionList[13]}">전라남도
                        </button>
                        <button class="gwangju-btn" onclick="selectRegion(this)" value="${regionList[14]}">광주</button>
                        <button class="jeollabuk-btn" onclick="selectRegion(this)" value="${regionList[15]}">전라북도
                        </button>
                        <button class="jejudo-btn" onclick="selectRegion(this)" value="${regionList[16]}">제주도</button>
                    </div>
                </div>
                <div class="sub-main-content2">
                    <div class="chart" onclick="openChartRegionModal()">
                        <img src="../../../resources/img/pin.png">
                        <div class="chart-name">지역별 나의 소비 확인</div>
                    </div>
                    <div class="myselect">
                        <div class="myselect-head">선택한 결제 허용지역</div>
                        <div>
                            <span class="myselect-region-ok-content"></span><span class="select-alarm"></span>
                        </div>
                    </div>
                </div>
            </div>
            <div class="reg-btn-div">
                <button class="reg-Btn" onclick="registerRegion()">등록</button>
            </div>
        </div>
    </div>

    <div class="modal">
        <div id="myRegionmodal">
            <div class="chart-head">최근 3개월간 나의 소비</div>
            <canvas id="myRegionCntChart"></canvas>
            <span class="close" onclick="closeChartRegionModal()">&times;</span>
        </div>
    </div>
</div>
</body>
</html>
