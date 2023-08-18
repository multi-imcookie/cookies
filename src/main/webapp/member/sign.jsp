<%--
  Created by IntelliJ IDEA.
  User: ohlocal
  Date: 2023-08-04
  Time: 오전 9:48
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<html>
<head>
    <title>전과자</title>
    <%@ include file="../link.jsp" %>
    <script type="text/javascript" src="../resources/js/sign.js"></script>
</head>
<body>
<%@include file="../header.jsp" %>
<div class="modal-overlay">
    <div class="modal-box">
        <div class="mdl-text">
            <p class="h-pre24"><span>회원가입 완료!</span> 🥰<br>
                로그인 페이지로 이동할까요?</p>
            <div class="mdl-info">
                <img src="../resources/img/info-circle.svg" alt="info icon">
                <p class="p-regular">로그인 하면 더 많은 기능을 이용할 수 있어요.</p>
            </div>
        </div>
        <div class="btn-wrap">
            <a class="fill-btn p-medium" href="moveLogin">로그인 화면으로 이동</a>
            <a class="light-fill-btn p-medium" href="/index.jsp">메인 화면으로 이동</a>
        </div>
    </div>
</div>
<div class="container">
    <h3 class="s-h-imcre24">회원가입</h3>
    <form class="signup-form form-style" method="post">
        <div class="input-section">
            <label class="label-wrap" for="member_signId">아이디<span class="require-val">*</span></label>
            <input type="text" id="member_signId" name="member_signId" placeholder="아이디를 입력하세요." required>
            <span class="guide id_chk"></span>
        </div>
        <div class="input-section">
            <label class="label-wrap" for="member_nickname">닉네임<span class="require-val">*</span></label>
            <input type="text" id="member_nickname" name="member_nickname" placeholder="전과자에서 사용하실 닉네임을 입력하세요."
                   required>
        </div>
        <div class="input-section">
            <label class="label-wrap" for="member_pw">비밀번호 입력<span class="require-val">*</span></label>
            <input type="password" id="member_pw" name="member_pw" placeholder="8~16자리 / 영문 대소문자, 숫자, 특수문자 조합" required>
            <span class="guide pw_rule"></span>
        </div>
        <div class="input-section">
            <label class="label-wrap" for="member_pwChk">비밀번호 확인<span class="require-val">*</span></label>
            <input type="password" id="member_pwChk" name="member_pwChk" placeholder="비밀번호를 한 번 더 입력하세요." required>
            <span class="guide pw_chk"></span>
        </div>
        <div class="input-section">
            <label class="label-wrap" for="member_birthday1">생일 / 연령대<span class="require-val">*</span></label>
            <div class="input-section-left">
                <input type="number" maxlength="2" oninput="maxLengthChk(this)" id="member_birthday1" name="member_birthday1" placeholder="MM"
                       required>
                <input type="number" maxlength="2" oninput="maxLengthChk(this)" id="member_birthday2" name="member_birthday2" placeholder="DD"
                       required>
            </div>
            <div class="input-section-right">
                <div class="label-wrap">
                    <input type="radio" id="member_age1" name="member_age" value="10-19"><label
                        for="member_age1">10대</label>
                </div>
                <div class="label-wrap">
                    <input type="radio" id="member_age2" name="member_age" value="20-29"><label
                        for="member_age2">20대</label>
                </div>
                <div class="label-wrap">
                    <input type="radio" id="member_age3" name="member_age" value="30-39"><label
                        for="member_age3">30대</label>
                </div>
                <div class="label-wrap">
                    <input type="radio" id="member_age4" name="member_age" value="40-49"><label
                        for="member_age4">40대</label>
                </div>
                <div class="label-wrap">
                    <input type="radio" id="member_age5" name="member_age" value="50-59"><label
                        for="member_age5">50대</label>
                </div>
                <div class="label-wrap">
                    <input type="radio" id="member_age6" name="member_age" value="60-"><label for="member_age6">60대
                    이상</label>
                </div>
            </div>
        </div>
        <div class="input-section">
            <label class="label-wrap" for="member_gender1">성별<span class="require-val">*</span></label>
            <div class="input-section-right">
                <div class="label-wrap">
                    <input type="radio" id="member_gender1" name="member_gender" value="여성"><label
                        for="member_gender1">여성</label>
                </div>
                <div class="label-wrap">
                    <input type="radio" id="member_gender2" name="member_gender" value="남성"><label
                        for="member_gender2">남성</label>
                </div>
            </div>
        </div>
        <div class="input-section">
            <label class="label-wrap" for="member_email1">이메일<span class="require-val">*</span></label>
            <input type="text" id="member_email1" name="member_email1" placeholder="이메일을 입력하세요." required>
            <span class="email-at">@</span>
            <input type="text" id="member_email2" name="member_email2" placeholder="이메일 주소를 입력하세요." required>
        </div>
        <input type="button" id="signUp-btn" class="fill-btn" value="회원가입">
    </form>
</div>
<%@include file="../footer.jsp" %>
</body>
</html>
