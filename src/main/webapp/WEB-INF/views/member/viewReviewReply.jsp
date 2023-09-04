<%--
  Created by IntelliJ IDEA.
  User: 이성보
  Date: 2023-09-02
  Time: 오후 5:25
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>댓글 조회</title>
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
    <h1 class="s-h-imcre24">댓글 정보</h1>
    <table>
        <tr>
            <td>댓글 번호:</td>
            <td>${reply.reply_id}</td>
        </tr>
        <tr>
            <td>리뷰글 번호:</td>
            <td>${reply.review_id}</td>
        </tr>
        <tr>
            <td>회원 고유번호:</td>
            <td>${reply.member_id}</td>
        </tr>
        <tr>
            <td>댓글 내용:</td>
            <td>${reply.reply_content}</td>
        </tr>
        <tr>
            <td>댓글 작성일시:</td>
            <td>${reply.create_dt}</td>
        </tr>
        <tr>
            <td>댓글 수정일시:</td>
            <td>${reply.update_dt}</td>
        </tr>
    </table>
    <a href="/review/replies/${reply.reply_id}/edit">수정</a>
</div>
<%@include file="/footer.jsp" %>
</body>
</html>
