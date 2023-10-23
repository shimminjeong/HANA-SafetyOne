<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <%--    <link href="../../../resources/css/regionspot.css" rel="stylesheet">--%>
    <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
    <script src="../../../resources/js/region.js" type="text/javascript"></script>
    <link href="../../../resources/css/member/safetyCardCommon.css" rel="stylesheet">
    <link href="../../../resources/css/member/region.css" rel="stylesheet">
</head>
<body>

<%@ include file="../include/header.jsp" %>
<div class="big-header" style="margin-left: 585px;">안심서비스 설정</div>
<div class="big-container">
    <div class="details__left">
        <ul class="menu">
            <li class="menu__item" style="background-color:#c7dbec;">
                <a href="/mypage" class="menu__link">
                    STEP1 지역
                </a>
            </li>
            <li class="menu__item">
                <a href="/mypageCardHistory" class="menu__link">
                    STEP2 시간
                </a>
            </li>
            <li class="menu__item">
                <a href="/mypageReport" class="menu__link">
                    STEP3 업종
                </a>
            </li>
        </ul>
    </div>
    <div class="details">
        <div class="subcontainer">
            <div class="detail__right">
                <%--            <div class="detail-container">--%>
                <div class="right-info"><h2><span style="color: green">허용</span> 지역 선택</h2></div>
                <%--                <div class="right-info3"></div>--%>
                <div class="right-info2"><h4 style="color: red">※ 선택 외의 지역은 결제가 차단됩니다.</h4>
                    <button class="chart-name" onclick="openChartRegionModal()">지역별 나의 소비 확인</button>
                </div>

                <div class="right-subcontainer">
                    <div class="select-region-div">
                        <div class="select-region-div-header">
                            거래를 허용할 지역을 선택하세요.
                        </div>
                        <div class="select-region-div-button">
                            <button class="seoul-btn" onclick="selectRegion(this); changeMapImage(this);"
                                    data-img="../../../resources/img/map_1.png" value="${regionList[0]}">서울
                            </button>
                            <button class="gyeonggi-btn" onclick="selectRegion(this); changeMapImage(this);"
                                    data-img="../../../resources/img/map_2.png" value="${regionList[1]}">경기
                            </button>
                            <button class="incheon-btn" onclick="selectRegion(this); changeMapImage(this);"
                                    data-img="../../../resources/img/map_3.png" value="${regionList[2]}">인천
                            </button>
                            <button class="gangwon-btn" onclick="selectRegion(this)" value="${regionList[3]}">강원
                            </button>
                            <button class="chungnam-btn" onclick="selectRegion(this)" value="${regionList[4]}">충남
                            </button>
                            <button class="daejeon-btn" onclick="selectRegion(this)" value="${regionList[5]}">대전
                            </button>
                            <button class="chungbuk-btn" onclick="selectRegion(this)" value="${regionList[6]}">충북
                            </button>
                            <button class="sejong-btn" onclick="selectRegion(this)" value="${regionList[7]}">세종</button>
                            <button class="busan-btn" onclick="selectRegion(this)" value="${regionList[8]}">부산</button>
                            <button class="ulsan-btn" onclick="selectRegion(this)" value="${regionList[9]}">울산</button>
                            <button class="daegu-btn" onclick="selectRegion(this)" value="${regionList[10]}">대구</button>
                            <button class="gyeongbuk-btn" onclick="selectRegion(this)" value="${regionList[11]}">경북
                            </button>
                            <button class="gyeonggnam-btn" onclick="selectRegion(this)" value="${regionList[12]}"> 경남
                            </button>
                            <button class="jeollanam-btn" onclick="selectRegion(this)" value="${regionList[13]}">전남
                            </button>
                            <button class="gwangju-btn" onclick="selectRegion(this)" value="${regionList[14]}">광주
                            </button>
                            <button class="jeollabuk-btn" onclick="selectRegion(this)" value="${regionList[15]}">전북
                            </button>
                            <button class="jejudo-btn" onclick="selectRegion(this)" value="${regionList[16]}">제주
                            </button>
                        </div>
                    </div>
                    <div class="map-div">
                        <img id="mapImage" src="../../../resources/img/map_fix.png">
                    </div>
                </div>

                <%--                <div class="sub-main-content2">--%>
                <%--                    <div class="chart" onclick="openChartRegionModal()">--%>
                <%--                        <img src="../../../resources/img/pin.png">--%>
                <%--                        <div class="chart-name">지역별 나의 소비 확인</div>--%>
                <%--                    </div>--%>
                <%--                    <div class="myselect">--%>
                <%--                        <div class="myselect-head">선택한 결제 허용지역</div>--%>
                <%--                        <div>--%>
                <%--                            <span class="myselect-region-ok-content"></span><span class="select-alarm"></span>--%>
                <%--                        </div>--%>
                <%--                    </div>--%>
                <%--                </div>--%>
                <%--            </div>--%>
                <%--            <div class="reg-btn-div">--%>
                <%--                <button class="reg-Btn" onclick="registerRegion()">다음</button>--%>
                <%--            </div>--%>
                <%--        </div>--%>
                <%--    </div>--%>
                <div class="myselect-option">
                    <span class="myselect-region-ok-content"></span><span class="select-alarm"></span>
                </div>

            </div>

            <%--        </div>--%>
        </div>
        <div class="btn-div">
            <button class="prev-Btn" onclick="window.location.href='#'">이전</button>
            <button class="next-Btn" onclick="registerRegion()">다음</button>
        </div>
    </div>
</div>
<div class="modal">
    <div id="myRegionmodal">
        <span class="close-btn" onclick="closeChartRegionModal()">&#10006;</span>
        <div class="chart-head">최근 3개월 지역별 이용 빈도</div>
        <div class="chart-div">
            <canvas id="myRegionCntChart"></canvas>
        </div>
        <div class="chart-info">주 거래 지역 : <span class="recomend"></span></div>
    </div>
</div>
</body>
</html>
