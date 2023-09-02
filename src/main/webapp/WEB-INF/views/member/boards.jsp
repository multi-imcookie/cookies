<%--
  Created by IntelliJ IDEA.
  User: 이성보
  Date: 2023-09-01
  Time: 오후 8:52
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>게시판 관리</title>
    <%@ include file="/link.jsp" %>
    <style>
        /* 여기에 스타일 추가 */
    </style>
</head>
<body>
<%@include file="/header.jsp" %>
<div class="sub-container">
    <h1 class="s-h-imcre24">게시판 목록</h1>
    <form action="/boards/search" method="get">
        <div class="main-search">
            <div class="select-wrap">
        <select name="type">
            <option value="title">제목</option>
            <option value="content">내용</option>
        </select>
           </div>
        <span class="div-line"></span>
            <div class="search-wrap">
    <label class="label-bold" for="keyword">Search</label>
    <input class="p-regular" type="text" id="keyword" name="keyword" placeholder="검색하고 싶은 내용을 입력하세요.">
            </div>
            <button class="search-btn" id="btn-search"><img src="/resources/img/icon/search.svg" alt="돋보기 아이콘"></button>
        </div>
    </form>

    <table>
        <tr>
            <th>ID</th>
            <th>제목</th>
            <th>작성자</th>
            <th>날짜</th>
            <th>동작</th>
        </tr>
        <c:forEach var="board" items="${boardsWithPaging.boards}">
            <tr>
                <td>${board.board_id}</td>
                <td>${board.title}</td>
                <td>${board.author}</td>
                <td>${board.date}</td>
                <td>
                    <a href="/boards/${board.board_id}">View</a> |
                    <a href="/boards/${board.board_id}/edit">Edit</a> |
                    <form action="/boards/${board.board_id}/delete" method="get">
                        <input type="submit" value="Delete">
                    </form>
                </td>
            </tr>
        </c:forEach>
    </table>

    <div>
        <a href="?page=1">첫페이지</a>
        <a href="?page=${boardsWithPaging.startPage - 10 > 1 ? boardsWithPaging.startPage - 10 : 1}">&lt;&lt;</a>
        <c:forEach var="i" begin="${boardsWithPaging.startPage}" end="${boardsWithPaging.endPage}">
            <c:choose>
                <c:when test="${i == boardsWithPaging.currentPage}">
                    <strong>${i}</strong>
                </c:when>
                <c:otherwise>
                    <a href="?page=${i}">${i}</a>
                </c:otherwise>
            </c:choose>
        </c:forEach>
        <a href="?page=${boardsWithPaging.endPage + 1 <= boardsWithPaging.totalPages ? boardsWithPaging.endPage + 1 : boardsWithPaging.totalPages}">&gt;&gt;</a>
        <a href="?page=${boardsWithPaging.totalPages}">끝페이지</a>
    </div>
</div>

<%@include file="/footer.jsp" %>
</body>
</html>


