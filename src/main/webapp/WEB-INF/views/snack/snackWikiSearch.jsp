<%@ page language="java" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>


<head>
    <%@ include file="/link.jsp" %>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f5f5f5;
            margin: 0;
            padding: 20px;

        }

        .search-results {
            list-style: none;
            padding: 0;
            display: flex;
            flex-wrap: wrap;
            justify-content: space-between; /* 항목들 간 간격을 조절 */
        }

        .search-item {
            background-color: white;
            border-radius: 10px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            margin: 10px 0; /* 상하 여백을 추가 */
            padding: 15px;
            flex-basis: calc(33.33% - 20px); /* 가로 너비를 조절 */
            box-sizing: border-box;
        }

        .thumbnail img {
            max-width: 100%;
            border-radius: 5px;
        }

        .product-name {
            margin-top: 10px;
            font-weight: bold;
        }

        .rating {
            margin-top: 5px;
            color: #f39c12; /* 별점 색상 */
        }
    </style>
    <%@ include file="/link.jsp" %>
    <title>전과자</title>

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
            <button class="search-btn" type="submit"><img src="/resources/img/icon/search.svg" alt="돋보기 아이콘"></button>
        </div>
    </form>
</div>
<div id="search-results-paginated">
    <div id="search-results" class="search-results">
        <%--검색 결과 총 ${fn:length(searchResult)} 건--%>
        <p>"${keyword}"에 대한 검색 결과 ${totalResults}건</p>
        <br>
        <%--<div class="search-results">--%>
        <c:forEach items="${searchResults}" var="search" varStatus="status">
            <!-- 검색 결과를 출력 -->
            <div class="search-item">
                    <%--<a href="/snack/snackInfo?snack_id=${search.snack_id}">--%>
                <a href="javascript:void(0);" class="goToDetail" data-snack-id="${search.snack_id}">
                    <li class="search-item">
                        <div class="thumbnail"><img src="${search.snack_img}" alt="썸네일"></div>
                        <div class="product-name">${search.snack_name}</div>
                        <div class="rating" id="rating_${search.snack_id}"></div>
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

                    </li>
                </a>
            </div>
        </c:forEach>
    </div>
</div>

<div class="pagination">
    <a href="#" data-page="1">첫 페이지</a>

    <c:if test="${currentPage > 1}">
        <a href="#" data-page="${currentPage - 1}">&laquo; 이전</a>
    </c:if>

    <c:forEach var="pageNum" begin="${startPage}" end="${endPage}">
        <c:choose>
            <c:when test="${pageNum == currentPage}">
                <span>${pageNum}</span>
            </c:when>
            <c:otherwise>
                <a href="#" data-page="${pageNum}">${pageNum}</a>
            </c:otherwise>
        </c:choose>
    </c:forEach>

    <c:if test="${endPage < totalPages}">
        <a href="#" data-page="${currentPage + 1}">다음 &raquo;</a>
    </c:if>

    <a href="#" data-page="${totalPages}">마지막 페이지</a>
</div>

<script>

    $(document).ready(function () {
        // 상세 페이지로 이동하는 클릭 이벤트
        $('#search-results-paginated').on('click', '.goToDetail', function () {
            let snackId = $(this).data('snack-id');
            let urlParams = new URL(location.href).searchParams;
            let keyword = urlParams.get('keyword');
            let currentPage = urlParams.get('page');
            localStorage.setItem('keyword', keyword);
            if (currentPage == null){
                currentPage = 1;
            }
            localStorage.setItem('currentPage', currentPage);
            window.location.href = '/snack/snackInfo?snack_id=' + snackId;
        });

        // 페이지 로딩 버튼 클릭 시 AJAX로 페이지 로드
        $(".pagination").on("click", "a", function (event) {
            event.preventDefault();
            let page = $(this).data("page");
            if (!page) {
                return;
            }
            window.location.href = "snackWikiSearch?keyword=${keyword}&page=" + page;
        });
    });

    function loadPage(page) {
        let keyword = "${param.keyword}";
        $.ajax({
            url: "snackWikiSearch",
            type: "GET",
            data: {
                keyword: keyword,
                page: page,
                <%--timestamp: new Date().getTime()--%>
            },
            success: function (data) {
                $("#search-results-paginated").html(data);
            },
            error: function () {
                alert("페이지 로드 실패");
            }
        });
    }

</script>

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

