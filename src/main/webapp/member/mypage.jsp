<%--
  Created by IntelliJ IDEA.
  User: ohlocal
  Date: 2023-08-23
  Time: 오후 5:14
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<html>
<head>
    <title>전과자</title>
    <%@ include file="/link.jsp" %>
    <script type="text/javascript" src="/resources/js/sign.js"></script>
</head>
<body>
<%@include file="/header.jsp" %>
<div class="container">
    <h3 class="s-h-imcre24">마이페이지</h3>
    <div class="profile">
        <div class="profile-img"></div>
        <div class="small-btn-wrap p-regular">
            <a href="#" class="small-fill-btn">변경하기</a>
            <a href="#" class="small-fill-btn">삭제하기</a>
        </div>
    </div>
    <div class="member-info">
        <div class="member-info-section1">
            <h6 class="h-pre24">${member_nickname}</h6>
            <span class="h-pre24 grade-label">${member_grade}</span>
        </div>
        <div class="member-info-section2">
            <ul>
                <li>${member_age}</li>
                <li>${member_gender}</li>
                <li>${member_birthday}</li>
                <li>${member_email}</li>
            </ul>
        </div>
    </div>
</div>
</body>
</html>
