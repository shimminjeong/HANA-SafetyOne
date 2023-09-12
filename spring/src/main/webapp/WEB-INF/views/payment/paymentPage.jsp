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
                        <button type="submit">검색하기</button>
                    </form>
                </div>
            </div>
            <hr>
            <ul id="placesList"></ul>
            <div id="pagination"></div>
        </div>
    </div>


    <%--    알림문자보내기--%>
    <div class="form-group">
        <label for="phoneNumber">전화번호</label>
        <div class="input-wrapper">
            <input type="tel" id="phoneNumber" name="phoneNumber" placeholder="010XXXXXXXX" required maxlength="11">
            <!-- <button type="submit" id="sendSmsButton">인증번호 전송</button> -->
            <button onclick="sendSmsRequest()" class="button">인증번호 전송</button>
        </div>
    </div>

    <input type="tel" id="userOuathNum" name="userOuathNum" placeholder="인증번호입력" required maxlength="5">
    <button onclick="verifySmsCode()" class="button">인증번호 전송</button>
    <div id="result"></div>

    <script>

        // 사용자 정보 입력하면 무작위로 본인인증번호 보냄
        function sendSmsRequest() {
            const phoneNumber = document.getElementById('phoneNumber').value;

            const ouathNum = String(Math.floor(10000 + Math.random() * 90000));
            console.log("ouathNum", ouathNum);

            const requestData = {
                recipientPhoneNumber: phoneNumber,
                content: '[하나안심서비스] 하나안심카드서비스 사용을 위해 인증번호 [' + ouathNum + '] 를 입력하세요.',
                ouathNum: ouathNum // 생성한 무작위 숫자 할당
            };

            $.ajax({
                url: '/sms/sendUser',
                type: 'POST',
                contentType: 'application/json',
                data: JSON.stringify(requestData),
                success: function (data) {
                    // 성공적인 응답 처리
                    console.log('서버 응답:', data);
                    // 여기에서 원하는 동작을 수행할 수 있습니다.
                },
                error: function () {
                    console.error("사용자에게 인증번호 전송 중 에러");
                }
            });

        }


        // 본인인증 메세지를 받은 사용자가 인증번호를 입력하면 service에서 동일한지 확인한 후 return
        function verifySmsCode() {
            const smsConfirmNum = document.getElementById('userOuathNum').value;

            const resultDiv = document.getElementById('result');

            $.ajax({
                url: '/sms/verify',
                type: 'POST',
                contentType: 'application/json',
                data: JSON.stringify({smsConfirmNum: smsConfirmNum}),
                success: function (data) {
                    // 성공적인 응답 처리
                    console.log('서버 응답:', data);
                    if (data === '본인인증성공') {
                        resultDiv.textContent = '본인인증성공';
                    } else {
                        resultDiv.textContent = '본인인증실패';
                    }
                },
                error: function () {
                    console.error("본인인증인증과정에러");
                }
            });

        }


        // function verifySmsCode() {
        //     const userEnteredCode = document.getElementById('smsCodeInput').value;
        //
        //     // 서버에 사용자가 입력한 코드를 전송하여 검증합니다.
        //     fetch('/sms/verify', {
        //         method: 'POST',
        //         headers: {
        //             'Content-Type': 'application/json'
        //         },
        //         body: JSON.stringify({ code: userEnteredCode })
        //     })
        //         .then(response => response.json())
        //         .then(data => {
        //             if (data.isValid) {
        //                 document.getElementById('verificationStatus').innerText = "본인인증이 완료되었습니다.";
        //             } else {
        //                 document.getElementById('verificationStatus').innerText = "인증번호가 잘못되었습니다. 다시 시도해주세요.";
        //             }
        //         })
        //         .catch(error => {
        //             console.error('Error verifying SMS code:', error);
        //             document.getElementById('verificationStatus').innerText = "인증번호 검증 중 오류가 발생했습니다.";
        //         });
        // }


        function sendSmsOuathRequest() {

            const requestData = {
                to: '01050437629'
            };

            // 서버로 POST 요청을 보냅니다.
            fetch('/sms/send', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify(requestData)
            })
                .then(response => response.json())
                .then(data => {
                    // 서버에서 받은 응답을 처리합니다.
                    console.log(data);
                    // 여기에서 원하는 동작을 수행할 수 있습니다.
                })
                .catch(error => {
                    // 오류가 발생한 경우 처리합니다.
                    console.error('Error sending SMS request:', error);
                    alert('인증번호 전송 중 오류가 발생했습니다.');
                });
        }
    </script>


    <script>

        const time = document.getElementById('current-time'); // id가 'current-time'인 요소

        // 1초마다 현재 시각 업데이트
        setInterval(() => {
            const date = new Date(); // 새로운 Date 객체 생성
            time.innerHTML = date.toLocaleTimeString();
        }, 1000);


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

        // 키워드로 장소를 검색합니다
        searchPlaces();

        // 키워드 검색을 요청하는 함수입니다
        function searchPlaces() {

            var keyword = document.getElementById('keyword').value;

            if (!keyword.replace(/^\s+|\s+$/g, '')) {
                alert('키워드를 입력해주세요!');
                return false;
            }

            // 장소검색 객체를 통해 키워드로 장소검색을 요청합니다
            ps.keywordSearch(keyword, placesSearchCB);
        }

        // 장소검색이 완료됐을 때 호출되는 콜백함수 입니다
        function placesSearchCB(data, status, pagination) {
            if (status === kakao.maps.services.Status.OK) {
                console.log("data: " + data);


                // 정상적으로 검색이 완료됐으면
                // 검색 목록과 마커를 표출합니다
                displayPlaces(data);

                // 페이지 번호를 표출합니다
                displayPagination(pagination);

            } else if (status === kakao.maps.services.Status.ZERO_RESULT) {

                alert('검색 결과가 존재하지 않습니다.');
                return;

            } else if (status === kakao.maps.services.Status.ERROR) {

                alert('검색 결과 중 오류가 발생했습니다.');
                return;

            }
        }

        // 검색 결과 목록과 마커를 표출하는 함수입니다
        function displayPlaces(places) {

            var listEl = document.getElementById('placesList'),
                menuEl = document.getElementById('menu_wrap'),
                fragment = document.createDocumentFragment(),
                bounds = new kakao.maps.LatLngBounds(),
                listStr = '';

            // 검색 결과 목록에 추가된 항목들을 제거합니다
            removeAllChildNods(listEl);

            // 지도에 표시되고 있는 마커를 제거합니다
            removeMarker();

            for (var i = 0; i < places.length; i++) {

                console.log(places[i])


                // 마커를 생성하고 지도에 표시합니다
                var placePosition = new kakao.maps.LatLng(places[i].y, places[i].x),
                    marker = addMarker(placePosition, i),
                    itemEl = getListItem(i, places[i]); // 검색 결과 항목 Element를 생성합니다

                // 검색된 장소 위치를 기준으로 지도 범위를 재설정하기위해
                // LatLngBounds 객체에 좌표를 추가합니다
                bounds.extend(placePosition);

                // 마커와 검색결과 항목에 mouseover 했을때
                // 해당 장소에 인포윈도우에 장소명을 표시합니다
                // mouseout 했을 때는 인포윈도우를 닫습니다
                (function (marker, title) {
                    kakao.maps.event.addListener(marker, 'mouseover', function () {
                        displayInfowindow(marker, title);
                    });

                    kakao.maps.event.addListener(marker, 'mouseout', function () {
                        infowindow.close();
                    });

                    itemEl.onmouseover = function () {
                        displayInfowindow(marker, title);
                    };

                    itemEl.onmouseout = function () {
                        infowindow.close();
                    };
                })(marker, places[i].place_name);

                fragment.appendChild(itemEl);
            }

            // 검색결과 항목들을 검색결과 목록 Element에 추가합니다
            listEl.appendChild(fragment);
            menuEl.scrollTop = 0;

            // 검색된 장소 위치를 기준으로 지도 범위를 재설정합니다
            map.setBounds(bounds);
        }

        // 검색결과 항목을 Element로 반환하는 함수입니다
        function getListItem(index, places) {

            var el = document.createElement('li'),
                itemStr = '<span class="markerbg marker_' + (index + 1) + '"></span>' +
                    '<div class="info">' +
                    '   <h5>' + places.place_name + '</h5>';

            if (places.road_address_name) {
                itemStr += '    <span>' + places.road_address_name + '</span>' +
                    '   <span class="jibun gray">' + places.address_name + '</span>';
            } else {
                itemStr += '    <span>' + places.address_name + '</span>';
            }

            itemStr += '  <span class="tel">' + places.phone + '</span>' +
                '</div>';

            el.innerHTML = itemStr;
            el.className = 'item';

            return el;
        }

        // 마커를 생성하고 지도 위에 마커를 표시하는 함수입니다
        function addMarker(position, idx, title) {
            var imageSrc = 'https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png', // 마커 이미지 url, 스프라이트 이미지를 씁니다
                imageSize = new kakao.maps.Size(36, 37),  // 마커 이미지의 크기
                imgOptions = {
                    spriteSize: new kakao.maps.Size(36, 691), // 스프라이트 이미지의 크기
                    spriteOrigin: new kakao.maps.Point(0, (idx * 46) + 10), // 스프라이트 이미지 중 사용할 영역의 좌상단 좌표
                    offset: new kakao.maps.Point(13, 37) // 마커 좌표에 일치시킬 이미지 내에서의 좌표
                },
                markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imgOptions),
                marker = new kakao.maps.Marker({
                    position: position, // 마커의 위치
                    image: markerImage
                });

            marker.setMap(map); // 지도 위에 마커를 표출합니다
            markers.push(marker);  // 배열에 생성된 마커를 추가합니다

            return marker;
        }

        // 지도 위에 표시되고 있는 마커를 모두 제거합니다
        function removeMarker() {
            for (var i = 0; i < markers.length; i++) {
                markers[i].setMap(null);
            }
            markers = [];
        }

        // 검색결과 목록 하단에 페이지번호를 표시는 함수입니다
        function displayPagination(pagination) {
            var paginationEl = document.getElementById('pagination'),
                fragment = document.createDocumentFragment(),
                i;

            // 기존에 추가된 페이지번호를 삭제합니다
            while (paginationEl.hasChildNodes()) {
                paginationEl.removeChild(paginationEl.lastChild);
            }

            for (i = 1; i <= pagination.last; i++) {
                var el = document.createElement('a');
                el.href = "#";
                el.innerHTML = i;

                if (i === pagination.current) {
                    el.className = 'on';
                } else {
                    el.onclick = (function (i) {
                        return function () {
                            pagination.gotoPage(i);
                        }
                    })(i);
                }

                fragment.appendChild(el);
            }
            paginationEl.appendChild(fragment);
        }

        // 검색결과 목록 또는 마커를 클릭했을 때 호출되는 함수입니다
        // 인포윈도우에 장소명을 표시합니다
        function displayInfowindow(marker, title) {
            var content = '<div style="padding:5px;z-index:1;">' + title + '</div>';

            infowindow.setContent(content);
            infowindow.open(map, marker);
        }

        // 검색결과 목록의 자식 Element를 제거하는 함수입니다
        function removeAllChildNods(el) {
            while (el.hasChildNodes()) {
                el.removeChild(el.lastChild);
            }
        }
    </script>
</div>
</body>
</html>
