<%--
  Created by IntelliJ IDEA.
  User: 이성보
  Date: 2023-09-02
  Time: 오전 3:28
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>댓글 정보 조회</title>
    <%@ include file="/link.jsp" %>
    <style>
        body {
            text-align: center;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin: 20px auto;
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

        a {
            text-decoration: none;
            color: #007BFF;
        }
    </style>
</head>
<body>
<%@include file="/header.jsp" %>
<div class="sub-container">
    <h1 class="s-h-imcre24">댓글 정보 조회</h1>
    <table>
        <tr>
            <td>ID:</td>
            <td>${reply.reply_id}</td>
        </tr>
        <tr>
            <td>게시글 번호:</td>
            <td>${reply.bbs_id}</td>
        </tr>
        <tr>
            <td>회원 고유번호:</td>
            <td>${reply.member_id}</td>
        </tr>
        <tr>
            <td>댓글 내용:</td>
            <td>${reply.reply_content}</td>
        </tr>
    </table>
    <a href="/replies/${reply.reply_id}/edit">수정</a>
</div>
<%@include file="/footer.jsp" %>
</body>
</html>
