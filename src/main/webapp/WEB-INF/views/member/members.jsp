<%--
  Created by IntelliJ IDEA.
  User: 이성보
  Date: 2023-08-18
  Time: 오후 2:30
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" pageEncoding="UTF-8" %>
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
    <c:if test="${sessionScope.memberGrade != 99}">
        <script>
            alert("권한이 없습니다.")
            location.replace("/index.jsp");
        </script>
    </c:if>
</head>
<body>
    <%@include file="/header.jsp" %>
    <div class="sub-container">
        <h1 class="s-h-imcre24">회원 목록</h1>
        <div class="button-group" style="margin-top: 20px;">
            <a href="/members" class="manage-btn">회원 관리</a>
            <a href="/boards" class="manage-btn">자유게시판</a>
            <a href="/replies" class="manage-btn">자게 댓글</a>
            <a href="/reviews" class="manage-btn">리뷰게시판</a>
            <a href="/review/replies" class="manage-btn">리뷰 댓글</a>
            <a href="/api/controlDB.jsp" class="manage-btn">API 관리</a>
        </div>
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
                <button class="search-btn" id="btn-search"><img src="/resources/img/icon/search.svg" alt="돋보기 아이콘">
                </button>
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
                        <a href="/members/${member.member_id}">보기</a> |
                        <a href="/members/${member.member_id}/edit">수정</a> |
                        <form action="/members/${member.member_id}/delete" method="get">
                            <input type="submit" value="삭제">
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
