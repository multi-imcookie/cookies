<%--
  Created by IntelliJ IDEA.
  User: 이성보
  Date: 2023-09-02
  Time: 오전 4:35
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>리뷰 관리</title>
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
    <h1 class="s-h-imcre24">리뷰 목록</h1>
    <table>
        <tr>
            <th>리뷰 ID</th>
            <th>회원 ID</th>
            <th>내용</th>
            <th>평점</th>
            <th>동작</th>
        </tr>
        <c:forEach var="review" items="${reviews}">
            <tr>
                <td>${review.review_id}</td>
                <td>${review.member_id}</td>
                <td>${review.content}</td>
                <td>${review.review_score}</td>
                <td>
                    <a href="/reviews/${review.review_id}">보기</a> |
                    <a href="/reviews/${review.review_id}/edit">수정</a> |
                    <form action="/reviews/${review.review_id}/delete" method="get">
                        <input type="submit" value="삭제">
                    </form>
                </td>
            </tr>
        </c:forEach>
    </table>
</div>

<%@include file="/footer.jsp" %>
</body>
</html>