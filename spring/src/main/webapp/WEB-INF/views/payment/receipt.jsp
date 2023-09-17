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
<h1>거래승인</h1>
<div id="cardId">${cardId}</div>
<div id="address">${address}</div>
<div id="time">${time}</div>
<div id="categorySmall">${categorySmall}</div>
<div id="amount">${amount}</div>

<script>
  $(document).ready(function() {
    var data = {
      cardId: $('#cardId').text(),
      address: $('#address').text(),
      time: $('#time').text(),
      categorySmall: $('#categorySmall').text(),
      amount: $('#amount').text()
    };

    $.ajax({
      type: 'POST',
      url: '/payment/detectFds',
      data: JSON.stringify(data),
      contentType: 'application/json',
      dataType:'text',
      success: function(response) {
        if (response === "임베딩성공") {
          alert("성공!!!!")
        }
        console.log(response);
      },
      error: function(error) {
        console.error('Error:', error);
      }
    });
  });

</script>

</body>

</html>
