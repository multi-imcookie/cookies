<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <%@ include file="/link.jsp" %>
</head>
<body>
<div class="sub-container p-regular">
    <div id="curation">
        <c:forEach items="${curationData}" var="entry">
            <div id="${entry.key}">
                <h1>${entry.key}</h1>
                <ul>
                    <c:forEach items="${entry.value}" var="value">
                        <li>과자 이름 : ${value.snack_name}</li>
                        <li>회사 이름 : ${value.company}</li>
                        <li>-------------------------------</li>
                    </c:forEach>
                </ul>
            </div>
        </c:forEach>
    </div>
</div>
<script>
    $(document).ready(function () {
        let memberId = ${sessionScope.memberId};
        getCurationData(memberId);
    });

    function getCurationData(memberId) {
        $.ajax({
            url: '/curation/getCurationData', // 서버 URL 설정
            method: 'GET',
            data: { member_id: memberId }, // 요청 파라미터 설정
            success: function(data) {
                console.log(data);
                document.getElementById('curation').innerHTML = data;
            },
            error: function(xhr, status, error) {
                console.error(error);
            }
        });
    }
</script>
</body>
</html>
