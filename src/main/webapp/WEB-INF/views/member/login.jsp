<%--
  Created by IntelliJ IDEA.
  User: amen
  Date: 2023-08-09
  Time: 오전 1:43
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="java.net.URLDecoder" %>
<html>
<head>
    <title>전과자</title>
    <%@ include file="/link.jsp" %>
</head>
<body>
<%@include file="/header.jsp" %>
<div class="sub-container p-regular">
    <form action="<c:url value="/login"/>" method="post" class="signup-form form-style">
        <h3 class="s-h-imcre24">로그인</h3>
        <div id="msg">
            <c:if test="${not empty param.msg}">
                <i class="fa fa-exclamation-circle"> ${URLDecoder.decode(param.msg)}</i>
            </c:if>
        </div>
        <div class="input-section">
            <input type="text" id="member_signId" name="username" value="${cookie.id.value}" placeholder="아이디를 입력하세요."
                   required autofocus>
            <span class="guide id_chk"></span>
        </div>
        <div class="input-section">
            <input type="password" id="member_nickname" name="password" placeholder="비밀번호를 입력하세요."
                   required>
        </div>

        <div class="input-section convenience-menu">
            <label class="label-wrap remember-id" for="remember">
                <input type="checkbox" name="remember" id="remember"${empty cookie.id.value ? "":"checked"}>
                아이디 저장
            </label>
            <a class="find-id-pw" href="${findUserOrPwdUrl}">아이디 / 비밀번호 찾기</a>
        </div>

        <button type="submit" class="fill-btn">로그인${cookie.login.value=="self" ? "<img src='resources/img/score/score01.png'>":""}</button>
        <div class="btn-wrap-row social">
            <a class="social-login kakao" href="${kakakoApiUrl}">
                <img src="resources/img/login/kakao.svg">
                ${cookie.login.value=="kakao" ? "<img src='resources/img/score/score01.png'>":""}
                카카오 로그인
            </a>
            <a class="social-login naver" href="${naverApiUrl}">
                <img src="resources/img/login/naver.svg">
                ${cookie.login.value=="naver" ? "<img src='resources/img/score/score01.png'>":""}
                네이버 로그인
            </a>
        </div>
        <button id="join" class="dark-fill-btn">회원가입</button>
    </form>
</div>
<%@include file="/footer.jsp" %>
<script>
    function setMessage(msg, element) {
        document.getElementById("msg").innerHTML = ` ${'${msg}'}`;
        if (element) {
            element.select();
        }
    }

    // 문서가 준비되면 jQuery 코드를 실행합니다.
    $(document).ready(function () {
        // "회원가입" 버튼을 클릭하면 이벤트 핸들러가 실행됩니다.
        $("#join").click(function () {
            // 여기에 이동하고 싶은 주소(URL)를 넣어주세요.
            let destinationURL = "/member/sign.jsp"; // 대체할 URL을 여기에 넣어주세요.
            // 주소를 이동합니다.
            window.location.href = destinationURL;
        });
    });
</script>
</body>
</html>