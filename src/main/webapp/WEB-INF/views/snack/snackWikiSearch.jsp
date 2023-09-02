<%@ page language="java" pageEncoding="UTF-8" isELIgnored="false" %>


<head>
    <%@ include file="/link.jsp" %>
    <style>
        /* 버튼 스타일 적용 */
        .selected-page {
            background-image: url("/resources/img/entertainment/cookie-bite.png")!important;
            background-size: contain; /* 이미지를 버튼에 꽉 채우도록 설정 */
            background-repeat: no-repeat;
            width: 40px;
            height: 40px;
            text-align: center;
            font-size: 20px;
            font-weight: bold;
            color: #784132;
        }

        /* 페이지 버튼 스타일 적용 */
        .page-buttons {
            display: flex;
            justify-content: center; /* 수평 가운데 정렬 */
            gap: 5px; /* 버튼 사이의 간격 */

        }

        .page-button{
            background-image: url("/resources/img/entertainment/cookie.png");
            background-size: contain; /* 이미지를 버튼에 꽉 채우도록 설정 */
            background-repeat: no-repeat;
            width: 40px;
            height: 40px;
            text-align: center;
            font-size: 20px;
            font-weight: bold;
            color: #784132;
        }

        .page-button:hover {
            color: #F9F5F2; /* 호버시 글자 색상 변경 */
        }

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
    <title>전과자</title>

</head>

<body>
<%@include file="/header.jsp" %>
<div class="modal-overlay">
    <div class="allergy-modal-box modal-box">
        <div class="mdl-text">
            <button type="button" id="modal-close" class="btn-close" aria-label="Close"></button>
            <div class="s-h-imcre24">알레르기 체크</div>
            <div class="modal-detail-content p-regular">
                <table class="custom-table">
                    <tr class="allergy-check-box">
                        <td class="allergy-check-btn">
                            <input type="checkbox" name="selectedAllergies" value="egg_allergy" id="egg_allergy">
                            <label for="egg_allergy"><img src="/images/egg.png" alt="egg"> 난류 알레르기 </label>
                        </td>
                        <td class="allergy-check-btn">
                            <input type="checkbox" name="selectedAllergies" value="milk_allergy" id="milk_allergy">
                            <label for="milk_allergy"><img src="/images/milk.png" alt="milk"> 우유 알레르기 </label>
                        </td>
                        <td class="allergy-check-btn">
                            <input type="checkbox" name="selectedAllergies" value="wheat_allergy" id="wheat_allergy">
                            <label for="wheat_allergy"><img src="/images/wheat.png" alt="wheat"> 밀 알레르기</label>
                        </td>
                    </tr>
                    <tr class="allergy-check-box">
                        <td class="allergy-check-btn">
                            <input type="checkbox" name="selectedAllergies" value="buckwheat_allergy"
                                   id="buckwheat_allergy">
                            <label for="buckwheat_allergy"><img src="/images/buckwheat.png" alt="buckwheat"> 메밀
                                알레르기</label>
                        </td>
                        <td class="allergy-check-btn">
                            <input type="checkbox" name="selectedAllergies" value="peanut_allergy" id="peanut_allergy">
                            <label for="peanut_allergy"><img src="/images/peanut.png" alt="peanut"> 땅콩 알레르기</label>
                        </td>
                        <td class="allergy-check-btn">
                            <input type="checkbox" name="selectedAllergies" value="soy_allergy" id="soy_allergy">
                            <label for="soy_allergy"><img src="/images/soy.png" alt="soy"> 대두 알레르기</label>
                        </td>
                    </tr>
                    <tr class="allergy-check-box">
                        <td class="allergy-check-btn">
                            <input type="checkbox" name="selectedAllergies" value="pine_nut_allergy"
                                   id="pine_nut_allergy">
                            <label for="pine_nut_allergy"><img src="/images/pine_nut.png" alt="pine_nut"> 잣 알레르기</label>
                        </td>
                        <td class="allergy-check-btn">
                            <input type="checkbox" name="selectedAllergies" value="almond_allergy" id="almond_allergy">
                            <label for="almond_allergy"><img src="/images/almond.png" alt="almond"> 아몬드 알레르기</label>
                        </td>
                        <td class="allergy-check-btn">
                            <input type="checkbox" name="selectedAllergies" value="walnut_allergy" id="walnut_allergy">
                            <label for="walnut_allergy"><img src="/images/walnut.png" alt="walnut"> 호두 알레르기</label>
                        </td>
                    </tr>
                    <tr class="allergy-check-box">
                        <td class="allergy-check-btn">
                            <input type="checkbox" name="selectedAllergies" value="crab_allergy" id="crab_allergy">
                            <label for="crab_allergy"><img src="/images/crab.png" alt="crab"> 게 알레르기</label>
                        </td>
                        <td class="allergy-check-btn">
                            <input type="checkbox" name="selectedAllergies" value="shrimp_allergy" id="shrimp_allergy">
                            <label for="shrimp_allergy"><img src="/images/shrimp.png" alt="shrimp"> 새우 알레르기</label>
                        </td>
                        <td class="allergy-check-btn">
                            <input type="checkbox" name="selectedAllergies" value="squid_allergy" id="squid_allergy">
                            <label for="squid_allergy"><img src="/images/squid.png" alt="squid"> 오징어 알레르기</label>
                        </td>
                    </tr>
                    <tr class="allergy-check-box">
                        <td class="allergy-check-btn">
                            <input type="checkbox" name="selectedAllergies" value="mackerel_allergy"
                                   id="mackerel_allergy">
                            <label for="mackerel_allergy"><img src="/images/mackerel.png" alt="mackerel"> 고등어
                                알레르기</label>
                        </td>
                        <td class="allergy-check-btn">
                            <input type="checkbox" name="selectedAllergies" value="shellfish_allergy"
                                   id="shellfish_allergy">
                            <label for="shellfish_allergy"><img src="/images/shellfish.png" alt="shellfish"> 조개류
                                알레르기</label>
                        </td>
                        <td class="allergy-check-btn">
                            <input type="checkbox" name="selectedAllergies" value="peach_allergy" id="peach_allergy">
                            <label for="peach_allergy"><img src="/images/peach.png" alt="peach"> 복숭아 알레르기</label>
                        </td>
                    </tr>
                    <tr class="allergy-check-box">
                        <td class="allergy-check-btn">
                            <input type="checkbox" name="selectedAllergies" value="tomato_allergy" id="tomato_allergy">
                            <label for="tomato_allergy"><img src="/images/tomato.png" alt="tomato"> 토마토 알레르기</label>
                        </td>
                        <td class="allergy-check-btn">
                            <input type="checkbox" name="selectedAllergies" value="chicken_allergy"
                                   id="chicken_allergy">
                            <label for="chicken_allergy"><img src="/images/chicken.png" alt="chicken"> 닭고기 알레르기</label>
                        </td>
                        <td class="allergy-check-btn">
                            <input type="checkbox" name="selectedAllergies" value="pork_allergy" id="pork_allergy">
                            <label for="pork_allergy"><img src="/images/pork.png" alt="pork"> 돼지고기 알레르기</label>
                        </td>
                    </tr>
                    <tr class="allergy-check-box">
                        <td class="allergy-check-btn">
                            <input type="checkbox" name="selectedAllergies" value="beef_allergy" id="beef_allergy">
                            <label for="beef_allergy"><img src="/images/beef.png" alt="beef"> 쇠고기 알레르기</label>
                        </td>
                    </tr>
                </table>
            </div>
        </div>
        <button type="button" id="checkedAllergiesData"> 확인</button>
    </div>
