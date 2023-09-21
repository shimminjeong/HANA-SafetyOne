<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <link href="../../../resources/css/payment.css" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
</head>

<body>
<script type="text/javascript"
        src="//dapi.kakao.com/v2/maps/sdk.js?appkey=0759a386285f84663503ff0dd087258b&libraries=services"></script>
<script src="../../../resources/js/payment.js" type="text/javascript"></script>

<style>
    #logo{
        display: flex;
        align-items: center;
        justify-content: center;
    }

    a {
        font-size: 25px;
        text-align: center;
        padding: 12px 12px;
        text-decoration: none;
        color: black;
    }
</style>

<div class="payment-container">
    <div id="logo">
        <img class="imgLogo" src="../../resources/img/logo.png" height="60">
        <a class="nameLogo" href="/">SafetyOne</a>
    </div>
    <div class="time-container">
        <img src="../../../resources/img/calendar.png">
        <h1 id="current-date"></h1>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <img src="../../../resources/img/clock1.png">
        <h1 id="current-time"></h1>
    </div>
    <div class="map_wrap">
        <div id="map" style="width:100%;height:100%;overflow:hidden;"></div>
        <div id="menu_wrap" class="bg_white">
            <div class="option">
                <div>
                    <form onsubmit="searchPlaces(); return false;">
                        키워드 : <input type="text" value="이태원 맛집" id="keyword" size="15">
                        <button type="submit">검색</button>
                    </form>
                </div>
            </div>
            <hr>
            <ul id="placesList"></ul>
            <div id="pagination"></div>
        </div>
    </div>
    <div class="payment-subcontainer">
        <div class="payment-info-box">
            <div class="store">상호명 :
                <span class="place-store"></span>
            </div>
            <div class="address">주소 :
                <span class="place-address"></span>
            </div>
            <div class="category">업종 :
                <span class="place-category"></span>
            </div>
            <div class="phone">전화번호 :
                <span class="place-phone"></span>
            </div>
            <div class="road_address_name">도로명주소 :
                <span class="place-road_address_name"></span>
            </div>
<%--            <div class="product">상품명 :--%>
<%--                <span class="place-product">망고스무디</span>--%>
<%--            </div>--%>
            <div class="price"><p>금액 :&nbsp&nbsp</p>
                <p><input type="text" id="price" name="price"></p>
            </div>
            <div class="cardId">카드아이디
                <span class="place-cardId">6155-7952-7748-1647</span>
            </div>
        </div>
        <div class="menu">
            <button class="selectmenu" onclick="selectmenu()">상품선택</button>
        </div>
    </div>
    <button class="paymentRequest" onclick="paymentRequest()">결제</button>
</div>

<div id="myModal" class="modal">
    <div class="modal-content">
        <span class="close">&times;</span>
        <p>상품을 선택하세요</p>
        <div class="menu">
<%--            메뉴사진과 가격 넣기--%>
        </div>
    </div>
</div>

<script>


    function getToday(){
        var date = new Date();
        var year = date.getFullYear();
        var month = ("0" + (1 + date.getMonth())).slice(-2);
        var day = ("0" + date.getDate()).slice(-2);

        return year + "-" + month + "-" + day;
    }

    document.getElementById("current-date").innerText = getToday();

    const currentTime = document.getElementById('current-time'); // id가 'current-time'인 요소

    // 1초마다 현재 시각 업데이트
    setInterval(() => {
        const date = new Date(); // 새로운 Date 객체 생성
        currentTime.innerHTML = date.toLocaleTimeString();
    }, 1000);


    function paymentRequest() {

        var cardId = $('.place-cardId').text();
        var store = $('.place-store').text();
        var address = $('.place-address').text();
        var category = $('.place-category').text();
        var storePhoneNumber = $('.place-phone').text();
        var road_address_name = $('.place-road_address_name').text();
        // var product = $('.place-product').text();
        var amount = $('#price').val();
        address = address.replace("경기", "제주도");
        address = address.replace("서울", "서울특별시");
        address = address.replace("인천", "인천광역시");
        address = address.replace("강원특별자치도", "강원도");
        address = address.replace("대전", "대전광역시");
        address = address.replace("충북", "충청북도");
        address = address.replace("충남", "충청남도");
        address = address.replace("부산", "부산광역시");
        address = address.replace("울산", "울산광역시");
        address = address.replace("대구", "대구광역시");
        address = address.replace("경북", "경상북도");
        address = address.replace("경남", "경상남도");
        address = address.replace("전남", "전라남도");
        address = address.replace("광주", "광주광역시");
        address = address.replace("전북", "전라북도");
        address = address.replace("제주특별자치도", "제주도");

        console.log("currentTime",currentTime.textContent);
        console.log("address",address);


        var dateTextContent = document.getElementById("current-date").textContent;
        var timeTextContent = currentTime.textContent;



        var timeParts = timeTextContent.split(' ');

        var time = timeParts[1].split(':');
        var hours = parseInt(time[0]);
        var minutes = time[1];
        var seconds = time[2];

        if (timeParts[0] === "오후") {
            hours += 12;
        }

        if (hours === 24) {
            hours = 0;
        }

        var formattedTime = hours.toString().padStart(2, '0') + ":" + minutes + ":" + seconds;

        console.log(formattedTime); // 결과 출력

        var data = {
            cardId : cardId,
            store: store,
            address: address,
            paymentDate:dateTextContent,
            time : formattedTime,
            categorySmall: category,
            storePhoneNumber: storePhoneNumber,
            road_address_name: road_address_name,
            // product: product,
            amount: amount
        };

        var queryParams = $.param(data);

        $.ajax({
            type: 'POST',
            url: '/payment/requestPayment',
            data: JSON.stringify(data),
            contentType: 'application/json',
            dataType: 'text',
            success: function(response) {
                // 서버 응답 처리
                // alert(response.message);

                console.log("response",response);

                // 응답 메시지가 "거래승인"일 경우 리다이렉트
                if (response === "거래승인") {
                    window.location.href = "/payment/paymentApproval?"+queryParams;
                }
                else if (response === "거래미승인") {
                    alert("거래미승인!");
                    window.location.href = "/payment/paymentNotApproval";
                } else {
                    alert(response);
                }
            },
            error: function(error) {
                console.error('Error:', error);
            }
        });

    }


    //kakao map api
    // 마커를 담을 배열입니다
    var markers = [];

    var mapContainer = document.getElementById('map'), // 지도를 표시할 div
        mapOption = {
            center: new kakao.maps.LatLng(37.566826, 126.9786567), // 지도의 중심좌표
            level: 3 // 지도의 확대 레벨
        };

    // 지도를 생성합니다
    var map = new kakao.maps.Map(mapContainer, mapOption);

    // 장소 검색 객체를 생성합니다
    var ps = new kakao.maps.services.Places();

    // 검색 결과 목록이나 마커를 클릭했을 때 장소명을 표출할 인포윈도우를 생성합니다
    var infowindow = new kakao.maps.InfoWindow({zIndex: 1});

    // 전역 변수 선언
    // place 에 검색 정보들 다 전역변수로 저장
    var selectedPlace = null;
    var selectPlace = null;

    searchPlaces();

</script>
</body>
</html>
