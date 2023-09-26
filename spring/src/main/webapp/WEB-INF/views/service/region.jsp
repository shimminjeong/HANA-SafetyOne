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
<div class="details">
    <h2>안심카드설정</h2>
    <h3>대상카드</h3>
    <div class="lostcard-list hidden">
        <div class="card-list-info">
            <div class="card-list-info-cardid"><%=session.getAttribute("cardId")%>
            </div>
            <div class="card-list-info-name">본인 | &nbsp;
            </div>
            <div class="card-list-info-cardname"><%=session.getAttribute("cardName")%>
            </div>
            <img class="card-img" src="../../../resources/img/cardImg${loop.index + 1}.png">
        </div>
    </div>
    <div class="subcontainer">
        <div class="details__left">
            <ul class="menu">
                <li class="menu__item">
                    <a href="/mypage" class="menu__link">
                                                <div class="menu__icon"><img src="../../../resources/img/pin.png"></div>
                        위치
                    </a>
                </li>
                <li class="menu__item">
                    <a href="/mypageCardHistory" class="menu__link">
                                                <div class="menu__icon"><img src="../../../resources/img/clock1.png"></div>
                        시간
                    </a>
                </li>
                <li class="menu__item">
                    <a href="/mypageReport" class="menu__link">
                                                <div class="menu__icon"><img src="../../../resources/img/categories.png"></div>
                        업종
                    </a>
                </li>
            </ul>
        </div>

        <div class="detail__right">
<%--            <div class="detail-container">--%>
                <div class="right-info"><h2>위치안심</h2></div>
                <div class="right-info2"><h3>거래지역 선택</h3>
                    <div class="chart-name" onclick="openChartRegionModal()">지역별 나의 소비 확인 ></div>
                </div>
                <div class="right-info3" style="color: red">※ 선택 외의 지역은 결제가 차단됩니다.</div>
                <div class="right-subcontainer">
                    <div class="select-region-div">
                        <div class="select-region-div-header">
                            선택한 지역의 결제만 허용됩니다.
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
                <button class="next-Btn" onclick="registerRegion()">다음</button>
            </div>
<%--        </div>--%>
    </div>

</div>
<div class="modal">
    <div id="myRegionmodal">
        <div class="chart-head">최근 3개월간 나의 소비</div>
        <canvas id="myRegionCntChart"></canvas>
        <span class="close" onclick="closeChartRegionModal()">&times;</span>
    </div>
</div>
<script>


</script>
</body>
</html>
