<%--
  Created by IntelliJ IDEA.
  User: ohlocal
  Date: 2023-08-23
  Time: 오후 5:14
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>전과자</title>
    <%@ include file="/link.jsp" %>
    <script>
        $(document).ready(function () {
            $.ajax({
                url: "/mypage", // 컨트롤러에서 처리할 URL 주소
                method: "GET",
                dataType: "json",
                success: function (data) {
                    let memberInfoResult = data;
                    let memberInfo = "<li>" + memberInfoResult.member_age + "</li>" +
                        "<li>" + memberInfoResult.member_gender + "</li>" +
                        "<li>" + memberInfoResult.member_birthday + "</li>" +
                        "<li>" + memberInfoResult.member_email + "</li>";
                    if (data != null) {
                        $(".member-info-result").html(memberInfo);
                    } else {
                        $(".member-info-result").html("User information not available.");
                    }
                },
                error: function () {
                    $(".member-info-result").html("Failed to load user info.");
                }
            });
        });
    </script>
</head>
<body>
<%@include file="/header.jsp" %>
<div class="sub-container">
    <h3 class="s-h-imcre24">마이페이지</h3>
    <div class="profile">
        <div class="profile-img"></div>
        <div class="btn-wrap-row p-regular">
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
            <ul class="member-info-result">
            </ul>
        </div>
        <button href="#" class="edit-btn"><img src="/resources/img/icon/edit.svg" alt="수정버튼"></button>
    </div>
</div>
</body>
</html>
