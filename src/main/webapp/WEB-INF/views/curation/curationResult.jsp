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
    <div id="allergy" style="display: none;">
        ${allergyDivContent}
    </div>

    <div id="curation">

    </div>

</div>

<%@include file="/footer.jsp" %>
<script>
    $(document).ready(function () {
        showAllergy();
        let member_id = ${curationDTO.member_id};
        loadCurationData(member_id);
    });
    function showAllergy() {
        // #allergy의 내용 확인

        var allergyContent = $("#allergy").html();
        console.log(allergyContent);

        // 값이 비어있지 않으면 #allergy 보이게, 비어있으면 안 보이게
        if (allergyContent.trim() !== "") {
            $("#allergy").show();
        } else {
            $("#allergy").hide();
        }
    }


    function loadCurationData(member_id) {
        $.ajax({
            url: "/curation/getCurationData/?member_id=" + member_id,
            type: "GET",
            dataType: "json",
            success: function(data) {
                if (data) {
                    // #curation 영역 초기화
                    $("#curation").empty();

                    // JSON 데이터를 순회하면서 정보를 생성하여 #curation에 추가
                    for (let columnName in data) {
                        if (data.hasOwnProperty(columnName)) {
                            let searchDTOList = data[columnName];

                            // 해당 칼럼명을 제목으로 하는 <div> 생성
                            let columnDiv = '<div class="curation-column">';
                            columnDiv += '<h3>' + columnName + '</h3>';

                            // 각각의 SearchDTO에 대해 정보 생성
                            for (let i = 0; i < searchDTOList.length; i++) {
                                let searchDTO = searchDTOList[i];
                                columnDiv += '<div class="search-info">';
                                columnDiv += '<img src="' + searchDTO.snack_img + '" alt="' + searchDTO.snack_name + '">';
                                columnDiv += '<p>이름: ' + searchDTO.snack_name + '</p>';
                                columnDiv += '<p>회사: ' + searchDTO.company + '</p>';
                                // ... 다른 정보 추가 ...
                                columnDiv += '</div>';
                            }

                            columnDiv += '</div>';
                            $("#curation").append(columnDiv);
                        }
                    }
                }
            },
            error: function (xhr, status, error) {
                console.log('Error:', error);
            }
        });
    }
</script>
</body>
</html>
