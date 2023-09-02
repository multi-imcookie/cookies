<%--
  Created by IntelliJ IDEA.
  User: 이성보
  Date: 2023-09-01
  Time: 오후 8:49
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <title>게시글 수정</title>
  <%@ include file="/link.jsp" %>
  <style>
    /* 여기에 스타일 추가 */
  </style>
</head>
<body>
<%@include file="/header.jsp" %>
<div class="sub-container">
  <h1 class="s-h-imcre24">${board.title} 수정하기</h1>
  <form action="<c:url value="/boards/${board.board_id}/update" />" method="post">
    <label for="title">제목:</label>
    <input type="text" id="title" name="title" value="${board.title}" required/><br>

    <label for="content">내용:</label>
    <textarea id="content" name="content" required>${board.content}</textarea><br>

    <label for="author">작성자:</label>
    <input type="text" id="author" name="author" value="${board.author}" required/><br>

    <input type="submit" value="Update">
  </form>
</div>
<%@include file="/footer.jsp" %>
</body>
</html>

