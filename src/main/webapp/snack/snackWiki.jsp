<%--
  Created by IntelliJ IDEA.
  User: 고물오빠
  Date: 2023-08-09
  Time: 오후 4:45
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<html>
<head>
    <title>전과자</title>
    <%@ include file="/link.jsp" %>
</head>
<body>
<%@include file="/header.jsp" %>

<div class="v-left">
    <h3 class="h-pre36">
        🔍<br>
        궁금한 과자가 있으신가요?
    </h3>
    <form action="snackWikiSearch" method="get" onsubmit="return validateForm()">
        <div class="cookie-search main-search">
            <div class="select-wrap">
                <label class="label-bold" for="cookie-select">Category</label>
                <select class="p-regular" id="cookie-select" >
                    <option value="">카테고리 선택</option>
                    <option value="sweet">달달한</option>
                    <option value="salty">짭쪼름한</option>
                </select>
            </div>
            <span class="div-line"></span>
            <div class="search-wrap">
                <label class="label-bold" for="keyword">Search</label>
                <input class="p-regular" type="text" name="keyword" id="keyword" placeholder="검색하고 싶은 과자 정보를 입력하세요.">
            </div>
            <button class="search-btn" type="submit"><img src="/resources/img/icon/search.svg" alt="돋보기 아이콘"></button>
        </div>
    </form>
</div>




<script>
    function validateForm() {
        let category = document.getElementById("cookie-select").value;
        if (category === "") {
            alert("카테고리를 골라주세요");
            return false;
        }
        return true;
    }
</script>
<%@include file="/footer.jsp" %>
</body>
</html>
