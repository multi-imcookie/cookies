<%--
  Created by IntelliJ IDEA.
  User: 이성보
  Date: 2023-08-18
  Time: 오후 2:30
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>회원 관리</title>
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
        <h1 class="s-h-imcre24">회원 목록</h1>
        <form action="/members/search" method="get">
            <div class="main-search">
                <div class="select-wrap">
            <select name="type">
                <option value="nickname">닉네임</option>
                <option value="id">아이디</option>
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
            <th>아이디</th>
            <th>닉네임</th>
            <th>회원 등급</th>
            <th>동작</th>
        </tr>
        <c:forEach var="member" items="${membersWithPaging.members}">
            <tr>
                <td>${member.member_id}</td>
                <td>${member.member_signId}</td>
                <td>${member.member_nickname}</td>
                <td>${member.member_grade}</td>
                <td>
                    <a href="/members/${member.member_id}">View</a> |
                    <a href="/members/${member.member_id}/edit">Edit</a> |
                    <form action="/members/${member.member_id}/delete" method="get">
                        <input type="submit" value="Delete">
                    </form>
                </td>
            </tr>
        </c:forEach>
    </table>
    <div>
        <a href="?page=1">첫페이지</a>
        <a href="?page=${membersWithPaging.startPage - 10 > 1 ? membersWithPaging.startPage - 10 : 1}">&lt;&lt;</a>
        <c:forEach var="i" begin="${membersWithPaging.startPage}" end="${membersWithPaging.endPage}">
            <c:choose>
                <c:when test="${i == membersWithPaging.currentPage}">
                    <strong>${i}</strong>
                </c:when>
                <c:otherwise>
                    <a href="?page=${i}">${i}</a>
                </c:otherwise>
            </c:choose>
        </c:forEach>
        <a href="?page=${membersWithPaging.endPage + 1 <= membersWithPaging.totalPages ? membersWithPaging.endPage + 1 : membersWithPaging.totalPages}">&gt;&gt;</a>
        <a href="?page=${membersWithPaging.totalPages}">끝페이지</a>
    </div>
</div>

<%@include file="/footer.jsp" %>
</body>
</html>
