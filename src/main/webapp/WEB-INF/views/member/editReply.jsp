<%--
  Created by IntelliJ IDEA.
  User: 이성보
  Date: 2023-09-02
  Time: 오전 3:28
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" %>

<!DOCTYPE html>
<html>
<head>
    <title>댓글 수정</title>
    <%@ include file="/link.jsp" %>
    <style>
        body {
            text-align: center;
        }

        form {
            max-width: 400px;
            margin: 0 auto;
        }

        label, textarea {
            display: block;
            width: 100%;
            margin-bottom: 15px;
        }

        label {
            font-weight: bold;
            margin-bottom: 5px;
        }

        textarea {
            padding: 5px;
            border: 1px solid #ccc;
            border-radius: 4px;
            resize: vertical;
        }

        input[type="submit"] {
            cursor: pointer;
            background-color: #4CAF50;
            color: white;
            border: none;
            border-radius: 4px;
            padding: 10px 20px;
        }
    </style>
</head>
<body>
<%@include file="/header.jsp" %>
<div class="sub-container">
    <h1 class="s-h-imcre24">댓글 수정</h1>
    <form action="<c:url value='/replies/${reply.reply_id}/update' />" method="post">
        <label for="content">댓글 내용:</label>
        <textarea id="content" name="reply_content" rows="4" cols="50">${reply.reply_content}</textarea><br>

        <input type="submit" value="수정">
    </form>
</div>
<%@include file="/footer.jsp" %>
</body>
</html>
