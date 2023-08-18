<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: 이성보
  Date: 2023-08-16
  Time: 오후 11:19
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page session="false" %>
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
<h1>회원 목록</h1>
<table>
    <tr>
        <th>ID</th>
        <th>아이디</th>
        <th>닉네임</th>
        <th>회원 등급</th>
        <th>동작</th>
    </tr>
    <c:forEach var="member" items="${members}">
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
<%@include file="/footer.jsp" %>
</body>
</html>

