<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
<head>
    <title>전과자</title>
    <%@ include file="/link.jsp" %>
</head>
<body>
<%@include file="/header.jsp" %>

<div class="sub-container p-regular">
    <div class="curation-main">
        <div class="curation-main-left">
            <img src="/resources/img/curation/curation_home.png" alt="curation">
        </div>
        <div class="curation-main-right">
            <div class="curation-main-name">
                <h3 class="h-pre36">취향저격 몽타주 조회</h3>
                큐레이션 시작하기!
            </div>
            <div class="curation-start-btn">
                <a href="curationStepOne" id="curationStart" onclick="showAlert()">
                    <label for="curationStart" class="fill-btn">맛도리 찾으러</label>
                </a>
            </div>
        </div>
    </div>
</div>

<!-- 추가 줄들을 필요한 만큼 생성 -->


<%@include file="/footer.jsp" %>
<script>
    function showAlert() {
        alert("큐레이션을 시작합니다!\n(기존에 진행한 이력이 있다면, 다시 수정됩니다)");
    }
</script>
</body>
</html>
