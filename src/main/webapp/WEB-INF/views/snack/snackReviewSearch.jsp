<%@ page language="java" pageEncoding="UTF-8" isELIgnored="false" %>


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
    <title>전과자</title>
</head>

<body>
<div class="sub-container">
    <div>
        <h3 class="s-h-imcre24">
            과자를 골라주세요.
        </h3>
        <form action="/snack/snackReviewSearch" method="get" onsubmit="return validateForm()">
            <div class="cookie-search main-search">
                <div class="select-wrap">
                    <label class="label-bold" for="cookie-select">Category</label>
                    <select class="p-regular" id="cookie-select" name="category">
                        <option value="">검색 항목</option>
                        <option value="all">전체</option>
                        <option value="name">과자 이름</option>
                        <option value="ingredient">원재료</option>
                    </select>
                </div>
                <span class="div-line"></span>
                <div class="search-wrap">
                    <label class="label-bold" for="keyword">Search</label>
                    <input class="p-regular" type="text" name="keyword" id="keyword"
                           placeholder="검색하고 싶은 과자 정보를 입력하세요.">
                </div>
                <button class="search-btn" type="submit"><img src="/resources/img/icon/search.svg" alt="돋보기 아이콘"></button>
            </div>
        </form>
    </div>

    <div id="search-results-paginated" style="display: none;">
        <p class="p-regular">"${keyword}"에 대한 검색 결과 ${totalResults}건</p>
        <div id="search-results" class="search-results">
            <%--검색 결과 총 ${fn:length(searchResult)} 건--%>
            <%--<div class="search-results">--%>
            <c:forEach items="${searchResults}" var="searchDTO" varStatus="status">
                <!-- 검색 결과를 출력 -->
                <div class="search-item">
                        <%--<a href="/snack/snackInfo?snack_id=${search.snack_id}">--%>
                    <a href="javascript:void(0);" class="goToDetail" data-snack-id="${searchDTO.snack_id}">
                        <div class="thumbnail search-thumbnail" style="background-image: url(${searchDTO.snack_img})"></div>
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
                            <c:otherwise><c:set var="scoreImg" value="" /></c:otherwise>
                        </c:choose>
                        <div>${scoreImg}</div>
                    </a>
                </div>
            </c:forEach>
        </div>
    </div>


    <div class="pagination" style="display: none;">
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
</div>

<script>
    $(document).ready(function () {
        let keyword = "${param.keyword}";
        if (keyword !== "") {
            $("#search-results-paginated").show(); // 검색 키워드가 있을 경우에만 요소 보이도록 처리
            $(".pagination").show(); // 검색 키워드가 있을 경우에만 요소 보이도록 처리
        }

        // 상세 페이지를 DIV 영역 내에서 로드하는 클릭 이벤트
        $('#search-results-paginated').on('click', '.goToDetail', function () {
            let snackId = $(this).data('snack-id');
            let urlParams = new URL(location.href).searchParams;
            let keyword = urlParams.get('keyword');
            let category = urlParams.get('category');
            let currentPage = urlParams.get('page');
            localStorage.setItem('keyword', keyword);
            localStorage.setItem('category', category);
            if (currentPage == null) {
                currentPage = 1;
            }
            localStorage.setItem('currentPage', currentPage);
            window.location.href = '/snack/snackReviewSearchInfo?category=' + category + '&snack_id=' + snackId;
        });

        // 페이지 로딩 버튼 클릭 시 AJAX로 페이지 로드
        $(".pagination").on("click", "a", function (event) {
            event.preventDefault();
            let page = $(this).data("page");
            if (!page) {
                return;
            }
            window.location.href = "snackReviewSearch?category=" + ${category} + "&keyword=${keyword}&page=" + page;
        });

    });
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

