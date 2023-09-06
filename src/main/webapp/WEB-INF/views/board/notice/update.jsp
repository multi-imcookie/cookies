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
    <h3 class="h-imcre24">게시글 수정</h3>
    <form action="/board/update" method="post" class="form-style">
        <div class="input-section">
            <label class="label-wrap">글제목</label>
            <input type="text" name="notice_title" value="${view.notice_title}"/><br/>
        </div>
        <div class="input-section">
            <input type="hidden" name="member_id" id="member_id" value=${sessionScope.memberId}>
        </div>
        <div class="input-section">
            <label class="label-wrap">내용</label>
            <textarea cols="50" rows="5" name="notice_content">${view.notice_content}</textarea><br/>
        </div>
        <!-- 추가: bbs_id hidden 필드 -->
        <input type="hidden" name="notice_id" value="${view.notice_id}"/>
        <div class="btn-wrap-column">
            <button type="submit" class="btn-Save fill-btn p-medium" id="btn-Update">수정</button>
            <a class="light-fill-btn p-medium" id="backButton">뒤로가기</a>
        </div>
    </form>
</div>
<script>
    // JavaScript를 사용하여 버튼 클릭 시 뒤로가기 기능 추가
    document.getElementById("backButton").addEventListener("click", function() {
        window.history.back(); // 이전 페이지로 이동
    });
</script>

<script type="text/javascript">
    document.addEventListener("DOMContentLoaded", function () {
        $("#btn-update").click(function () {
            let notice_title = $("#notice_title").val();
            let notice_content = $("#notice_content").val();
            let member_id = $("#member_id").val();
            if (notice_title == "") {
                alert("제목을 입력하세요");
                document.form.notice_title.focus();
                return;
            }
            if (notice_content == "") {
                alert("내용을 입력하세요");
                document.form.notice_content.focus();
                return;
            }
            if (member_id == "") {
                alert("로그인 해주세요");
                return;
            }
            document.form.submit();
        });
        $("#btnSearch").click(function () {
            openSearchPopup();
        });

    });

</script>
<%@include file="/footer.jsp" %>
</body>
</html>