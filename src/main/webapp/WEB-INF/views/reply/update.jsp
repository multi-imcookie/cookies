<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>댓글 수정</title>
    <%@ include file="/link.jsp" %>
    <style>
        .section-01 {
            display: flex;
        }
    </style>
</head>
<body>
<%@include file="/header.jsp" %>
<div class="sub-container">
    <h3 class="h-imcre24">댓글수정</h3>

    <form method="post" action="/reply/update" class="form-style">

        <p>
            <input type="hidden" name="member_id" value="${reply.member_id}">
        </p>
        <p class="section-01">
            <textarea rows="5" cols="50" name="reply_content">${reply.reply_content}</textarea>
        </p>
        <p class="btn-wrap-row">
            <input type="hidden" name="bbs_id" value="${reply.bbs_id}">
            <input type="hidden" name="reply_id" value="${reply.reply_id}">

            <button type="submit" class="fill-btn">완료</button>
            <button type="button" class="light-fill-btn" id="cancelButton">취소</button>

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