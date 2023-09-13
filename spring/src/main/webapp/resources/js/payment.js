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

        clickMarkerPlace(data);

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

        console.log("displayPlaces", places[i]);

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
        (function (marker, title, address_name, category_name) {
            kakao.maps.event.addListener(marker, 'mouseover', function () {
                displayInfowindow(marker, title, address_name, category_name);
            });

            kakao.maps.event.addListener(marker, 'mouseout', function () {
                infowindow.close();
            });

            itemEl.onmouseover = function () {
                displayInfowindow(marker, title, address_name, category_name);
            };

            itemEl.onmouseout = function () {
                infowindow.close();
            };


        })(marker, places[i].place_name, places[i].address_name, places[i].category_name);

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

    // 마커 클릭 이벤트 리스너 추가
    kakao.maps.event.addListener(marker, 'click', function () {
        // 여기서 marker의 title과 다른 속성들에 접근 가능
        clickPlace(marker, idx, title);
    });

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
function displayInfowindow(marker, title, address, category_name) {

    // 나의 db업종에 맞도록 데이터 변환
    var categoryParts = category_name.split(' > ');
    var categorySmall_name;

    if (categoryParts.length = 3) {
        categorySmall_name = categoryParts[2];
        if (categoryParts[1] == '패스트푸드') {
            categorySmall_name = '패스트푸드';
        }
        if (categoryParts[1] == '술집') {
            categorySmall_name = '유흥주점';
        }
    } else if (categoryParts.length = 2) {
        categorySmall_name = categoryParts[1];

    } else if(categoryParts.length = 1){
        categorySmall_name = categoryParts[0];
    }

    if (categorySmall_name == '유흥주점' || categorySmall_name == '나이트,클럽') {
        categorySmall_name = '기타유흥업소';
    }

    if (categorySmall_name == '보석,귀금속') {
        categorySmall_name = '귀금속';
    }


    var content =
        '<div style="padding:7px; z-index:1; max-width: 300px; height: 65px;">' +
        '<div>가게명 : ' + title + '</div>' +
        '<div>주소 : ' + address + '</div>' +
        '<div>카카오업종 : ' + category_name + '</div>' +
        '<div>하나업종 : ' + categorySmall_name + '</div>' +
        '</div>';


    infowindow.setContent(content);
    infowindow.open(map, marker);
}


function clickMarkerPlace(places) {

    // 클릭된 마커와 연관된 장소 정보를 전역 변수에 저장합니다.
    selectedPlace = places;
    return selectedPlace;
}


function clickPlace(marker, idx) {
    console.log("idx", idx);
    console.log("selectedPlace", selectedPlace[idx]);
    selectPlace = selectedPlace[idx];

    // 나의 db업종에 맞도록 데이터 변환
    var categoryParts = selectPlace.category_name.split(' > ');
    var categorySmall_name;

    if (categoryParts.length = 3) {
        categorySmall_name = categoryParts[2];
        if (categoryParts[1] == '패스트푸드') {
            categorySmall_name = '패스트푸드';
        }
        if (categoryParts[1] == '술집') {
            categorySmall_name = '유흥주점';
        }
    } else if (categoryParts.length = 2) {
        categorySmall_name = categoryParts[1];

    } else if(categoryParts.length = 1){
        categorySmall_name = categoryParts[0];
    }

    if (categorySmall_name == '유흥주점' || categorySmall_name == '나이트,클럽') {
        categorySmall_name = '기타유흥업소';
    }

    if (categorySmall_name == '보석,귀금속') {
        categorySmall_name = '귀금속';
    }

    console.log("selectPlace.address_name", selectPlace.address_name)
    console.log("categorySmall_name", categorySmall_name)

    var storeDiv = document.querySelector('.place-store');
    var addressDiv = document.querySelector('.place-address');
    var categoryDiv = document.querySelector('.place-category');
    var phoneDiv = document.querySelector('.place-phone');
    var road_address_nameDiv = document.querySelector('.place-road_address_name');

    storeDiv.textContent = selectPlace.place_name;
    addressDiv.textContent = selectPlace.address_name;
    categoryDiv.textContent = categorySmall_name;
    phoneDiv.textContent = selectPlace.phone;
    road_address_nameDiv.textContent = selectPlace.road_address_name;

}


// 검색결과 목록의 자식 Element를 제거하는 함수입니다
function removeAllChildNods(el) {
    while (el.hasChildNodes()) {
        el.removeChild(el.lastChild);
    }
}


function selectmenu() {
    var modal = document.getElementById("myModal");
    modal.style.display = "block";

    // Get the <span> element that closes the modal
    var span = document.getElementsByClassName("close")[0];

    // When the user clicks on <span> (x), close the modal
    span.onclick = function () {
        modal.style.display = "none";
    }

    // When the user clicks anywhere outside of the modal, close it
    window.onclick = function (event) {
        if (event.target == modal) {
            modal.style.display = "none";
        }
    }
}
