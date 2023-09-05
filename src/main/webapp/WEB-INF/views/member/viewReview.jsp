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
    <title>리뷰 보기</title>
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
    </style>
</head>
<body>
<%@include file="/header.jsp" %>

<div class="sub-container">
    <h1 class="s-h-imcre24">리뷰 상세</h1>
    <table>
        <tr>
            <td>리뷰 ID:</td>
            <td>${review.review_id}</td>
        </tr>
        <tr>
            <td>회원 ID:</td>
            <td>${review.member_id}</td>
        </tr>
        <tr>
            <td>제목:</td>
            <td>${review.review_title}</td>
        </tr>
        <tr>
            <td>내용:</td>
            <td>${review.review_content}</td>
        </tr>
        <tr>
            <td>평점:</td>
            <td>${review.review_score}</td>
        </tr>
    </table>
    <a href="/reviews/${review.review_id}/edit">수정</a>
</div>

<%@include file="/footer.jsp" %>
</body>
</html>