<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <link href="../../../resources/css/payment/receipt.css" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
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
                <div class="content-value">${paymentDate}&nbsp;${time}</div>
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
            <div class="approval-info"><h3>*** 신용카드 미승인 ***</h3></div>
            <div class="approval-info"><h3>*** 반드시 확인요망 ***</h3></div>

        </div>
    </div>
</div>

<script>

    $(document).ready(function () {
        formatDate();
    });

    function formatDate() {
        let dateDiv = $('.content-value4');
        let rawDate = dateDiv.text().trim();

        let year = rawDate.split('-')[0].slice(2, 4);
        let month = rawDate.split('-')[1];

        let newFormat = month + '/' + year;

        dateDiv.text(newFormat);
    }


    $(document).ready(function () {
        formatAmounts();
    });

    function formatAmounts() {

        $('.content-value2, .content-value3').each(function () {
            let $this = $(this);
            let amount = parseFloat($this.data('amount'));
            $this.text(formatCurrency(amount) + "원");
        });

        let approvalAmountDiv = $('.content-name:contains("[승인금액]")').siblings('.content-value3');
        let approvalAmount = parseFloat(approvalAmountDiv.data('amount'));
        approvalAmountDiv.text(formatCurrency(approvalAmount) + "원");
    }

    function formatCurrency(amount) {
        return Math.floor(amount).toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
    }


</script>
</body>
</html>
