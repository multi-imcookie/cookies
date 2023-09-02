<%--
  Created by IntelliJ IDEA.
  User: ohlocal
  Date: 2023-09-02
  Time: 오후 2:43
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
                <span>비밀번호 변경 완료!</span> 👌<br>
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
    <h3 class="s-h-imcre24">비밀번호 변경</h3>
    <form class="editMyPassword-form form-style" method="post">
        <div class="input-section">
            <label class="label-wrap" for="member_pw">비밀번호 입력</label>
            <input type="password" id="member_pw" name="member_pw" placeholder="8~16자리 / 영문 대소문자, 숫자, 특수문자 조합"
                   value="${memberDTO.member_pw}" required>
            <span class="guide pw_rule"></span>
        </div>
        <div class="input-section">
            <label class="label-wrap" for="member_pwChk">비밀번호 확인</label>
            <input type="password" id="member_pwChk" name="member_pwChk" placeholder="비밀번호를 한 번 더 입력하세요."
                   required>
            <span class="guide pw_chk"></span>
        </div>
        <input type="button" id="editMyInfo-btn" class="fill-btn" value="내 정보 수정">
    </form>
</div>
<%@include file="/footer.jsp" %>
</body>