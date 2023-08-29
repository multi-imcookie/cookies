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

    <form method="post" action="replyupdate">

        <p>
            <label>댓글 작성자</label> <input type="text" name="reply_id" readonly="readonly" value="${reply.reply_id}">
        </p>
        <p>
            <textarea rows="5" cols="50" name="content">${reply.reply_content}</textarea>
        </p>
        <p>
            <input type="hidden" name="bbs_id" value="${reply.bbs_id}">
            <input type="hidden" name="reply_id" value="${reply.reply_id}">

            <button type="submit">완료</button>
        </p>
    </form>

    <!-- 댓글 삭제 버튼 -->
    <form method='post' action="${pageContext.request.contextPath}/reply/delete?bbs_id=${reply.bbs_id}&amp;reply_id=${reply.reply_id}" onsubmit='return confirm("정말로 삭제하시겠습니까?")'>
        <!-- DELETE 메서드 전송을 위한 히든 필드 -->
        <input type='hidden' name='_method' value='DELETE'>

        <!-- 댓글 삭제 버튼 -->
        <button type=submit">삭제</button>
    </form>

</div>

<!-- 댓글 끝 -->

</body>
</html>