<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <%@ include file="/link.jsp" %>
</head>
<body>
<div id="curation">
    <h2 class="h-pre24"> 취향에 맞는 과자입니다! </h2>
    <p class="p-medium"> 취향을 선택하지 않았다면 평점 순으로 추천해드립니다. </p>
    <c:forEach items="${curationData}" var="entry">
        <div id="${entry.key}" class="curation-entry">
            <table class="custom-table curation-table">
                <tr class="snack-item">
                    <c:forEach items="${entry.value}" var="value">
                        <td class="curation-snack-info" data-url="/snack/snackWikiInfo?snack_id=${value.snack_id}">
                            <p><img src="${value.snack_img}" alt="${value.snack_name}"></p>
                            <p>${value.snack_name}</p>
                        </td>
                    </c:forEach>
                </tr>
            </table>
        </div>
    </c:forEach>
</div>
<script>
    $(document).ready(function () {
        let memberId = ${sessionScope.memberId};
        getCurationData(memberId);
    });

    // 이벤트 위임을 사용하여 모든 .curation-snack-info에 대한 클릭 이벤트를 처리
    $("#curation").on("click", ".curation-snack-info", function () {
        // 해당 과자의 링크 URL을 가져옴
        var url = $(this).data("url");

        // 링크 URL로 이동
        window.location.href = url;
    });

    function getCurationData(memberId) {
        $.ajax({
            url: '/curation/getCurationData', // 서버 URL 설정
            method: 'GET',
            data: {member_id: memberId}, // 요청 파라미터 설정
            success: function (data) {
                console.log(data);
                document.getElementById('curation').innerHTML = data;
            },
            error: function (xhr, status, error) {
                console.error(error);
            }
        });
    }
</script>
</body>
</html>
