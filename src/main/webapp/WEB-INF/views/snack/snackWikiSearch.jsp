<%@ page language="java" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>


<head>
    <%@ include file="/link.jsp" %>
    <style>
        .p-regular {
            font-family: Pretendard, sans-serif;
            font-size: 16px;
            font-weight: 400; /* weight 다름 */
            line-height: 28px;
        }

        .search-results {
            list-style: none;
            padding-top: 24px;
            display: flex;
            gap: 24px;
            flex-wrap: wrap;
        }

        .search-item {
            background-color: #F9F5F2;
            border-radius: 12px;
            padding: 15px;
            flex-basis: calc(33.33% - 20px); /* 가로 너비를 조절 */
            box-sizing: border-box;
            transition: all .3s;
        }

        .search-item:hover {
            box-shadow: 0 2px 16px 0 rgba(92, 73, 44, 0.25);
        }

        .search-item > a {
            color: #5C492C;
        }

        .thumbnail img {
            display: block;
            margin: 0 auto;
            height: 180px;
            border-radius: 6px;
        }

        .product-name {
            font-family: Pretendard, sans-serif;
            font-size: 16px;
            font-weight: bold;
            line-height: 28px;
            margin-top: 10px;
        }

        .rating {
            margin-top: 5px;
            color: #f39c12; /* 별점 색상 */

        }

        .pagination {
            display: flex;
            align-items: center;
            justify-content: center;
            margin-top: 20px; /* 상단 여백 설정 */
        }

        .pagination a {
            margin: 0 5px; /* 좌우 여백 설정 */
            text-decoration: none;
        }

        .pagination span {
            margin: 0 5px;
            font-weight: bold;
        }
    </style>
    <%@ include file="/link.jsp" %>
    <title>전과자</title>

</head>

<body>

<%@include file="/header.jsp" %>
<div class="sub-container">
    <div class="v-left">
        <h3 class="h-pre36">
            🔍<br>
            궁금한 과자가 있으신가요?
        </h3>
        <form action="snackWikiSearch" method="get">
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
    <div id="search-results-paginated">
        <p class="p-regular">"${keyword}"에 대한 검색 결과 ${totalResults}건</p>
        <div id="search-results" class="search-results">
            <%--검색 결과 총 ${fn:length(searchResult)} 건--%>
            <%--<div class="search-results">--%>
            <c:forEach items="${searchResults}" var="searchDTO" varStatus="status">
                <!-- 검색 결과를 출력 -->
                <div class="search-item">
                        <%--<a href="/snack/snackInfo?snack_id=${search.snack_id}">--%>
                    <a href="javascript:void(0);" class="goToDetail" data-snack-id="${searchDTO.snack_id}">
                        <div class="thumbnail"><img src="${searchDTO.snack_img}" alt="썸네일"></div>
                        <div class="product-name">${searchDTO.snack_name}</div>
                        <c:choose>
                            <c:when test="${searchDTO.avg_score >= 1 && searchDTO.avg_score < 1.5}">
                                <c:set var="scoreImg" value="<img src='/resources/img/score/score01.png' height='18'>" />
                            </c:when>
                            <c:when test="${searchDTO.avg_score >= 1.5 && searchDTO.avg_score < 2}">
                                <c:set var="scoreImg" value="<img src='/resources/img/score/score_01_half.png' height='18'>" />
                            </c:when>
                            <c:when test="${searchDTO.avg_score >= 2 && searchDTO.avg_score < 2.5}">
                                <c:set var="scoreImg" value="<img src='/resources/img/score/score02.png' height='18'>" />
                            </c:when>
                            <c:when test="${searchDTO.avg_score >= 2.5 && searchDTO.avg_score < 3}">
                                <c:set var="scoreImg" value="<img src='/resources/img/score/score_02_half.png' height='18'>" />
                            </c:when>
                            <c:when test="${searchDTO.avg_score >= 3 && searchDTO.avg_score < 3.5}">
                                <c:set var="scoreImg" value="<img src='/resources/img/score/score03.png' height='18'>" />
                            </c:when>
                            <c:when test="${searchDTO.avg_score >= 3.5 && searchDTO.avg_score < 4}">
                                <c:set var="scoreImg" value="<img src='/resources/img/score/score_03_half.png' height='18'>" />
                            </c:when>
                            <c:when test="${searchDTO.avg_score >= 4 && searchDTO.avg_score < 4.5}">
                                <c:set var="scoreImg" value="<img src='/resources/img/score/score04.png' height='18'>" />
                            </c:when>
                            <c:when test="${searchDTO.avg_score >= 4.5 && searchDTO.avg_score < 5}">
                                <c:set var="scoreImg" value="<img src='/resources/img/score/score_04_half.png' height='18'>" />
                            </c:when>
                            <c:when test="${searchDTO.avg_score == 5}">
                                <c:set var="scoreImg" value="<img src='/resources/img/score/score05.png' height='18'>" />
                            </c:when>
                            <c:otherwise />
                        </c:choose>
                        <div>${scoreImg}</div>
<%--                        <div class="rating" id="rating_${search.snack_id}"></div>--%>
<%--                        <script>--%>
<%--                            var rating = ${search.avg_score};--%>
<%--                            var fullStars = Math.floor(rating);--%>
<%--                            var hasHalfStar = rating - fullStars >= 0.5;--%>

<%--                            for (var i = 0; i < fullStars; i++) {--%>
<%--                                document.getElementById("rating_${search.snack_id}").innerHTML += "&#9733;";--%>
<%--                            }--%>
<%--                            if (hasHalfStar) {--%>
<%--                                document.getElementById("rating_${search.snack_id}").innerHTML += "&#9733;";--%>
<%--                            }--%>
<%--                        </script>--%>
                    </a>
                </div>
            </c:forEach>
        </div>
    </div>

    <div class="pagination">
        <a href="#" data-page="1">첫 페이지</a>

        <c:if test="${currentPage > 1}">
            <a href="#" data-page="${currentPage - 1}">&laquo;이전</a>
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
            <a href="#" data-page="${currentPage + 1}">다음&raquo;</a>
        </c:if>

        <a href="#" data-page="${totalPages}">마지막 페이지</a>
    </div>
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
            if (currentPage == null) {
                currentPage = 1;
            }
            localStorage.setItem('currentPage', currentPage);
            window.location.href = '/snack/snackWikiInfo?snack_id=' + snackId;
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

<%@include file="/footer.jsp" %>
</body>

