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