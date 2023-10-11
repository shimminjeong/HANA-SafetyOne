<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <link href="../../../resources/css/payment/receipt.css" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
    <script src="../../../resources/js/userOuath.js" type="text/javascript"></script>
</head>
<body>
<div class="container">
    <div class="receipt-container">
        <div class="store-name"><h2>${store}</h2></div>
        <div class="receipt-content">
            <div class="receipt-content-div">
                <div class="content-name">[사업자번호]&nbsp;</div>
                <div class="content-value">111-22-33333</div>
            </div>
            <div class="receipt-content-div">
                <div class="content-name">[주소]&nbsp;</div>
                <div class="content-value">${address}</div>
            </div>
            <div class="storeInfo">
                <div class="receipt-content-div">
                    <div class="content-name">[대표자]&nbsp;</div>
                    <div class="content-value">홍길동</div>
                </div>
                <div class="receipt-content-div">
                    <div class="content-name">[TEL]&nbsp;</div>
                    <div class="content-value">${storePhoneNumber}</div>
                </div>
            </div>
            <div class="receipt-content-div">
                <div class="content-name">[거래일시]&nbsp;</div>
                <div class="content-value">${paymentDate} ${time}</div>
            </div>
            <hr>
            <hr>
            <div class="receipt-content-div2">
                <div class="content-name2"><span class="word">부가세</span><span class="word"> 과세</span> <span
                        class="last-char">물품가액</span><span>:</span></div>
                <div class="content-value2" data-amount="${amount * 0.9}">${amount * 0.9}</div>
            </div>
            <div class="receipt-content-div2">
                <div class="content-name2">
                    <span class="word">부</span><span class="word">가</span><span class="last-char">세</span><span>:</span>
                </div>
                <div class="content-value2" data-amount="${amount * 0.1}">${amount * 0.1}</div>
            </div>
            <hr>
            <div class="receipt-content-div2">
                <div class="content-name2">
                    <span class="word">합</span><span class="word">계</span><span class="word">금</span><span
                        class="last-char">액</span><span>:</span>
                </div>
                <div class="content-value2" data-amount="${amount}">${amount}</div>
            </div>
            <hr>
            <hr>
            <div class="approval-info"><h3>*** 신용카드 매출전표 [고객용] ***</h3></div>
            <hr>
            <div class="card-category">
                <div class="receipt-content-div">
                    <div class="content-name">[카드종류]&nbsp;</div>
                    <div class="content-value">하나카드</div>
                </div>
                <div class="receipt-content-div">
                    <div class="content-name">[할부개월]&nbsp;</div>
                    <div class="content-value">일시불</div>
                </div>
            </div>
            <div class="receipt-content-div">
                <div class="content-name">[카드번호]&nbsp;</div>
                <div class="content-value-cardId">${fn:substring(cardId, 0, 4)}-****-****-${fn:substring(cardId, 15,20)}</td></div>
            </div>
            <div class="receipt-content-div">
                <div class="content-name">[유효기간]&nbsp;</div>
                <div class="content-value4">${cardInfo.validDate}</div>
            </div>
            <div class="receipt-content-div">
                <div class="content-name">[승인금액]&nbsp;</div>
                <div class="content-value3" data-amount="${amount}">${amount}원</div>
            </div>
            <div class="receipt-content-div">
                <div class="content-name">[승인번호]&nbsp;</div>
                <div class="content-value">${approvalNum}</div>
            </div>
            <div class="receipt-content-div">
                <div class="content-name">[승인일시]&nbsp;</div>
                <div class="content-value-time">${paymentDate} ${time}</div>
            </div>
            <%--            <div id="cardId">${cardId}</div>--%>
            <%--            <div id="address">${address}</div>--%>
            <%--            <div id="time">${time}</div>--%>
            <%--            <div id="categorySmall">${categorySmall}</div>--%>
            <%--            <div id="amount">${amount}</div>--%>
            <%--            <div id="store">${store}</div>--%>
            <%--            <div id="paymentDate">${paymentDate}</div>--%>
            <%--            <div id="storePhoneNumber">${storePhoneNumber}</div>--%>
        </div>
    </div>
</div>

<div id="cardId">${cardId}</div>
<div id="address">${address}</div>
<div id="time">${time}</div>
<div id="categorySmall">${categorySmall}</div>
<div id="amount">${amount}</div>
<%
    String username = (String) session.getAttribute("name");
    String phone = (String) session.getAttribute("phone");
%>
<span class="user-name" style="display: none"><%= username %></span>
<span class="user-phone" style="display: none"><%= phone %></span>

<script>

    $(document).ready(function() {
        formatDate();
    });

    function formatDate() {
        let dateDiv = $('.content-value4');
        let rawDate = dateDiv.text().trim(); // "2026-11-21 00:00:00" 같은 형식의 문자열 가져오기

        let year = rawDate.split('-')[0].slice(2, 4); // 연도의 마지막 두 자리 가져오기
        let month = rawDate.split('-')[1]; // 월 가져오기

        let newFormat = month + '/' + year; // "11/26" 같은 형식으로 변환

        dateDiv.text(newFormat);
    }


    $(document).ready(function () {
        formatAmounts();
    });

    function formatAmounts() {
        // 'content-value2'와 'content-value3' 클래스를 가진 모든 div 요소를 대상으로
        $('.content-value2, .content-value3').each(function () {
            let $this = $(this); // 현재 요소
            let amount = parseFloat($this.data('amount')); // data-amount 값 가져오기
            $this.text(formatCurrency(amount) + "원"); // 원화 기호와 함께 포맷된 값으로 텍스트 설정
        });

        // [승인금액] 값을 가져와서 포맷에 맞게 변경
        let approvalAmountDiv = $('.content-name:contains("[승인금액]")').siblings('.content-value3');
        let approvalAmount = parseFloat(approvalAmountDiv.data('amount'));
        approvalAmountDiv.text(formatCurrency(approvalAmount) + "원");
    }

    function formatCurrency(amount) {
        return Math.floor(amount).toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
    }

    var cardId = $('.content-value-cardId').text();
    var username = $('.user-name').text();
    var userPhone = $('.user-phone').text();
    var store = $('.place-store').text();
    var dateTime = $('.content-value-time').text();
    var amount = $('.content-value3').text();



    $(document).ready(function () {
        var data = {
            cardId: $('#cardId').text(),
            address: $('#address').text(),
            time: $('#time').text(),
            categorySmall: $('#categorySmall').text(),
            amount: $('#amount').text()
        };

        var store = $('.store-name').text();

        $.ajax({
            type: 'POST',
            url: '/payment/detectFds',
            data: JSON.stringify(data),
            contentType: 'application/json',
            dataType: 'text',
            success: function (response) {
                console.log("'" + response + "'");

                if (response == "Y") {
                    // alert("이상함")
                    sendFdsAlarm(cardId,username,userPhone,store,dateTime,amount)
                }
                if (response == "N") {
                    // alert("정상입니다.")
                }
                console.log(response);
            },
            error: function (error) {
                console.error('Error:', error);
            }
        });
    });

</script>
</body>
</html>
