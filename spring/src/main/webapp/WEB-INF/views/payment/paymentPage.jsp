<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <link href="../../../resources/css/common.css" rel="stylesheet">
    <link href="../../../resources/css/service.css" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
</head>
<style>

    .venn-container {
        display: flex;
        justify-content: center;
        align-items: center;
        height: 245px;
        width: 260px;
        position: relative;
        border: 2px solid black; /* 테두리 검정색으로 변경 */
    }

    .circle {
        width: 150px;
        height: 150px;
        border-radius: 50%;
        position: absolute;
        opacity: 0.5;
        border: 2px solid black; /* 테두리 검정색으로 변경 */
        transition: opacity 0.3s;
        display: flex;
        justify-content: center;
        align-items: center;
        cursor: pointer; /* 커서 모양 변경 */
        flex-direction: column;
    }

    .img-select1 {
        height: 77px;
        margin-bottom: 5px;
        margin-top: -25px;
    }
    .img-select2 {
        height: 80px;
        margin-bottom: -15px;
        margin-right: 20px;
    }
    .img-select3 {
        height: 80px;
        margin-bottom: -18px;
        margin-left: 12px;
    }

    #circle1 {
        /*background-color: #eafaf3;*/
        background-color: #ffffff;
        left: calc(50% - 75px);
        top: 0;
    }

    #circle2 {
        background-color: #ffffff;
        left: 0;
        bottom: 0;
    }

    #circle3 {
        background-color: #ffffff;
        right: 0;
        bottom: 0;
    }

    /* Hover 효과 */
    .circle:hover {
        /*background-color: #b0e57c; !* 원하는 hover 배경색 지정 *!*/
    }

    .select-name2{
        margin-bottom: -15px;
        margin-right: 20px;

    }

    .select-name3{
        margin-bottom: -18px;
        margin-left: 12px;

    }

</style>

<body>
<div class="container">
    <div class="venn-container">
        <span id="circle1" class="circle">
            <img class="img-select1"  src="../../resources/img/category.png" alt="Option Lines">
        </span>
        <span id="circle2" class="circle">
            <img class="img-select2" src="../../resources/img/region.png" alt="Location">
        </span>
        <span id="circle3" class="circle">
            <img class="img-select3" src="../../resources/img/time.png" alt="Clock">
        </span>
    </div>
</div>
</body>
</html>
