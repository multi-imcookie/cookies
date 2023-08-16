<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 2023-08-09
  Time: 오전 11:08
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>

<head>
    <title>Title</title>
    <%@ include file="../link.jsp" %>
</head>
<body>
<%@include file="../header.jsp" %>
<button class="img-button" onclick="alert()">
    <div>
        <img src=/resources/img/entertainment/초코파이.jpg>
        <span> TEXT </span>
    </div>
</button>
<button class="img-button" onclick="alert('클릭!')">
    <div>
        <img src=/resources/img/entertainment/빼빼로.jpg>
        <span> TEXT </span>
    </div>
</button>
<style>
    div {
        display: flex;
        justify-content: space-around;
        align-items: center;
    }
    button {
        width : 50%;
        font-size: 1.5em;
    }


    .btn {
        width: 100%;
        height: 10%;
        padding: 0px;
        font-size: 6vh;
        font-weight: bold;
        position: relative;
        top: 81%;
        overflow: hidden;
        text-align: center;
        color: white;
        text-shadow: -1px 0 #000000, 0 1px #000000, 1px 0 #000000, 0 -1px #000000;
    }
    .back {
        width: 50%;
        height: 100%;
        max-width: 50%;
        max-height: 100%;
        background-image: url(https://picsum.photos/70/30);
        background-repeat: no-repeat;
        background-size: contain;
        background-position: left center;
        position: relative;
        left: 50%;
        top: -100%;
        z-index: 2;
    }
</style>
</body>
<%@include file="../footer.jsp" %>
</html>

