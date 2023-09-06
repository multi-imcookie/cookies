<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>게시물 작성</title>
    <%@ include file="/link.jsp" %>
    <c:if test="${sessionScope.memberGrade != 99}">
        <script>
            alert("권한이 없습니다.")
            location.replace("/index.jsp");
        </script>
    </c:if>
</head>
<body>
<%@include file="/header.jsp" %>
<div class="sub-container">
    <h3 class="h-imcre24">공지사항 작성</h3>
    <form name = "form" id="writeForm" method="post" class="form-style" onsubmit="return validateForm();">
        <input type="hidden" name="member_id" id="member_id" value=${sessionScope.memberId}>
        <div class="input-section">
            <label class="label-wrap" for="notice_title">글제목</label>
            <input type="text" name="notice_title" id="notice_title"
                   placeholder="제목을 입력하세요">
        </div>
        <div class="input-section">
            <label class="label-wrap" for="notice_content">내용</label>
            <textarea cols="50" rows="5" name="notice_content" id="notice_content"
                      placeholder="내용을 입력하세요"></textarea>
        </div>
        <div class="btn-wrap-column">
            <button type="submit" class="btn-Save fill-btn p-medium" id="btn-Save">작성</button>
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
    // JavaScript를 사용하여 폼 유효성 검사
    function validateForm() {
        var title = document.getElementById("notice_title").value;
        var content = document.getElementById("notice_content").value;

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
