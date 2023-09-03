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
        /* 버튼 그룹을 감싸는 컨테이너에 대한 스타일 */
        .button-group {
            display: flex;
            flex-direction: row;
            gap: 10px; /* 버튼 간의 간격 */
        }

        .manage-btn {
            display: flex;
            padding: 20px 20px;
            box-sizing: border-box;
            justify-content: center;
            align-items: center;
            align-self: stretch;
            border-radius: 12px;
            font-size: 16px;
            font-weight: 500;
            line-height: 28px;
            cursor: pointer;
            background-color: #B48D69;
            color: #F9F5F2;
            transition: all .3s;
            gap: 8px;
            flex: none; /* 이 부분이 중요합니다. */
        }

    </style>
</head>
<body>
<%@include file="/header.jsp" %>
<div class="sub-container">
    <h1 class="s-h-imcre24">게시판 목록</h1>
    <div class="button-group" style="margin-top: 20px;">
        <a href="/members" class="manage-btn">회원 관리</a>
        <a href="/boards" class="manage-btn">자유게시판</a>
        <a href="/replies" class="manage-btn">자게 댓글</a>
        <a href="/reviews" class="manage-btn">리뷰게시판</a>
        <a href="/review/replies" class="manage-btn">리뷰 댓글</a>
        <a href="/api/controlDB.jsp" class="manage-btn">API 관리</a>
    </div>
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


