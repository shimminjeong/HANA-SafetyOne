function plusSlides(n) {
    showSlides(slideIndex += n);
}

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
    var cardId = imgElement.getAttribute('data-card-id');

    window.location.href = '/cardChart/' + cardId;
}


var inChart;
var deChart;
var monChart;
var weeChart;

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
