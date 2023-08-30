<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>댓글 수정</title>
    <%@ include file="/link.jsp" %>
</head>
<body>

<div class="sub-container">
    <h3 class="h-imcre24">댓글수정</h3>

    <form method="post" action="/reply/update">

        <p>
            <label>댓글 작성자</label> <input type="text" name="member_id" readonly="readonly" value="${reply.member_id}">
        </p>
        <p>
            <textarea rows="5" cols="50" name="reply_content">${reply.reply_content}</textarea>
        </p>
        <p>
            <input type="hidden" name="bbs_id" value="${reply.bbs_id}">
            <input type="hidden" name="reply_id" value="${reply.reply_id}">

            <button type="submit">완료</button>
        </p>
    </form>

</div>

<!-- 댓글 끝 -->

</body>
</html>