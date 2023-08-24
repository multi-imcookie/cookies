<%--
  Created by IntelliJ IDEA.
  User: 이성보
  Date: 2023-08-18
  Time: 오후 2:30
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>회원 정보 조회</title>
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
    <h1 class="s-h-imcre24">${member.member_nickname} 회원 정보</h1>
    <table>
        <tr>
            <td>ID:</td>
            <td>${member.member_id}</td>
        </tr>
        <tr>
            <td>아이디:</td>
            <td>${member.member_signId}</td>
        </tr>
        <tr>
            <td>닉네임:</td>
            <td>${member.member_nickname}</td>
        </tr>
        <tr>
            <td>나이:</td>
            <td>${member.member_age}</td>
        </tr>
        <tr>
            <td>이메일:</td>
            <td>${member.member_email}</td>
        </tr>
        <tr>
            <td>회원 등급:</td>
            <td>${member.member_grade}</td>
        </tr>
    </table>
    <a href="/members/${member.member_id}/edit">수정</a>
</div>
<%@include file="/footer.jsp" %>
</body>
</html>
