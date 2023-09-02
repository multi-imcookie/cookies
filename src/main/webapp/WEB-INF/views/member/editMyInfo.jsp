<%--
  Created by IntelliJ IDEA.
  User: ohlocal
  Date: 2023-09-01
  Time: 오전 3:38
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>전과자</title>
    <%@ include file="/link.jsp" %>
    <script type="text/javascript" src="/resources/js/mypage.js"></script>
</head>
<body>
<%@include file="/header.jsp" %>
<div class="modal-overlay">
    <div class="modal-box">
        <div class="mdl-text">
            <p class="h-pre24">
                <span>회원 정보 수정 완료!</span> 👌<br>
                마이페이지로 이동할까요?
            </p>
        </div>
        <div class="btn-wrap">
            <a class="fill-btn p-medium" href="/mypage">마이페이지로 이동</a>
            <a class="light-fill-btn p-medium" href="/index.jsp">메인 화면으로 이동</a>
        </div>
    </div>
</div>
<div class="sub-container p-regular">
    <h3 class="s-h-imcre24">회원 정보 수정</h3>
    <form class="editMyinfo-form form-style" method="post">
        <input type="hidden" id="member_id" name="member_id" value="${sessionScope.memberId}">
        <div class="input-section">
            <label class="label-wrap" for="member_signId">아이디</label>
            <input type="text" id="member_signId" name="member_signId" value="${memberDTO.member_signId}" disabled>
            <span class="guide id_chk"></span>
        </div>
        <div class="input-section">
            <label class="label-wrap" for="member_nickname">닉네임</label>
            <input type="text" id="member_nickname" name="member_nickname" value="${memberDTO.member_nickname}"
                   required>
        </div>
        <div class="input-section">
            <label class="label-wrap" for="member_phone">휴대폰번호
                <img onclick="phoneHelp()" class="help" src="/resources/img/icon/help-circle.svg" alt="도움말">
                <span class="help-content">아이디 또는 비밀번호를 찾을 때 필요한 정보입니다.</span>
            </label>
            <input type="text" oninput="autoHyphen(this)" maxlength="13" id="member_phone"
                   name="member_phone" value="${memberDTO.member_phone}">
        </div>
        <div class="input-section">
            <label class="label-wrap" for="member_email">이메일</label>
            <input type="text" id="member_email" name="member_email" value="${memberDTO.member_email}" required>
            <span class="guide email_chk"></span>
        </div>
        <input type="button" id="editMyInfo-btn" class="fill-btn" value="내 정보 수정">
    </form>
</div>
<%@include file="/footer.jsp" %>
</body>