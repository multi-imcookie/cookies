<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 2023-08-09
  Time: 오전 11:22
  To change this template use File | Settings | File Templates.
--%>
<%@page import="com.multi.cookies.entertainment.IdealBoardDTO"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<html>
<head>
    <title>Title</title>
    <%@include file="../../link.jsp" %>
</head>
<body>
<%@include file="../../header.jsp" %>
<form action="idealInsert">
    <tr>
        <td class="t1">닉네임 :</td>
        <td><input name="ideal_nickname"></td> <%--이상형월드컵 게시판 작성자닉네임--%>
    </tr>
    <tr>
        <td class="t1">비밀번호 :</td>
        <td><input name="ideal_pw"></td> <%--이상형월드컵 게시판 작성자닉네임--%>
    </tr>
    <tr>
        <td class="t1">의견 :</td>
        <td><input name="ideal_content"></td> <%--이상형월드컵 게시판 내용--%>
    </tr>
    <tr>
        <td>
            <button id="saveIdealReply">의견 작성</button>
        </td>
    </tr>
</form>
<c:forEach var="bag" items="${list}">
    <table border="1" class="table table-dark table-hover">
        <tr>
            <td class="t1">닉네임 :</td>
            <td>${bag.ideal_nickname}</td>
        </tr>
        <tr>
            <td class="t1">내용 :</td>
            <td>${bag.ideal_content}</td>
        </tr>
        <tr>
            <td class="t1">시간 :</td>
            <td>${bag.create_dt}</td>
        </tr>
        <br>
    </table>
</c:forEach>
<%@include file="../../footer.jsp" %>
</body>
</html>
