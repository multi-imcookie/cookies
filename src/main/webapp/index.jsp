<%--
  Created by IntelliJ IDEA.
  User: ohlocal
  Date: 2023-08-04
  Time: 오전 9:48
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
<div class="visual">
    <div class="v-left">
        <h3 class="h-pre36">
            🔍<br>
            궁금한 과자가 있으신가요?
        </h3>
        <form action="/snack/snackWikiSearch" method="get">
            <div class="cookie-search main-search">
                <div class="search-wrap">
                    <label class="label-bold" for="keyword">Search</label>
                    <input class="p-regular" type="text" name="keyword" id="keyword" placeholder="검색하고 싶은 과자를 입력하세요.">
                </div>
                <button class="search-btn"><img src="/resources/img/icon/search.svg" alt="돋보기 아이콘"></button>
            </div>
        </form>
        <div class="v-right">

        </div>
    </div>
    <div class="v-right">
        <div class="v-right-view">
            <div class="v-right-warp">
                <%-- v-r-box에 링크 안 넣을거면 div 태그로 변경하세요 --%>
                <a href="#" class="v-r-box box01">
                    <div class="v-r-text">
                        <h4 class="h-pre24">
                            🍪<br>
                            오늘의 과자는?
                        </h4>
                        <p>꼬북칩!</p>
                        <span class="p-regular">
                        오늘 날씨가 어쩌고 저쩌고 그래서 꼬북칩 드셔 보시는 게 어떠실런지 어쩌고<br>
                        무난한 추천 문구 5개정도 돌려 쓰면 좋을 듯
                    </span>
                    </div>
                    <img src="resources/img/design_img/v-right-box-img01.png" alt="꼬북칩">
                </a>
                <a href="#" class="v-r-box box02">
                    <div class="v-r-text">
                        <h4 class="h-pre24">
                            🍪<br>
                            오늘의 과자는?
                        </h4>
                        <p>꼬북칩!</p>
                        <span class="p-regular">
                        오늘 날씨가 어쩌고 저쩌고 그래서 꼬북칩 드셔보시는게 어떠실런지 어쩌고<br>
                        무난한 추천문구 5개정도 돌려쓰면 좋을듯
                    </span>
                    </div>
                    <img src="resources/img/design_img/v-right-box-img01.png" alt="꼬북칩">
                </a>
                <a href="#" class="v-r-box box03">
                    <div class="v-r-text">
                        <h4 class="h-pre24">
                            🍪<br>
                            오늘의 과자는?
                        </h4>
                        <p>꼬북칩!</p>
                        <span class="p-regular">
                        오늘 날씨가 어쩌고 저쩌고 그래서 꼬북칩 드셔보시는게 어떠실런지 어쩌고<br>
                        무난한 추천문구 5개정도 돌려쓰면 좋을듯
                    </span>
                    </div>
                    <img src="resources/img/design_img/v-right-box-img01.png" alt="꼬북칩">
                </a>
            </div>
        </div>
        <div class="slide-btn prev-btn"><img src="resources/img/icon/arrow-left.svg" alt="prev"></div>
        <div class="slide-btn next-btn"><img src="resources/img/icon/arrow-right.svg" alt="next"></div>
    </div>
</div>
<%@include file="footer.jsp" %>
</body>
</html>
