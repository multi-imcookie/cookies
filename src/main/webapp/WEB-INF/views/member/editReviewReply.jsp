<%--
  Created by IntelliJ IDEA.
  User: 이성보
  Date: 2023-09-02
  Time: 오후 5:25
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
            text-align: center; /* 페이지 전체 내용 중앙 정렬 */
        }

        form {
            display: inline-block; /* 폼을 인라인 블록 요소로 만들어 중앙 정렬 */
            text-align: left; /* 폼 내부의 내용은 왼쪽 정렬 */
            /* 나머지 스타일 */
        }

        h1 {
            /* 제목에 대한 추가 스타일 (예: 폰트 크기, 색상 등) */
        }

        form {
            max-width: 400px;
            margin: 0 auto;
        }

        label, input, select {
            display: block;
            width: 100%;
            margin-bottom: 15px;
        }

        label {
            font-weight: bold;
            margin-bottom: 5px;
        }

        input[type="text"], input[type="email"], select {
            padding: 5px;
            border: 1px solid #ccc;
            border-radius: 4px;
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
    <form action="<c:url value="/review/replies/${reply.reply_id}/update" />" method="post">
        <label for="replyContent">댓글 내용:</label>
        <input type="text" id="replyContent" name="reply_content" value="${reply.reply_content}" required/><br>

        <input type="submit" value="Update">
    </form>
</div>
<%@include file="/footer.jsp" %>
</body>
</html>
