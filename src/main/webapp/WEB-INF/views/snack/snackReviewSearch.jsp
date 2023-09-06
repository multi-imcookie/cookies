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
<%@include file="/filterModal.jsp"%>
<div class="sub-container">
    <h3 class="s-h-imcre24">
        과자를 골라주세요.
    </h3>
    <form id="snackWikiSearchForm" action="/snack/snackReviewSearch" method="get"
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

    <%@include file="/filter.jsp" %>

    <span id="checkedAllergies">
    </span>

    <div id="search-results-paginated" style="display: none;">
        <p class="p-regular">"${keyword}"에 대한 검색 결과 ${totalResults}건</p>
        <div id="sort-form" class="p-regular">
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
        ;

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
                window.location.href = "snackReviewSearch?category=" + category + "&keyword=" + keyword + "&sortName=" + sortName + "&selectedAllergies=" + selectedAllergies + "&page=" + currentPage;
            });
        };

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
            ;
            let urlParams = new URL(location.href).searchParams;
            let keyword = urlParams.searchParams.get('keyword');
            let category = urlParams.searchParams.get('category');
            let sortName = urlParams.searchParams.get('sortName');
            let selectedAllergies = urlParams.searchParams.get('selectedAllergies');
            window.location.href = "snackReviewSearch?category=" + category + "&keyword=" + keyword + "&sortName=" + sortName + "&selectedAllergies=" + selectedAllergies + "&page=" + page;
        });

        // 상세 페이지를 DIV 영역 내에서 로드하는 클릭 이벤트
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
            window.location.href = '/snack/snackReviewSearchInfo?category=' + category + "&keyword=" + keyword + "&sortName=" + sortName + "&selectedAllergies=" + selectedAllergies + "&snack_id=" + snackId + "&page=" + currentPage;
        });
        // 정렬 후에 이벤트 다시 등록
        $(document).ajaxComplete(function () {
            attachSortClickEvent();
        });
    });
    $("#checkingAllergies").click(function () {
        modalShow();
    });

    $("#modal-close").click(function () {
        // 모달 내의 모든 체크 박스를 선택하고 해제합니다.
        $(".allergy-check-btn input[type='checkbox']").prop("checked", false);

        // 선택한 알레르기 정보를 출력할 div 요소 가져오기
        let checkedAllergiesDiv = $("#checkedAllergies");

        // 기존 정보를 지우기 위해 div 내용을 비웁니다.
        checkedAllergiesDiv.empty();
        modalHide();
    });

    // 알레르기 정보 출력 후, span 클릭 시 동작
    $("#checkedAllergies").on("click", ".checked-allergy", function () {
        // 클릭한 요소가 이미지인 경우에만 실행
        if ($(event.target).is("img")) {
            // 클릭한 span 요소를 제거합니다.
            $(this).remove();

            // 해당 span 요소에 연결된 체크박스의 ID 가져오기
            let checkboxId = $(this).attr("data-checkbox-id");

            // 해당 ID를 가진 체크박스의 체크를 해제합니다.
            $("#" + checkboxId).prop("checked", false);

            // 체크박스의 변경 이벤트를 트리거하여 체크박스 상태가 변경되었음을 감지합니다.
            $("#" + checkboxId).trigger("change");
        }
    });


    $("#checkedAllergiesData").click(function () {
        // 선택한 알레르기 정보를 출력할 div 요소 가져오기
        let checkedAllergiesSpan = $("#checkedAllergies");

        // 기존 정보를 지우기 위해 div 내용을 비웁니다.
        checkedAllergiesSpan.empty();

        // 체크된 모든 체크박스 값을 수집하거나 처리할 데이터를 여기에서 구성
        let selectedAllergies = [];

        // 예시: 선택된 체크박스 값을 수집
        $('input[name="selectedAllergies"]:checked').each(function () {
            let allergy = $(this).val();
            selectedAllergies.push(allergy);

            // 선택한 알레르기 정보를 개별 span으로 생성하고 출력
            let labelForAllergy = $('label[for="' + this.id + '"]').html(); // 체크박스에 연결된 라벨 내용 가져오기
            let checkboxId = this.id; // 체크박스의 ID 가져오기
            let allergySpan = $("<span>").html(labelForAllergy).addClass('checked-allergy').attr('data-checkbox-id', checkboxId); // 라벨 내용을 span에 추가

            // 이미지 요소 생성 및 추가
            let img = $("<img>").attr('src', '/resources/img/curation/delete_btn.svg').addClass('del-allergy-btn');
            allergySpan.append(img);

            checkedAllergiesSpan.append(allergySpan);
        });

// 모달을 숨깁니다.
        modalHide();
    });

    function submitSortRequest(sortName, keyword, category) {
        $.ajax({
            url: "snackReviewSearch",
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
    };


    function validateFormAndAddAllergyData() {

        let category = document.getElementById("cookie-select").value;
        let keyword = document.getElementById("keyword").value; // 검색어 입력란 값 가져오기
        if (category === "") {
            alert("카테고리를 골라주세요");
            return false;
        }
        if (keyword.trim() === "") { // 검색어가 공백 문자로만 이루어져 있으면 검색 막기
            alert("검색어를 입력해주세요.");
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
</body>

