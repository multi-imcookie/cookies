<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head>
    <title>전과자</title>
    <%@ include file="/link.jsp" %>
</head>
<body>
<%@include file="/header.jsp" %>

<div class="sub-container p-regular">
    <div id="allergy" style="display: none;">
        <c:forEach items="${allergyData}" var="allergyName">
            <div class="personal-allergy">${allergyName}</div>
        </c:forEach>
    </div>
    <div id="curation">

    </div>
</div>

<%@include file="/footer.jsp" %>
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
                //document.getElementById('curation').innerHTML = data;
                $('#curation').html(data);
                showAllergy();
            },
            error: function(xhr, status, error) {
                console.error(error);
            }
        });
    }
    function showAllergy() {
        let allergyContent = $("#allergy").html();
        console.log(allergyContent);

        // 값이 비어있지 않으면 #allergy 보이게, 비어있으면 안 보이게
        if (allergyContent.trim() !== "") {
            $("#allergy").show();
        } else {
            $("#allergy").hide();
        }
    }
    </script>
</body>
</html>
