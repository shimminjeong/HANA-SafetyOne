<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <link href="../../../resources/css/payment/payment.css" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
    <script src="../../../resources/js/userOuath.js" type="text/javascript"></script>
</head>

<body>
<script type="text/javascript"
        src="//dapi.kakao.com/v2/maps/sdk.js?appkey=0759a386285f84663503ff0dd087258b&libraries=services"></script>
<script src="../../../resources/js/payment.js" type="text/javascript"></script>

<div class="payment-container">
    <div class="time-container">
<%--        <img src="../../../resources/img/calendar.png">--%>
        <h1 id="current-date"></h1>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<%--        <img src="../../../resources/img/clock1.png">--%>
        <h1 id="current-time"></h1>
    </div>
    <div class="subcontainer">
        <div class="map_wrap">
            <div id="map" style="width:100%;height:100%;overflow:hidden;"></div>
            <div id="menu_wrap" class="bg_white">
                <div class="option">
                    <div>
                        <form onsubmit="searchPlaces(); return false;">
                            키워드 : <input type="text" value="서울역" id="keyword" size="15">
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
                <div class="store-div">
                    <div class="store">상호명</div>
                    <div class="place-store"></div>
                </div>
                <div class="address-div">
                    <div class="address">주소</div>
                    <div class="place-address"></div>
                </div>
                <div class="category-div">
                    <div class="category">업종</div>
                    <div class="place-category"></div>
                </div>
                <div class="price-div">
                    <div class="price">금액</div>
                    <div class="place-price" style="text-align: right"><input style="text-align: right;" type="text" id="price" name="price"
                                                    oninput="formatCurrency(this)"><span class="won-text">원</span></div>
                </div>
                <div class="phone">전화번호
                    <span class="place-phone"></span>
                </div>
                <div class="road_address_name">도로명주소
                    <span class="place-road_address_name"></span>
                </div>
                <div class="cardNum-div">
                    <div class="cardNum">카드선택</div>
                    <div class="cardId-info">
                        <div class="allow-img-prev"><a class="prev" onclick="plusSlides(-1)">
                            <img src="../../../resources/img/previous.png" alt="Previous Slide">
                        </a>
                        </div>
                        <div class="slideshow-container">
                            <c:forEach items="${cards}" var="card" varStatus="loop">
                                <div class="mySlides" onclick="selectCardId('${card.cardId}')">
                                    <div class="cardNametext" style="margin-top: 0px;">${card.cardName}</div>
                                    <img src="../../resources/img/${card.cardName}.png"
                                         data-card-id="${card.cardId}">
                                    <div class="cardIdtext">${card.cardId}</div>
                                </div>
                            </c:forEach>
                        </div>
                        <div class="allow-img-next"><a class="next" onclick="plusSlides(1)">
                            <img src="../../../resources/img/next.png" alt="Next Slide">
                        </a>
                        </div>
                    </div>
                </div>
            </div>
            <button class="paymentRequest" onclick="paymentRequest()">결제</button>
        </div>
    </div>
</div>
<%
    String username = (String) session.getAttribute("name");
    String phone = (String) session.getAttribute("phone");
%>
<span class="user-name" style="display: none;"><%= username %></span>
<span class="user-phone" style="display: none;"><%= phone %></span>
<script>
    let currentCardId = '';

    let slideIndex = 1;
    showSlides(slideIndex);

    function plusSlides(n) {
        showSlides(slideIndex += n);
    }

    // Thumbnail image controls
    function currentSlide(n) {
        showSlides(slideIndex = n);
    }

    function showSlides(n) {
        let i;
        let slides = document.getElementsByClassName("mySlides");

        if (n > slides.length) {
            slideIndex = 1
        }
        if (n < 1) {
            slideIndex = slides.length
        }
        for (i = 0; i < slides.length; i++) {
            slides[i].style.display = "none";
        }
        slides[slideIndex - 1].style.display = "block";

        let slide = slides[slideIndex - 1];
        currentCardId = slide.querySelector(".cardIdtext").textContent;

        console.log(currentCardId);

    }

    function formatCurrency(inputElem) {

        let caretPosition = inputElem.selectionStart - (inputElem.value.length - inputElem.value.replace(/\D/g, '').length);
        inputElem.value = inputElem.value.replace(/\D/g, '');

        inputElem.value = parseFloat(inputElem.value).toLocaleString('en-US');

        inputElem.setSelectionRange(caretPosition, caretPosition);
    }



    function getToday() {
        var date = new Date();
        date.setDate(date.getDate());
        var year = date.getFullYear();
        var month = ("0" + (1 + date.getMonth())).slice(-2);
        var day = ("0" + date.getDate()).slice(-2);

        return year + "-" + month + "-" + day;
    }

    document.getElementById("current-date").innerText = getToday();

    const currentTime = document.getElementById('current-time');


    setInterval(() => {
        const date = new Date();
        date.setHours(date.getHours());
        date.setMinutes(date.getMinutes());
        currentTime.innerHTML = date.toLocaleTimeString();
    }, 1000);



    function paymentRequest() {
        var username = $('.user-name').text();
        var userPhone = $('.user-phone').text();
        var store = $('.place-store').text();
        var address = $('.place-address').text();
        var category = $('.place-category').text();
        var storePhoneNumber = $('.place-phone').text();
        var road_address_name = $('.place-road_address_name').text();
        var amountStr = $('#price').val().replace(/,/g, '');
        var amount = parseInt(amountStr);
        address = address.replace("경기", "경기도");
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

        console.log("currentTime", currentTime.textContent);
        console.log("address", address);


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

        console.log(formattedTime);

        var data = {
            cardId: currentCardId,
            store: store,
            address: address,
            paymentDate: dateTextContent,
            time: formattedTime,
            categorySmall: category,
            storePhoneNumber: storePhoneNumber,
            road_address_name: road_address_name,
            // product: product,
            amount: amount
        };

        console.log("cardId보내는거"+currentCardId);
        console.log("store"+store);
        console.log("address"+address);
        console.log("paymentDate"+dateTextContent);
        console.log("time"+formattedTime);
        console.log("categorySmall"+category);
        console.log("storePhoneNumber"+storePhoneNumber);
        console.log("road_address_name"+road_address_name);
        console.log("amount"+amount);

        var queryParams = $.param(data);

        $.ajax({
            type: 'POST',
            url: '/payment/requestPayment',
            data: JSON.stringify(data),
            contentType: 'application/json',
            dataType: 'text',
            success: function (response) {

                console.log("response", response);

                if (response === "거래승인") {
                    window.location.href = "/payment/paymentApproval?" + queryParams;
                } else if (response === "거래미승인") {
                    sendNotApproval(currentCardId,store,amount,dateTextContent,formattedTime,username,userPhone)
                    window.location.href = "/payment/paymentNotApproval?"+ queryParams;
                } else {
                    alert(response);
                }
            },
            error: function (error) {
                console.error('Error:', error);
            }
        });

    }


    //kakao map api
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
