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
<%@include file="/header.jsp" %>
<div class="sub-container">
    <h3 class="h-imcre24">댓글수정</h3>

    <form method="post" action="/reply/update">

        <p>
<%--            <label>댓글 작성자</label> <input type="text" name="member_nickname" readonly="readonly" value="${reply.member_nickname}">--%>
        </p>
        <p>
            <textarea rows="5" cols="50" name="reply_content">${reply.reply_content}</textarea>
        </p>
        <p>
            <input type="hidden" name="bbs_id" value="${reply.bbs_id}">
            <input type="hidden" name="reply_id" value="${reply.reply_id}">

            <button type="submit" class="fill-btn" style="width: 100%; margin-top: 10px">완료</button>
            <button type="button" class="light-fill-btn" style="width: 100%; margin-top: 10px" id="cancelButton">취소</button>

        </p>
    </form>

</div>

<script type="text/javascript">
    document.addEventListener("DOMContentLoaded", function () {
        // 취소 버튼 클릭 이벤트 리스너
        document.getElementById("cancelButton").addEventListener("click", function () {
            window.history.back(); // 이전 페이지로 이동
        });
    });
</script>

<!-- 댓글 끝 -->
<%@include file="/footer.jsp" %>
</body>
</html>