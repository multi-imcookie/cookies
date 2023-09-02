<%--
  Created by IntelliJ IDEA.
  User: 이성보
  Date: 2023-09-02
  Time: 오후 5:33
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>리뷰 댓글 관리</title>
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
    <h1 class="s-h-imcre24">리뷰 댓글 목록</h1>
    <form action="/review/replies/search" method="get">
        <select name="type">
            <option value="reply_content">댓글 내용</option>
            <option value="member_id">회원 고유번호</option>
        </select>
        <input type="text" name="keyword" placeholder="검색어를 입력하세요">
        <input type="submit" value="검색">
    </form>

    <table>
        <tr>
            <th>댓글 번호</th>
            <th>리뷰글 번호</th>
            <th>회원 고유번호</th>
            <th>댓글 내용</th>
            <th>댓글 작성일시</th>
            <th>댓글 수정일시</th>
            <th>동작</th>
        </tr>
        <c:forEach var="reply" items="${repliesWithPaging.replies}">
            <tr>
                <td>${reply.reply_id}</td>
                <td>${reply.review_id}</td>
                <td>${reply.member_id}</td>
                <td>${reply.reply_content}</td>
                <td>${reply.create_dt}</td>
                <td>${reply.update_dt}</td>
                <td>
                    <a href="/review/replies/${reply.reply_id}">View</a> |
                    <a href="/review/replies/${reply.reply_id}/edit">Edit</a> |
                    <form action="/review/replies/${reply.reply_id}/delete" method="get">
                        <input type="submit" value="Delete">
                    </form>
                </td>
            </tr>
        </c:forEach>
    </table>
    <div>
        <a href="?page=1">첫페이지</a>
        <a href="?page=${repliesWithPaging.startPage - 10 > 1 ? repliesWithPaging.startPage - 10 : 1}">&lt;&lt;</a>
        <c:forEach var="i" begin="${repliesWithPaging.startPage}" end="${repliesWithPaging.endPage}">
            <c:choose>
                <c:when test="${i == repliesWithPaging.currentPage}">
                    <strong>${i}</strong>
                </c:when>
                <c:otherwise>
                    <a href="?page=${i}">${i}</a>
                </c:otherwise>
            </c:choose>
        </c:forEach>
        <a href="?page=${repliesWithPaging.endPage + 1 <= repliesWithPaging.totalPages ? repliesWithPaging.endPage + 1 : repliesWithPaging.totalPages}">&gt;&gt;</a>
        <a href="?page=${repliesWithPaging.totalPages}">끝페이지</a>
    </div>
</div>

<%@include file="/footer.jsp" %>
</body>
</html>
