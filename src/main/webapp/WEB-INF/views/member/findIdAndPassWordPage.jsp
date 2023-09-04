<%--
  Created by IntelliJ IDEA.
  User: amen
  Date: 2023-08-17
  Time: 오전 2:26
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
<head>
    <%@ include file="/link.jsp" %>
    <script type="text/javascript">
        function modalShow(response) {
            $(".modal-overlay").fadeIn();
            $(".modal-box").addClass("active");
            if(response.findId==="1"){
                $("#span-text").append(response.idResult);
                $(".light-fill-btn").attr("href","/forgotUserNameOrPassWord");
                $(".light-fill-btn").text("비밀번호 찾기로 이동");
            }
            if(response.findPassWord==="1"){
                $("#span-text").append(response.findResult);
                $(".light-fill-btn").attr("href","/forgotUserNameOrPassWord");
                $(".light-fill-btn").text("비밀번호 찾기로 이동");
            }
        }

        $(function () {
            $('#findId').click(function () {
                let username = $('#findIdName').val();
                let telecomCode = $('#findIdTelecomCode').val();
                let regionCode = $('#findIdRegionCode').val();
                let randomDigits = $('#findIdRandomDigits').val();
                let phoneNumber = telecomCode + "-" + regionCode + "-" + randomDigits;

                $.ajax({
                    type: "post",
                    url: "/findId",
                    data: {
                        username: username,
                        phoneNumber: phoneNumber
                    },
                    success: function (response) {
                        modalShow(response);
                    },
                    error: function () {
                        alert("닉네임,전화번호가 틀립니다.");
                    }
                }) //ajax
            })//click
            $('#findPassWord').click(function () {
                let nickname = $('#findPassWordName').val();
                let signid = $('#findPassWordId').val();
                let telecomCode = $('#findPassWordTelecomCode').val();
                let regionCode = $('#findPassWordRegionCode').val();
                let randomDigits = $('#findPassWordRandomDigits').val();
                let phoneNumber = telecomCode + "-" + regionCode + "-" + randomDigits;

                $.ajax({
                    type: "post",
                    url: "/findPassWord",
                    data: {
                        nickname: nickname,
                        userId: signid,
                        phoneNumber: phoneNumber
                    },
                    success: function (response) {
                        modalShow(response);
                    },
                    error: function () {
                        alert("닉네임,아이디,전화번호가 틀립니다.")
                    }
                }) //ajax
            })//click
        })//function
    </script>
</head>
<body>
<%@include file="/header.jsp" %>
<%--    모달 창 --%>
<div class="modal-overlay">
    <div class="modal-box">
        <div class="mdl-text">
            <p class="h-pre24"><span id="span-text"></span> 🥰<br>
                로그인 페이지로 이동할까요?</p>
            <div class="mdl-info">
                <img src="/resources/img/icon/info-circle.svg" alt="info icon">
                <p class="p-regular">로그인 하면 더 많은 기능을 이용할 수 있어요.</p>
            </div>
        </div>
        <div class="btn-wrap">
            <a class="fill-btn p-medium" href="/login">로그인 화면으로 이동</a>
            <a class="light-fill-btn p-medium" href="/index.jsp">메인 화면으로 이동</a>
        </div>
    </div>
</div>
<%--    아이디 찾기--%>
<div class="sub-container">
    <h3 class="s-h-imcre24" style="padding: 0px 0px 0px 0px;">아이디 찾기</h3>
    <div class="form-style">
        <div class="input-section">
            <label class="label-wrap" for="findIdName">닉네임<span class="require-val">*</span></label>
            <input type="text" id="findIdName" name="username" style="background: #F9F5F2" required>
        </div>
        <div class="input-section">
            <label class="label-wrap" for="findIdTelecomCode">휴대전화번호<span class="require-val">*</span></label>
            <input type="text" id="findIdTelecomCode" name="telecomCode" required>
            <span class="form-at">-</span>
            <input type="text" id="findIdRegionCode" name="regionCode" required>
            <span class="form-at">-</span>
            <input type="text" id="findIdRandomDigits" name="randomDigits" required>
        </div>
        <button class="fill-btn" id="findId">아이디 찾기</button>
    </div>
    <%--    비밀번호 찾기--%>
    <h3 class="s-h-imcre24">비밀번호 찾기</h3>
    <div class="form-style">
        <div class="input-section">
            <label class="label-wrap" for="findPassWordName">닉네임<span class="require-val">*</span></label>
            <input type="text" id="findPassWordName" name="username" style="background: #F9F5F2" required>
        </div>
        <div class="input-section">
            <label class="label-wrap" for="findPassWordId">아이디<span class="require-val">*</span></label>
            <input type="text" id="findPassWordId" name="username" style="background: #F9F5F2"
                   required>
        </div>
        <div class="input-section">
            <label class="label-wrap" for="findIdTelecomCode">휴대전화번호<span class="require-val">*</span></label>
            <input type="text" id="findPassWordTelecomCode" name="telecomCode" required>
            <span class="form-at">-</span>
            <input type="text" id="findPassWordRegionCode" name="regionCode" required>
            <span class="form-at">-</span>
            <input type="text" id="findPassWordRandomDigits" name="randomDigits" required>
        </div>
        <button class="fill-btn" id="findPassWord">비밀번호 찾기</button>
    </div>
</div>

<%@include file="../../../footer.jsp" %>
</body>
</html>