</div>
<div class="sub-container">
    <div class="v-left">
        <h3 class="h-pre36">
            🔍<br>
            궁금한 과자가 있으신가요?
        </h3>
        <form id="snackWikiSearchForm" action="snackWikiSearch" method="get"
              onsubmit="return validateFormAndAddAllergyData()">
            <div class="cookie-search main-search">
                <div class="select-wrap">
                    <label class="label-bold" for="cookie-select">Category</label>
                    <select class="p-regular" id="cookie-select" name="category">
                        <option value="">검색 항목</option>
                        <option value="all" selected>전체</option>
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
                <input type="hidden" name="sortName" value="sortHighCalorie">
                <button class="search-btn" type="submit"><img src="/resources/img/icon/search.svg" alt="돋보기 아이콘">
                </button>
            </div>
        </form>
        <div class="btn-wrap-row">
            <button class="fill-btn" id="checkingAllergies">알러지 체크</button>
        </div>
    </div>
    <div id="search-results-paginated">
        <p class="p-regular">"${keyword}"에 대한 검색 결과 ${totalResults}건</p>
        <div id="sort-form">
            <button id="sortHighCalorie" class="sort-btn">칼로리 ▲</button>
            <button id="sortLowCalorie" class="sort-btn">칼로리 ▼</button>
            <button id="sortHighSugar" class="sort-btn">당 ▲</button>
            <button id="sortLowSugar" class="sort-btn">당 ▼</button>
            <button id="sortHighProtein" class="sort-btn">단백질 ▲</button>
            <button id="sortLowProtein" class="sort-btn">단백질 ▼</button>
            <button id="sortHighFat" class="sort-btn">지방 ▲</button>
            <button id="sortLowFat" class="sort-btn">지방 ▼</button>
            <button id="sortHighScore" class="sort-btn">평점 ▲</button>
            <button id="sortLowScore" class="sort-btn">평점 ▼</button>
        </div>

        <div id="search-results" class="search-results">
            <%--검색 결과 총 ${fn:length(searchResult)} 건--%>
            <%--<div class="search-results">--%>
            <c:forEach items="${searchResults}" var="searchDTO" varStatus="status">
                <!-- 검색 결과를 출력 -->
                <div class="search-item">
                        <%--<a href="/snack/snackInfo?snack_id=${search.snack_id}">--%>
                    <a href="javascript:void(0);" class="goToDetail" data-snack-id="${searchDTO.snack_id}">
                        <div class="thumbnail search-thumbnail"
                             style="background-image: url(${searchDTO.snack_img})"></div>
                        <div class="product-name">${searchDTO.snack_name}</div>
                        <c:choose>
                            <c:when test="${searchDTO.avg_score >= 1 && searchDTO.avg_score < 1.5}">
                                <c:set var="scoreImg" value="<img src='/resources/img/score/score01.png' height='18'>"/>
                            </c:when>
                            <c:when test="${searchDTO.avg_score >= 1.5 && searchDTO.avg_score < 2}">
                                <c:set var="scoreImg"
                                       value="<img src='/resources/img/score/score_01_half.png' height='18'>"/>
                            </c:when>
                            <c:when test="${searchDTO.avg_score >= 2 && searchDTO.avg_score < 2.5}">
                                <c:set var="scoreImg" value="<img src='/resources/img/score/score02.png' height='18'>"/>
                            </c:when>
                            <c:when test="${searchDTO.avg_score >= 2.5 && searchDTO.avg_score < 3}">
                                <c:set var="scoreImg"
                                       value="<img src='/resources/img/score/score_02_half.png' height='18'>"/>
                            </c:when>
                            <c:when test="${searchDTO.avg_score >= 3 && searchDTO.avg_score < 3.5}">
                                <c:set var="scoreImg" value="<img src='/resources/img/score/score03.png' height='18'>"/>
                            </c:when>
                            <c:when test="${searchDTO.avg_score >= 3.5 && searchDTO.avg_score < 4}">
                                <c:set var="scoreImg"
                                       value="<img src='/resources/img/score/score_03_half.png' height='18'>"/>
                            </c:when>
                            <c:when test="${searchDTO.avg_score >= 4 && searchDTO.avg_score < 4.5}">
                                <c:set var="scoreImg" value="<img src='/resources/img/score/score04.png' height='18'>"/>
                            </c:when>
                            <c:when test="${searchDTO.avg_score >= 4.5 && searchDTO.avg_score < 5}">
                                <c:set var="scoreImg"
                                       value="<img src='/resources/img/score/score_04_half.png' height='18'>"/>
                            </c:when>
                            <c:when test="${searchDTO.avg_score == 5}">
                                <c:set var="scoreImg" value="<img src='/resources/img/score/score05.png' height='18'>"/>
                            </c:when>
                            <c:otherwise><c:set var="scoreImg" value=""/></c:otherwise>
                        </c:choose>
                        <div>${scoreImg}</div>
                    </a>
                </div>
            </c:forEach>
        </div>
    </div>

    <div class="pagination page-buttons" id="pagination">
        <a href="#" data-page="1">첫 페이지</a>

        <c:if test="${currentPage > 1}">
            <a href="#" data-page="${currentPage - 1}">&laquo;이전</a>
        </c:if>

        <c:forEach var="pageNum" begin="${startPage}" end="${endPage}">
            <c:choose>
                <c:when test="${pageNum == currentPage}">
                    <a class="page-button selected-page" href="#">${pageNum}</a>
                </c:when>
                <c:otherwise>
                    <a class="page-button" href="#" data-page="${pageNum}">${pageNum}</a>
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
        function attachSortClickEvent() {
            $('#sort-form .sort-btn').click(function () {
                let sortName = $(this).attr("id");
                let urlParams = new URL(location.href);
                let keyword = urlParams.searchParams.get('keyword');
                let category = urlParams.searchParams.get('category');
                let selectedAllergies = urlParams.searchParams.get('selectedAllergies');
                // 페이지를 1로 설정하여 정렬 후 첫 페이지로 이동
                let currentPage = 1;
                urlParams.searchParams.set('sortName', sortName);
                window.location.href = "snackWikiSearch?category=" + category + "&keyword=" + keyword + "&sortName=" + sortName + "&selectedAllergies=" + selectedAllergies + "&page=" + currentPage;
            });
        }

        attachSortClickEvent(); // 초기 정렬 버튼 클릭 이벤트 등록


        $("#sort-form").on("click", ".sort-btn", function (event) {
            event.preventDefault();
            let sortName = $(this).attr("id");
            let urlParams = new URL(location.href).searchParams;
            urlParams.set('sortName', sortName);
            let keyword = urlParams.get('keyword');
            let category = urlParams.get('category');
            submitSortRequest(sortName, keyword, category);
        });
        // 페이지 로딩 버튼 클릭 시 AJAX로 페이지 로드
        $(".pagination").on("click", "a", function (event) {
            event.preventDefault();
            let page = $(this).data("page");
            if (!page) {
                return;
            }
            let urlParams = new URL(location.href)
            let keyword = urlParams.searchParams.get('keyword');
            let category = urlParams.searchParams.get('category');
            let sortName = urlParams.searchParams.get('sortName');
            let selectedAllergies = urlParams.searchParams.get('selectedAllergies');
            window.location.href = "snackWikiSearch?category=" + category + "&keyword=" + keyword + "&sortName=" + sortName + "&selectedAllergies=" + selectedAllergies + "&page=" + page;
        });

        // 상세 페이지로 이동하는 클릭 이벤트
        $('#search-results-paginated').on('click', '.goToDetail', function () {
            let snackId = $(this).data('snack-id');
            let urlParams = new URL(location.href);
            let keyword = urlParams.searchParams.get('keyword');
            let category = urlParams.searchParams.get('category');
            let currentPage = urlParams.searchParams.get('page');
            let sortName = urlParams.searchParams.get('sortName');
            let selectedAllergies = urlParams.searchParams.get('selectedAllergies');
            if (currentPage == null) {
                currentPage = 1;
            }
            window.location.href = "/snack/snackWikiInfo?category=" + category + "&keyword=" + keyword + "&sortName=" + sortName + "&selectedAllergies=" + selectedAllergies + "&snack_id="+ snackId + "&page=" + currentPage;
        });
        // 정렬 후에 이벤트 다시 등록
        $(document).ajaxComplete(function () {
            attachSortClickEvent();
        });

        $("#checkingAllergies").click(function () {
            modalShow();
        });

        $("#modal-close").click(function () {
            // 모달 내의 모든 체크 박스를 선택하고 해제합니다.
            $(".allergy-check-btn input[type='checkbox']").prop("checked", false);
            modalHide();
        });

        $("#checkedAllergiesData").click(function () {
            modalHide();
        });
    });

    function submitSortRequest(sortName, keyword, category) {
        console.log(keyword, category);
        $.ajax({
            url: "snackWikiSearch",
            type: "GET",
            data: {
                sortName: sortName,
                keyword: keyword,
                category: category,
            },
            success: function (data) {
                // 검색 결과를 업데이트하는 코드 작성
                console.log(data)
                let $data = $(data);

                // 페이지내의 특정 부분을 찾아 업데이트
                $("#search-results-paginated").html($data.find("#search-results-paginated").html());
                $("#pagination").html($data.find("#pagination").html());

            },
            error: function () {
                alert("정렬 실패");
            }
        });
    }

    function validateFormAndAddAllergyData() {

        let category = document.getElementById("cookie-select").value;
        if (category === "") {
            alert("카테고리를 골라주세요");
            return false;
        }
        // 체크된 모든 체크박스 값을 수집하거나 처리할 데이터를 여기에서 구성
        let selectedAllergies = [];

        // 예시: 선택된 체크박스 값을 수집
        $('input[name="selectedAllergies"]:checked').each(function () {
            selectedAllergies.push($(this).val());
        });

        // 폼 데이터로 선택된 알레르기를 추가
        let selectedAllergiesField = document.createElement('input');
        selectedAllergiesField.setAttribute('type', 'hidden');
        selectedAllergiesField.setAttribute('name', 'selectedAllergies'); // 이름 설정
        selectedAllergiesField.setAttribute('value', selectedAllergies.join(','));

        // 폼에 폼 필드 추가
        let form = document.getElementById('snackWikiSearchForm');
        form.appendChild(selectedAllergiesField);

        // 폼 제출
        form.submit();
        return true;
    }


</script>
<%@include file="/footer.jsp" %>
</body>

