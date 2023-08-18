<%--
  Created by IntelliJ IDEA.
  User: amen
  Date: 2023-08-09
  Time: 오전 1:43
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>

<html>
<head>
    <title>전과자</title>
    <%@ include file="../../../link.jsp" %>
    <style>
        form > h1 {
            font-family: ImcreSoojin, serif;
            color: #452C07;
            font-size: 24px;
            font-weight: 400;
            line-height: 36px;
        }

        #username, #password {
            display: flex;
            padding: 20px 24px;
            flex-direction: column;
            justify-content: center;
            align-items: flex-start;
            gap: 10px;
            align-self: stretch;
            border-radius: 12px;
            background: #F9F5F2;
            margin-left: auto;
            margin-right: auto;
            width: 960px;
        }

        #remember {
            color: #555;
            font-family: Pretendard;
            font-size: 14px;
            font-style: normal;
            font-weight: 400;
            line-height: 20px; /* 142.857% */
        }

        .remember {
            width: 18px;
            height: 18px;
            padding: 10px;
            flex-direction: column;
            justify-content: left;
            gap: 10px;
            border-radius: 2px;
        }

        .login-container {
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            width: 960px;
            margin-left: auto;
            margin-right: auto;
            display: block;
            padding-top: 5%;
            padding-bottom: 5%;
        }

        .login-form h1 {
            margin-bottom: 20px;
            text-align: center;
        }

        .login-form label {
            margin-top: 10px;
        }

        .login-form input {
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 4px;
            width: 350px;
            margin-top: 5px;
        }

        .bu {
            display: flex;
            padding: 20px 24px;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            gap: 10px;
            align-self: stretch;
            width: 960px;
            border-radius: 12px;
            background: #B48D69;
        }

        .left-box {
            float: left;
        }

        .right-box {
            float: right;
        }

        .social-container {
            display: flex; /* Flex 컨테이너로 설정 */
            justify-content: center; /* 가로 정렬을 중앙으로 설정 */
        }

        .item {
            margin: 10px; /* 필요한 간격을 조절할 수 있습니다 */
        }

    </style>
</head>
<body>
<header>
    <%@include file="../../../header.jsp" %>
</header>
<br><br>
<div class="login-container">
    <form class="login-form" action="login" method="post">
        <h1>로그인</h1>
        <div class="login-input">
            <input type="text" id="username" name="username" required>
            <input type="password" id="password" name="password" required>
        </div>
        <div class="left-box">
            <label class=remember for="remember"><input type="checkbox" id="remember" name="remember">아이디 저장
            </label></div>
        <div class="right-box">
            <a href="${findUserOrPwdUrl}">아이디 / 비밀번호 찾기</a>
        </div>
        <br>
        <br>
        <button type="submit" class="bu">로그인</button>
        <div class="social-container">
            <a href="${naverApiUrl}"><span class="item">네이버</span></a>

            <a href="${kakakoApiUrl}"><span
                    class="item">카카오</span></a>
        </div>
    </form>
    <a href="#"><button class="bu">회원가입</button></a>

</div>
<footer class="footer">
    <%@include file="../../../footer.jsp" %>
</footer>
</body>
</html>
