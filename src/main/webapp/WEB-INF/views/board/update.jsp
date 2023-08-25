<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>게시물 수정</title>
    <%@ include file="/link.jsp" %>
</head>
<body>
<div class="sub-container">
    <h3 class="h-imcre24">글수정</h3>

    <form method="post">

        <label>제목</label>
        <input type="text" name="title" value="${view.bbs_title}"/><br/>

        <label>작성자</label>
        <input type="text" name="writer" value="${view.member_id}"/><br/>

        <label>내용</label>
        <textarea cols="50" rows="5" name="content">${view.bbs_content}</textarea><br/>

        <button type="submit">완료</button>

    </form>
</div>
</body>
</html>