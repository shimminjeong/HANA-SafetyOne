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

function formatNumberWithCommas(number) {
    return number.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
}

function sendCardIdToServer(cardId) {
    console.log(cardId);
    $.ajax({
        type: "POST",
        url: "/cardinfo",
        data: JSON.stringify({cardId: cardId}),
        contentType: 'application/json',
        success: function (data) {
            var amountSum = data.amountSum;
            var amountCnt = data.amountCnt;
            var safetyStatus = data.safetyStatus;
            var fdsStatus = data.fdsStatus;
            var safetyStatus = data.safetyStatus;
            var cardName = data.cardInfo.cardName;

            document.querySelector('.cardId-info-name').innerHTML = cardName;

            if (safetyStatus === 'Y') {
                document.getElementById('safety-yes').style.display = 'block';
                document.getElementById('safety-no').style.display = 'none';
            } else if (safetyStatus === 'N') {
                document.getElementById('safety-yes').style.display = 'none';
                document.getElementById('safety-no').style.display = 'block';
            }

            if (fdsStatus === 'Y') {
                document.getElementById('fds-yes').style.display = 'block';
                document.getElementById('fds-no').style.display = 'none';
            } else if (fdsStatus === 'N') {
                document.getElementById('fds-yes').style.display = 'none';
                document.getElementById('fds-no').style.display = 'block';
            }
            var formattedAmountSum = formatNumberWithCommas(amountSum);
            $("#totalAmount").html("<strong>" + formattedAmountSum + "</strong>원 ");
            $("#totalCnt").html("<strong>" + amountCnt + "</strong>" + "건 ");

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