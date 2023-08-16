<%--
  Created by IntelliJ IDEA.
  User: 고물오빠
  Date: 2023-08-10
  Time: 오후 5:55
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<head>
    <%@ include file="/link.jsp" %>
    <style>
        body {
            font-family: Arial, sans-serif;
        }

        .search-results {
            list-style: none;
            padding: 0;
        }

        .result-item {
            display: flex;
            align-items: center;
            padding: 10px;
            border-bottom: 1px solid #ddd;
        }

        .thumbnail {
            max-width: 100px;
            margin-right: 10px;
        }

        .info {
            flex: 1;
        }

        .title {
            margin: 0;
        }

        .rating {
            color: #FFD700; /* 노란색 */
        }

        .star {
            font-size: 20px;
        }

        .star-half {
            position: relative;
            display: inline-block;
            transform: scaleX(-1); /* 반 별을 만들기 위해 좌우 반전 */
        }

    </style>

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
                <select class="p-regular" id="cookie-select">
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
            <button class="search-btn" type="submit"><img src="/resources/img/search.svg" alt="돋보기 아이콘"></button>
        </div>
    </form>
</div>
검색 결과 총 ${fn:length(searchResult)} 건
<br>
<ul>
    <c:forEach items="${searchResult}" var="search" varStatus="status">
        <li>
            <a href="/snack/snackInfo?snack_id=${search.snack_id}">
                <img src="${search.snack_img}" alt="썸네일">
                <span>${search.snack_name}</span>
                <span>${search.company}</span>
                <span>알러지 항목 : ${search.allergy}</span>
                <span id="rating_${search.snack_id}"></span>
                <script>
                    var rating = ${search.avg_score};
                    var fullStars = Math.floor(rating);
                    var hasHalfStar = rating - fullStars >= 0.5;

                    for (var i = 0; i < fullStars; i++) {
                        document.getElementById("rating_${search.snack_id}").innerHTML += "&#9733;";
                    }
                    if (hasHalfStar) {
                        document.getElementById("rating_${search.snack_id}").innerHTML += "&#9733;";
                    }
                </script>
            </a>
        </li>
    </c:forEach>
</ul>

<%@include file="/footer.jsp" %>
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
</body>



