<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head>
    <title>전과자</title>
    <%@ include file="/link.jsp" %>
    <style>
        .button-checkbox {
            display: inline-block;
            padding: 5px 10px;
            background-color: #e0e0e0;
            border: 1px solid #ccc;
            border-radius: 4px;
            cursor: pointer;
            transition: border-color 0.2s, border-width 0.2s, background-color 0.2s; /* 트랜지션 추가 */
        }

        .button-checkbox input[type="checkbox"] {
            display: none;
        }

        .button-checkbox input[type="checkbox"]:checked + .button-label {
            background-color: #3498db;
            color: white;
            border-color: #3498db;
            border-width: 3px;
            user-select: none; /* 텍스트 드래그 방지 */
        }
    </style>


</head>
<body>
<%@include file="/header.jsp" %>

<div class="sub-container">
    <form action="/curation/reCurationStepTwo" method="get">
        <label class="button-checkbox">
            <input type="checkbox" name="chocolate" value="1">
            <span class="button-label">초코</span>
        </label>

        <label class="button-checkbox">
            <input type="checkbox" name="strawberry" value="1">
            <span class="button-label">딸기</span>
        </label>

        <label class="button-checkbox">
            <input type="checkbox" name="chili" value="1">
            <span class="button-label">칠리</span>
        </label>

        <label class="button-checkbox">
            <input type="checkbox" name="honey" value="1">
            <span class="button-label">허니</span>
        </label>

        <button type="submit"> 골랐다 </button>
    </form>
</div>

<!-- 추가 줄들을 필요한 만큼 생성 -->


<%@include file="/footer.jsp" %>
</body>
</html>
