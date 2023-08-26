<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>게시물 작성</title>
    <%@ include file="/link.jsp" %>
    <link rel="stylesheet" type="text/css" href="resources/css/menuCss.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.js"
            integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
</head>
<body>
<%@include file="/header.jsp" %>
<div class="sub-container">
    <h3 class="h-imcre24">게시판 글쓰기</h3>

    <form action="write" method="post">
        <label for="bbs_title">제목</label>
        <input type="text" id="bbs_title" name="bbs_title"><br>
        <label for="member_id">작성자</label>
        <input type="text" id="member_id" name="member_id"><br>
        <label for="bbs_content">내용</label>
        <textarea id="bbs_content" name="bbs_content" rows="4" cols="50"></textarea><br>
        <button type="submit" class="btn btn-secondary" name="action" value="write">작성</button>
        <a href="list" class="btn btn-secondary">취소</a>
    </form>
</div>
</body>
</html>
