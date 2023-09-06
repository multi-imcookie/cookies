<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>댓글수정</title>
    <%@ include file="/link.jsp" %>
</head>
<body>
<%@ include file="/header.jsp" %>

<!-- 댓글 -->

<div>
    <form method="post" action="/review/replyModify">
        <p>
            <textarea cols="50" name="reply_content">${reply.reply_content}</textarea>
            <button type="submit">댓글 수정</button>
        </p>
        <p>
            <input type="hidden" name="member_id" id="member_id" value="1">
            <input type="hidden" name="review_id" value="${reply.review_id}">
            <input type="hidden" name="reply_id" value="${reply.reply_id}">
            <%--<button type="submit">댓글 작성</button>--%>
        <hr />
        </p>
    </form>
</div>



<%@include file="/footer.jsp" %>
</body>
</html>

