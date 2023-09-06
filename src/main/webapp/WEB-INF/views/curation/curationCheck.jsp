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
            <div class="personal-allergy" id="${allergyName}">
                <script>
                    var allergyNameWithoutSuffix = "/resources/img/curation/" + "${allergyName}".replace("_allergy", "");
                    var img = document.createElement("img");
                    img.src = allergyNameWithoutSuffix + ".png";
                    // 이미지와 공백을 <span> 요소에 넣어 처리

                    var span = document.createElement("span");
                    span.appendChild(img);

                    var space = document.createTextNode(" ");
                    span.appendChild(space);

                    document.getElementById("${allergyName}").appendChild(span);

                    // JavaScript 배열을 사용하여 알레르기 이름을 대체
                    var allergyMapping = {
                        "egg_allergy": "계란 알레르기",
                        "milk_allergy": "우유 알레르기",
                        "wheat_allergy": "밀 알레르기",
                        "buckwheat_allergy": "메밀 알레르기",
                        "peanut_allergy": "땅콩 알레르기",
                        "soy_allergy": "대두 알레르기",
                        "pine_nut_allergy": "잣 알레르기",
                        "almond_allergy": "아몬드 알레르기",
                        "walnut_allergy": "호두 알레르기",
                        "crab_allergy": "게 알레르기",
                        "shrimp_allergy": "새우 알레르기",
                        "squid_allergy": "오징어 알레르기",
                        "mackerel_allergy": "고등어 알레르기",
                        "shellfish_allergy": "조개류 알레르기",
                        "peach_allergy": "복숭아 알레르기",
                        "tomato_allergy": "토마토 알레르기",
                        "chicken_allergy": "닭고기 알레르기",
                        "pork_allergy": "돼지고기 알레르기",
                        "beef_allergy": "쇠고기 알레르기"
                        // 나머지 알레르기 이름들을 추가하세요
                    };
                    span.appendChild(document.createTextNode(allergyMapping["${allergyName}"] || "${allergyName}"));
                </script>
                <span id="${allergyName}"></span>
            </div>
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
            data: {member_id: memberId}, // 요청 파라미터 설정
            success: function (data) {
                console.log(data);
                //document.getElementById('curation').innerHTML = data;
                $('#curation').html(data);
                showAllergy();
            },
            error: function (xhr, status, error) {
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
    // 알레르기 이름을 대체하는 함수
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
