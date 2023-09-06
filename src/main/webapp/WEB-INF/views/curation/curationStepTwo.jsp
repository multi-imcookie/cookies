<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head>
    <title>전과자</title>
    <%@ include file="/link.jsp" %>

</head>
<body>
<%@include file="/header.jsp" %>

<div class="sub-container p-regular">
    <div class="favorite-text">
        <h3 CLASS="h-pre36">무슨 맛을 가장 좋아하시나요? 😋</h3>
        <p class="p-medium">선택하지 않으시면 평점순으로 추천해 드립니다!</p>
    </div>
    <form action="/curation/curationStepTwo" method="get" class="favorite-form">
        <div class="curation-favorite-container">
            <div class="favorite-section">
                <div class="curation-favorite-item">
                    <input type="checkbox" name="chocolate" id="chocolate" value="1">
                    <label for="chocolate" class="h-imcre24"><img src="/resources/img/curation/chocolate.png"
                                                                  alt="chocolate"> 초코
                    </label>
                </div>
                <div class="curation-favorite-item">
                    <input type="checkbox" name="strawberry" id="strawberry" value="1">
                    <label for="strawberry" class="h-imcre24"><img src="/resources/img/curation/strawberry.png"
                                                                   alt="strawberry"> 딸기
                    </label>
                </div>
            </div>
            <div class="favorite-section">
                <div class="curation-favorite-item">
                    <input type="checkbox" name="chili" id="chili" value="1">
                    <label for="chili" class="h-imcre24"><img src="/resources/img/curation/chili.png" alt="chili"> 칠리
                    </label>
                </div>
                <div class="curation-favorite-item">
                    <input type="checkbox" name="honey" id="honey" value="1">
                    <label for="honey" class="h-imcre24"><img src="/resources/img/curation/honey.png" alt="honey"> 허니
                    </label>
                </div>
            </div>
        </div>
        <button class="fill-btn" type="submit"> 취향 선택!</button>
    </form>
</div>


<%@include file="/footer.jsp" %>
</body>
</html>
