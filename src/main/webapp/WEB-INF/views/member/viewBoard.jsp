<%--
  Created by IntelliJ IDEA.
  User: 이성보
  Date: 2023-09-01
  Time: 오후 8:51
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>게시글 조회</title>
    <%@ include file="/link.jsp" %>
    <style>
        /* 여기에 스타일 추가 */
    </style>
</head>
<body>
<%@include file="/header.jsp" %>
<div class="sub-container">
    <h1 class="s-h-imcre24">${board.title}</h1>
    <table>
        <tr>
            <td>ID:</td>
            <td>${board.board_id}</td>
        </tr>
        <tr>
            <td>제목:</td>
            <td>${board.title}</td>
        </tr>
        <tr>
            <td>내용:</td>
            <td>${board.content}</td>
        </tr>
        <tr>
            <td>작성자:</td>
            <td>${board.author}</td>
        </tr>
        <tr>
            <td>날짜:</td>
            <td>${board.date}</td>
        </tr>
    </table>
    <a href="/boards/${board.board_id}/edit">수정</a>
</div>
<%@include file="/footer.jsp" %>
</body>
</html>

