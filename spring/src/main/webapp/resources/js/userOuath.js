// 사용자 정보 입력하면 무작위로 본인인증번호 보냄
function sendSmsRequest() {
    const phoneNumber = "010" + document.getElementById('phoneNumber').value;

    const ouathNum = String(Math.floor(100000 + Math.random() * 900000));
    console.log("ouathNum", ouathNum);

    const requestData = {
        recipientPhoneNumber: phoneNumber,
        content: '[SafetyOne] SafetyOne 사용을 위해 인증번호 [' + ouathNum + '] 를 입력하세요.',
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
                registerCard();
            } else {
                resultDiv.textContent = '본인인증실패';
            }
        },
        error: function () {
            console.error("본인인증인증과정에러");
        }
    });

}


// 사용자에게 차단되었단 메세지 제공
function sendNotApproval(currentCardId, store, amount, dateTextContent, formattedTime,username,userPhone) {

    var parts = currentCardId.split("-");
    var lastFourDigits = parts[parts.length - 1];

    let partdate = dateTextContent.split('-');
    let formattedDate = partdate[1] + '/' + partdate[2];

    let timeParts = formattedTime.split(":");
    let resultTime = `${timeParts[0]}:${timeParts[1]}`;

    let resultNumber = amount.toLocaleString();


    let maskedName = username[0] + '*' + username[2];
    let phoneNumber = userPhone.replace(/-/g, "");
    console.log("phoneNumber",phoneNumber)
    const requestData = {
        to: phoneNumber,
        content: '하나카드(' + lastFourDigits + ')신용미승인\n'
            + maskedName+'\n'
            + resultNumber + '원\n'
            + formattedDate + ' '+resultTime+'\n'
            + store+'\n'
            + '거래가 차단되었습니다.'+'\n'
            +'※ 본인이실 경우 안심서비스 일시정지를 통해 일정기간동안 거래를 허용하실 수 있습니다.',
    };

    $.ajax({
        url: '/sms/notApproval',
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

function sendFdsAlarm(cardId,username,userPhone,store,dateTime,amount) {

    let phoneNumber = userPhone.replace(/-/g, "");
    var parts = cardId.split("-");
    var lastFourDigits = parts[parts.length - 1];
    let formattedAmount = parseInt(amount).toLocaleString()+"원";
    let maskedName = username[0] + '*' + username[2];
    console.log(typeof dateTime);
    console.log(dateTime);
    let datePart = dateTime.split(" ")[0];
    console.log(datePart)
    let timePart = dateTime.split(" ")[1].split(":").slice(0, 2).join(":");
    console.log(timePart)
    let formattedDate = datePart.split("-").slice(1).join("/");

    // let formattedDate = datePart.split("-").slice(1).join("/");
    let formattedDateTime = formattedDate+' '+timePart;

    const requestData = {
        to: phoneNumber,
        content: '하나카드(' + lastFourDigits + ')신용승인\n'
            + maskedName+'\n'
            + formattedAmount+'\n'
            + formattedDateTime+'\n'
            + store+'\n'
            + '거래가 이상소비로 감지되었습니다.',
    };

    $.ajax({
        url: '/sms/fdsAlarm',
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