<%--
  Created by IntelliJ IDEA.
  User: 고물오빠
  Date: 2023-08-09
  Time: 오후 4:45
  To change this template use File | Settings | File Templates.
--%>
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
    <div class="wiki-search">
        <img src="/resources/img/design_img/sub-search-img.png">
        <form class="wiki-form" action="snackWikiSearch" method="get">
            <div class="cookie-search main-search">
                <div class="search-wrap">
                    <label class="label-bold" for="keyword">Search</label>
                    <input class="p-regular" type="text" name="keyword" id="keyword"
                           placeholder="검색하고 싶은 과자 정보를 입력하세요.">
                </div>
                <button class="search-btn" type="submit"><img src="/resources/img/icon/search.svg" alt="돋보기 아이콘">
                </button>
            </div>
        </form>
    </div>
</div>

<%@include file="/footer.jsp" %>
</body>
</html>
