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
  <script type="text/javascript" src="/resources/js/jquery-3.7.0.js"></script>
  <script type="text/javascript" src="/resources/js/scripts.js"></script>
  <title>전과자</title>
  <%@ include file="/link.jsp" %>
  <script type="text/javascript">

    $(function() {
      $('#findId').click(function () {
        let username = document.getElementById("findIdName").value;
        let telecomCode = document.getElementById("findIdTelecomCode").value;
        let regionCode = document.getElementById("findIdRegionCode").value;
        let randomDigits = document.getElementById("findIdRandomDigits").value;
        let phoneNumber = telecomCode + regionCode + randomDigits;

        $.ajax({
          url: "/findId",
          data: {
            name : username,
            phoneNumber: phoneNumber
          },
          success: function (response) {
            window.open('/user_pop_up?id='+response.id+'&name='+response.name, '_blank', 'width=300, height=300');
          },
          error: function () {
            alert("실패하였습니다")
          }
        }) //ajax
      })//click

      $('#findPassWord').click(function () {
        let nickname = document.getElementById("findPwdName").value;
        let signid = document.getElementById("findPwdUserId").value;
        let telecomCode = document.getElementById("findPwdTelecomCode").value;
        let regionCode = document.getElementById("findPwdRegionCode").value;
        let randomDigits = document.getElementById("findPwdRandomDigits").value;
        let phoneNumber = telecomCode + regionCode + randomDigits;

        $.ajax({
          url: "/findPassWord",
          data: {
            name : nickname,
            userId : signid,
            phoneNumber: phoneNumber
          },
          success: function (response2) {
              window.open('/phone?phonenumber='+response2.phoneNumber, '_blank', 'width=300, height=300');
          },
          error: function () {
            pop.document.write("<p>"+"실패하였습니다."+"</p>");
          }
        }) //ajax
      })//click
    })//function
  </script>
</head>
<body>
<header>
  <%@include file="/header.jsp" %>
</header>
<br><br><br><br><br><br>

    아이디 찾기 <br>
    이름 * <input type="text" id="findIdName" name="username" value="천지역" style="background: #F9F5F2" required>
    휴대전화번호 * <input type="text" id="findIdTelecomCode" name="telecomCode" value="010" style="background: #F9F5F2"required> -
    <input type="text" id="findIdRegionCode" name="regionCode" value="1234" style="background: #F9F5F2"required>
    <input type="text" id="findIdRandomDigits" name="randomDigits" value="0987" style="background: #F9F5F2"required><br>
    <button type="submit" class="findId" id="findId">아이디 찾기</button>



  비밀번호 찾기 <br>
  이름(nickname) *  <input type="text" id="findPwdName" name="username" value="손오공" style="background: #F9F5F2" required>
  아이디(signid) * <input type="text" id="findPwdUserId" name="userid" value="apts2" style="background: #F9F5F2" required>
  휴대전화번호(phonenumber) *  <input type="text" id="findPwdTelecomCode" name="telecomCode" value="010" style="background: #F9F5F2"required> -
  <input type="text" id="findPwdRegionCode" name="regionCode" value="3920" style="background: #F9F5F2"required>
  <input type="text" id="findPwdRandomDigits" name="randomDigits" value="5090" style="background: #F9F5F2"required><br>
  <button type="submit" class="findPassWord" id="findPassWord">비밀번호 찾기</button>

<br><br><br><br><br><br>
<footer class="footer">
  <%@include file="../../../footer.jsp" %>
</footer>

</body>
</html>
