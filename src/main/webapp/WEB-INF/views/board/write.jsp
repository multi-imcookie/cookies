<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>게시물 작성</title>
    <%@ include file="/link.jsp" %>

</head>
<body>
<%@include file="/header.jsp" %>
<div class="sub-container">
    <h3 class="h-imcre24">자유게시판 작성</h3>
    <form name = "form" id="writeForm" method="post" class="form-style" onsubmit="return validateForm();" >
<%--        <div class="input-section">--%>
            <input type="hidden" name="member_id" id="member_id" value=${sessionScope.memberId}>

        <div class="input-section">
            <label class="label-wrap" for="bbs_title">글제목</label>
            <input type="text" name="bbs_title" id="bbs_title"
                   placeholder="제목을 입력하세요">
        </div>
        <div class="input-section">
            <label class="label-wrap" for="bbs_content">내용</label>
            <textarea cols="50" rows="5" name="bbs_content" id="bbs_content"
                      placeholder="내용을 입력하세요"></textarea>
        </div>

<%--    <form action="write" method="post">--%>
<%--        <label for="bbs_title">제목</label>--%>
<%--        <input type="text" id="bbs_title" name="bbs_title"><br>--%>
<%--        <label for="bbs_content">내용</label>--%>
<%--        <textarea id="bbs_content" name="bbs_content" rows="4" cols="50"></textarea><br>--%>

<%--        <input type="hidden" name="member_id" id="member_id" value=${sessionScope.memberId}>--%>

        <div class="btn-wrap-column">
            <button type="submit" class="btn-Save fill-btn p-medium" id="btn-Save">작성</button>
            <button class="light-fill-btn p-medium" id="backButton">뒤로가기</button>
        </div>

    </form>
</div>

<!--서희님 원본 남겨드립니다 -진기
-->
<%--<div class="sub-container">--%>
<%--    <h3 class="h-imcre24">자유게시판 작성</h3>--%>
<%--    <form action="write" method="post">--%>
<%--        <label for="bbs_title">제목</label>--%>
<%--        <input type="text" id="bbs_title" name="bbs_title"><br>--%>
<%--        <label for="member_id">작성자</label>--%>
<%--        <input type="text" id="member_id" name="member_id"><br>--%>
<%--        <label for="bbs_content">내용</label>--%>
<%--        <textarea id="bbs_content" name="bbs_content" rows="4" cols="50"></textarea><br>--%>
<%--        <button type="submit" class="btn btn-secondary" name="action" value="write">작성</button>--%>
<%--        <a href="list" class="btn btn-secondary">취소</a>--%>
<%--    </form>--%>
<%--</div>--%>

<script>
    // JavaScript를 사용하여 버튼 클릭 시 뒤로가기 기능 추가
    document.getElementById("backButton").addEventListener("click", function() {
        window.history.back(); // 이전 페이지로 이동
    });
</script>

<script type="text/javascript">
    // JavaScript를 사용하여 폼 유효성 검사
    function validateForm() {
        var title = document.getElementById("bbs_title").value;
        var content = document.getElementById("bbs_content").value;

        if (title === "") {
            alert("제목을 입력하세요.");
            return false; // 폼 제출 중단
        }
        if (content === "") {
            alert("내용을 입력하세요.");
            return false; // 폼 제출 중단
        }

        return true; // 유효성 검사 통과, 폼 제출
    }

</script>
<%@include file="/footer.jsp" %>
</body>
</html>
