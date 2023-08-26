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
    <style>
        .input-section {
            display: flex;
            justify-content: space-between; /* 좌우로 공간을 분배합니다 */
            align-items: center;
            gap: 12px;
            align-self: stretch;
        }

        .input-section-left {
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .input-section-right {
            display: flex;
            align-items: center;
            gap: 12px;
        }
        .btn-wrap {
            display: flex;
            flex-direction: column;
            align-items: center;
            gap: 8px; /* 버튼 사이의 간격 조절 */
            align-self: stretch;
        }

        .fill-btn {
            margin-bottom: 0; /* 버튼과 다음 섹션 사이의 간격을 없앰 */

        }
    </style>
    <script type="text/javascript">

    </script>
    <title>전과자</title>
    <%@ include file="/link.jsp" %>
</head>
<body>
<%@include file="/header.jsp" %>
<div class="sub-container">
    <form action="<c:url value="/login"/>" method="post" class="signup-form form-style">
        <h3 class="s-h-imcre24">로그인</h3>
        <div id="msg">
            <c:if test="${not empty param.msg}">
                <i class="fa fa-exclamation-circle"> ${URLDecoder.decode(param.msg)}</i>
            </c:if>
        </div>
        <div class="input-section">
            <label class="label-wrap" for="member_signId">아이디<span class="require-val">*</span>
            </label>
            <input type="text" id="member_signId" name="username" value="${cookie.id.value}" placeholder="아이디를 입력하세요." required autofocus>
            <span class="guide id_chk"></span>
        </div>
        <div class="input-section">
            <label class="label-wrap" for="member_nickname">비밀번호<span class="require-val">*</span>
            </label>
            <input type="password" id="member_nickname" name="password" placeholder="비밀번호를 입력하세요."
                   required>
        </div>

        <div class="input-section">
            <div class="input-section-left">
                <div class="label-wrap">
                    <label class="label-wrap" for="remember">
                        <input type="checkbox" name="remember" id="remember"${empty cookie.id.value ? "":"checked"}>
                        아이디 저장
                    </label>
                </div>
            </div>
            <div class="input-section-right">
                <div class="label-wrap" style="margin-left: auto;">
                    <label class="label-wrap" for="member_nickname">
                        <a href="${findUserOrPwdUrl}">아이디 / 비밀번호 찾기</a>
                    </label>
                </div>
            </div>
        </div>
        <button type="submit"  class="fill-btn">로그인</button>

        <div class="input-section">
            <div class="input-section-left">
                <div class="label-wrap">
                    <a href="${naverApiUrl}"><img src="/resources/img/login/naverlogin.png" width="500"></a>
                </div>
            </div>
            <div class="input-section-right">
                <div class="label-wrap">
                    <a href="${kakakoApiUrl}"><img src="/resources/img/login/kakaologin.png" width="500"></a>
                </div>
            </div>
        </div>
    </form>
    <div class="btn-wrap" class="fill-btn">
        <button id="join" class="fill-btn">회원가입</button>
    </div>
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
        $(document).ready(function() {
        // "회원가입" 버튼을 클릭하면 이벤트 핸들러가 실행됩니다.
        $("#join").click(function() {
            // 여기에 이동하고 싶은 주소(URL)를 넣어주세요.
            var destinationURL = "/member/sign.jsp"; // 대체할 URL을 여기에 넣어주세요.
            // 주소를 이동합니다.
            window.location.href = destinationURL;
        });
    });
</script>
</body>
</html>
