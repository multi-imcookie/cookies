<%--
  Created by IntelliJ IDEA.
  User: ohlocal
  Date: 2023-08-04
  Time: 오전 9:48
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<html>
<head>
    <title>전과자</title>
    <%@ include file="link.jsp" %>
    <link rel="stylesheet" type="text/css" href="resources/css/styles.css?after">
</head>
<body>
<%@include file="header.jsp" %>

<br>
<hr>
<br>
<form action="searchResults" method="get" onsubmit="return validateForm()">
    <select name="category" id="category">
        <option value="">맛을 골라주세요</option>
        <option value="sweet">단맛</option>
        <option value="salty">짠맛</option>
        <option value="etc">기타</option>
    </select>
    <input type="text" name="query" id="query" placeholder="검색할 과자를 입력하세요!">
    <button type="submit">Search</button>
</form>
<br>
<hr>
<br>
<script>
    function validateForm() {
        let category = document.getElementById("category").value;
        if (category === "") {
            alert("카테고리를 골라주세요");
            return false;
        }
        return true;
    }
</script>

<%@include file="footer.jsp" %>
</body>
</html>
