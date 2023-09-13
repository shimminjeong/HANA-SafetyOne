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

<div class="payment-container">
    <div class="time-container">
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
            <div class="product">상품명 :
                <span class="place-product">망고스무디</span>
            </div>
            <div class="price"><p>금액 :&nbsp&nbsp</p>
                <p><input type="text" id="price" name="price"></p>
            </div>
            <div class="cardId">카드아이디
                <span class="place-cardId">6703-3441-8063-2751</span>
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

    const time = document.getElementById('current-time'); // id가 'current-time'인 요소

    // 1초마다 현재 시각 업데이트
    setInterval(() => {
        const date = new Date(); // 새로운 Date 객체 생성
        time.innerHTML = date.toLocaleTimeString();
    }, 1000);


    function paymentRequest() {

        var cardId = $('.place-cardId').text();
        var store = $('.place-store').text();
        var address = $('.place-address').text();
        var category = $('.place-category').text();
        var storePhoneNumber = $('.place-phone').text();
        var road_address_name = $('.place-road_address_name').text();
        var product = $('.place-product').text();
        var amount = $('#price').val();

        console.log("time",time.textContent);


        var data = {
            cardId : cardId,
            store: store,
            address: address,
            time : time.textContent,
            category: category,
            storePhoneNumber: storePhoneNumber,
            road_address_name: road_address_name,
            product: product,
            amount: amount
        };

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

                    window.location.href = "/payment/paymentApproval";
                }
                else if (response === "거래미승인") {
                    alert("거래미승인!");
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
