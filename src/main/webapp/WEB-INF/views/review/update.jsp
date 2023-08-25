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

<%@include file="/header.jsp" %>
<div class="sub-container">
    <h3 class="s-h-imcre24">리뷰게시글 수정</h3>

    <form class="form-style" name="form1" method="post">

        <div class="input-section">
            제목:
            <input name="review_title" id="review_title" size="80" value="${dto.review_title}" placeholder="제목을 입력해주세요">
        </div>

        <div class="input-section">
            별점:
            <input name="review_score" id="review_score" value="${dto.review_score}">
        </div>

        <div class="input-section">
            내용:
            <input name="review_content" id="review_content" value="${dto.review_content}" placeholder="내용을 입력해주세요">
            <%--    <textarea name="review_content" id="review_content" rows="4" cols="80" placeholder="내용을 입력해주세요">${dto.review_content}</textarea>--%>
        </div class="input-section">

        <div class="input-section">
            사진:
            <input name="review_img" id="review_img" value="${dto.review_img}">
        </div>


        <div style="width:650px; text-align: center;">
            <!-- 게시물번호를 hidden으로 처리 -->
            <input type="hidden" name="review_id" value="${dto.review_id}">
            <button type="submit">수정완료</button>
            <button type="button" id="btnDelete">삭제</button>
        </div>


    </form>
</div>
<%@include file="/footer.jsp" %>
</body>
</html>
