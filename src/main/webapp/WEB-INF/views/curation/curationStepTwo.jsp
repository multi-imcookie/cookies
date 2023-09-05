<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head>
    <title>전과자</title>
    <%@ include file="/link.jsp" %>

</head>
<body>
<%@include file="/header.jsp" %>

<div class="sub-container p-regular">
    <h3 CLASS="h-pre36"> WHAT IS YOUR FAVORITE TASTES? </h3>
    <form action="/curation/curationStepTwo" method="get">

        <div class="allergy-check-btn">
            <input type="checkbox" name="chocolate" id="chocolate" value="1">
            <label for="chocolate"><img src="/resources/img/curation/chocolate.png" alt="chocolate"> 초코 </label>
        </div>

        <div class="allergy-check-btn">
            <input type="checkbox" name="strawberry" id="strawberry" value="1">
            <label for="strawberry"><img src="/resources/img/curation/strawberry.png" alt="strawberry"> 딸기 </label>
        </div>

        <div class="allergy-check-btn">
            <input type="checkbox" name="chili" id="chili" value="1">
            <label for="chili"><img src="/resources/img/curation/chili.png" alt="chili"> 칠리 </label>
        </div>

        <div class="allergy-check-btn">
            <input type="checkbox" name="honey" id="honey" value="1">
            <label for="honey"><img src="/resources/img/curation/honey.png" alt="honey"> 허니 </label>
        </div>
        <div class="btn-wrap-column p-bold">
            <div> 선택하지 않으시면 평점순으로 추천해 드립니다! </div>
            <button class="fill-btn" type="submit"> 취향 선택! </button>
        </div>
    </form>

</div>

<!-- 추가 줄들을 필요한 만큼 생성 -->


<%@include file="/footer.jsp" %>
</body>
</html>
