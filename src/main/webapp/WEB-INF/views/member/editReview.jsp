<%--
  Created by IntelliJ IDEA.
  User: 이성보
  Date: 2023-09-02
  Time: 오전 4:41
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>리뷰 수정</title>
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
    <h1 class="s-h-imcre24">리뷰 수정</h1>
    <form action="/reviews/${review.review_id}/update" method="post">
        <label for="content">내용:</label>
        <input type="text" id="content" name="content" value="${review.content}" required/><br>

        <label for="review_score">평점:</label>
        <select id="review_score" name="review_score">
            <option value="1" ${review.review_score == 1 ? 'selected' : ''}>1</option>
            <option value="2" ${review.review_score == 2 ? 'selected' : ''}>2</option>
            <option value="3" ${review.review_score == 3 ? 'selected' : ''}>3</option>
            <option value="4" ${review.review_score == 4 ? 'selected' : ''}>4</option>
            <option value="5" ${review.review_score == 5 ? 'selected' : ''}>5</option>
        </select><br>

        <input type="submit" value="수정하기">
    </form>
</div>

<%@include file="/footer.jsp" %>
</body>
</html>


