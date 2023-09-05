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
        table {
            width: 100%;
            border-collapse: collapse;
        }

        th, td {
            border: 1px solid #dddddd;
            text-align: left;
            padding: 8px;
        }

        tr:nth-child(even) {
            background-color: #f2f2f2;
        }

        th {
            background-color: #f2f2f2;
        }
    </style>
</head>
<body>
<%@include file="/header.jsp" %>
<div class="sub-container">
    <h1 class="s-h-imcre24">게시글 상세</h1>
    <table>
        <tr>
            <td>ID:</td>
            <td>${board.bbs_id}</td>
        </tr>
        <tr>
            <td>제목:</td>
            <td>${board.bbs_title}</td>
        </tr>
        <tr>
            <td>내용:</td>
            <td>${board.bbs_content}</td>
        </tr>
        <tr>
            <td>작성자:</td>
            <td>${board.member_id}</td>
        </tr>
        <tr>
            <td>날짜:</td>
            <td>${board.create_dt}</td>
        </tr>
    </table>
    <a href="/boards/${board.bbs_id}/edit">수정</a>
</div>
<%@include file="/footer.jsp" %>
</body>
</html>

