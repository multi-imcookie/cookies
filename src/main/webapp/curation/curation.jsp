<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
<head>
    <title>전과자</title>
    <%@ include file="/link.jsp" %>
</head>
<body>
<%@include file="/header.jsp" %>

<div class="sub-container">
    <a href="curationStepOne" onclick="showAlert()">
        <button type="submit"> 골랐다 </button>
    </a>
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
