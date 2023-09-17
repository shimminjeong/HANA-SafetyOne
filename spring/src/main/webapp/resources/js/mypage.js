// Next/previous controls
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

    let currentSlide = slides[slideIndex - 1];
    let currentCardId = currentSlide.querySelector(".cardIdtext").textContent;

    sendCardIdToServer(currentCardId);
    console.log(currentCardId)

}

function imageClicked(imgElement) {
    // data-card-id 속성에서 cardId를 가져옵니다.
    var cardId = imgElement.getAttribute('data-card-id');

    // 원하는 URL 경로로 리디렉션합니다.
    // 예: /controllerPath/{cardId}
    window.location.href = '/cardChart/' + cardId;
}


var inChart;  // 함수 외부에 선언
var deChart;  // 함수 외부에 선언
var monChart;  // 함수 외부에 선언
var weeChart;  // 함수 외부에 선언


function sendCardIdToServer(cardId) {
    console.log(cardId);
    $.ajax({
        type: "POST",
        url: "/cardinfo",
        data: JSON.stringify({cardId: cardId}),
        contentType: 'application/json',
        success: function (data) {
            var differenceValue = data.difference;
            var monthChart = data.monthData;
            var weekChart = data.weekData;
            var increase = data.increaseList;
            var decrease = data.decreaseList;
            var increaseChart = data.increaseData;
            var decreaseChart = data.decreaseData;

            var increasedOrDecreased = "<span class='increased'>증가</span>";

            if (differenceValue < 0) {
                increasedOrDecreased = "<span class='decreased'>감소</span>";
                differenceValue = Math.abs(differenceValue); // 음수 기호를 제거
            }

            $("#totalAmount").html("<strong>" + differenceValue + "</strong>" + "원 " + increasedOrDecreased);

            $("#increase").html("<strong>" + increase.categorySmall + "</strong>" + " 지출이 지날달 보다 <strong>" + increase.diffAmount + "</strong>원 늘었어요!");
            $("#decrease").html("<strong>" + decrease.categorySmall + "</strong>" + " 지출이 지날달 보다 <strong>" + Math.abs(decrease.diffAmount) + "</strong>원 줄었어요!");


            // 서버에서 받은 카드 히스토리 정보를 테이블에 추가
            var tableBody = $("#cardHistoryTable tbody");
            tableBody.empty(); // 기존 내용 삭제

            data.cardHistoryList.forEach(function (history) {
                var row = "<tr><td>" + history.cardId + "<td>" + history.categorySmall + "</td><td>" + history.store + "</td><td>" + history.cardHisDate + "</td><td>" + history.amount + "</td></tr>";
                tableBody.append(row);
            });
        },
        error: function (error) {
            console.log(error);
        }
    });
}




// $("#increaseChart").replaceWith('<canvas id="increaseChart"></canvas>');
// $("#decreaseChart").replaceWith('<canvas id="decreaseChart"></canvas>');
//
// increase, decraee chart
//
// // 전역 변수로 차트 선언
// var ctx = document.getElementById('increaseChart').getContext('2d');
//
// if (inChart) {
//     inChart.destroy(); // 이미 차트가 있으면 파괴
// }
//
// var months = increaseChart.map(item => item.month);
// var amountSums = increaseChart.map(item => item.amountSum);
//
// var inChart = new Chart(ctx, {
//     type: 'bar',
//     data: {
//         labels: months,
//         datasets: [{
//             label: 'Amount Sum',
//             data: amountSums,
//             backgroundColor: 'rgba(75, 192, 192, 0.2)', // 배경색
//             borderColor: 'rgba(75, 192, 192, 1)', // 테두리 색
//             borderWidth: 1
//         }]
//     },
//     options: {
//         scales: {
//             y: {
//                 beginAtZero: true
//             }
//         }
//     }
// });
//
//
// var ctx = document.getElementById('decreaseChart').getContext('2d');
//
// if (deChart) {
//     deChart.destroy(); // 이미 차트가 있으면 파괴
// }
//
// var months = decreaseChart.map(item => item.month);
// var amountSums = decreaseChart.map(item => item.amountSum);
//
// var deChart = new Chart(ctx, {
//     type: 'bar',
//     data: {
//         labels: months,
//         datasets: [{
//             label: 'Amount Sum',
//             data: amountSums,
//             backgroundColor: 'rgba(75, 192, 192, 0.2)', // 배경색
//             borderColor: 'rgba(75, 192, 192, 1)', // 테두리 색
//             borderWidth: 1
//         }]
//     },
//     options: {
//         scales: {
//             y: {
//                 beginAtZero: true
//             }
//         }
//     }
// });