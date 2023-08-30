<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>게시글 목록</title>
    <%@ include file="/link.jsp" %>
    <script type="text/javascript">
        $(document).ready(function () {
            let formObj = $("form[role='form']");
            console.log(formObj);

            $(".btn-Write").on("click", function () {
                self.location = "reviewWrite";
            });
        });
    </script>
</head>
<body>
<%@ include file="/header.jsp" %>
<div class="sub-container p-regular">
    <h2 class="s-h-imcre24">리뷰 게시판</h2>
    <div class="main-search">
        <div class="select-wrap">
            <label class="label-bold" for="cookie-select">Category</label>
            <select class="p-regular" id="cookie-select">
                <option value="review_title">제목</option>
                <option value="snack_id">과자명</option>
                <option value="member_id">작성자</option>
            </select>
        </div>
        <span class="div-line"></span>
        <div class="search-wrap">
            <label class="label-bold" for="keyword">Search</label>
            <input class="p-regular" type="text" id="keyword" name="keyword" placeholder="검색하고 싶은 내용을 입력하세요.">
        </div>
        <button class="search-btn" id="btn-search"><img src="/resources/img/icon/search.svg" alt="돋보기 아이콘"></button>
    </div>
    <!--    <div>
            <select name="searchType">
                <option value="review_title">제목</option>
                <option value="snack_id">과자명</option>
                <option value="member_id">작성자</option>
            </select>
            <input type="text" name="keyword" />
            <button type="button" id="btn-search">검색</button>
        </div> 유정님이 하신 것 혹시나 기능에 문제가 생길까봐 남겨놓습니다. -->
    <div class="board">
        <div class="board-top">
            <p class="list-count">
                <!-- 레코드의 갯수를 출력 -->
                총 게시글 수 ${map.count}개
            </p>
            <button type="submit" class="btn-Write fill-btn">게시글 작성</button>
        </div>
        <div class="board-list-wrap">
            <c:forEach var="reviewDTO" items="${list}">
                <a href="/review/reviewView?review_id=${reviewDTO.review_id}" class="list-box">
                    <div class="left">
                        <c:if test="${reviewDTO.review_img != null}">
                            <%-- image가 있으면 div 추가 --%>
                            <div class="img-section">
                                    ${reviewDTO.review_img}
                            </div>
                        </c:if>
                        <c:if test="${reviewDTO.review_img == null}">
                            <%-- image가 없으면 div 없음 --%>
                        </c:if>
                        <div class="left-text">
                            <h5 class="h-pre24">${reviewDTO.review_title}</h5>
                            <ul class="p-regular left-bottom">
                                <li>${reviewDTO.review_score}</li>
                                <span></span>
                                <li>${reviewDTO.snack_id}</li>
                                <span></span>
                                <li>${reviewDTO.member_id}</li>
                                <span></span>
                                <li><fmt:formatDate value="${reviewDTO.create_dt}" pattern="HH:mm"/></li>
                            </ul>
                        </div>
                    </div>
                    <div class="right">
                        <div class="reply-count">0</div>
                    </div>
                </a>
            </c:forEach>
        </div>
        <!--        <table class="table table-bordered">
            <tr>
                <th>번호</th>
                <th>사진</th>
                <th>제목</th>
                <th>평점</th>
                <th>과자명</th>
                <th>작성자</th>
                <th>작성시간</th>
            </tr>
            <c:forEach var="reviewDTO" items="${list}">
                <tr>
                    <td>${reviewDTO.review_id}</td>
                    <td>${reviewDTO.review_img}</td>
                    <td><a href='/review/reviewView?review_id=${reviewDTO.review_id}'>${reviewDTO.review_title}</a></td>
                    <td>${reviewDTO.review_score}</td>
                    <td>${reviewDTO.snack_id}</td>
                    <td>${reviewDTO.member_id}</td>
                    <td><fmt:formatDate value="${reviewDTO.create_dt}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                </tr>
            </c:forEach>
        </table> -->
    </div>

    <div>

        <c:if test="${page.prev}">
            <span>[ <a href="/review/reviewList?num=${page.startPageNum - 1}">이전</a> ]</span>
        </c:if>

        <c:forEach begin="${page.startPageNum}" end="${page.endPageNum}" var="num">
            <span>
                <c:if test="${select != num}">
                    <a href="/review/reviewList?num=${num}">${num}</a>
                </c:if>
                <c:if test="${select == num}">
                    <b>${num}</b>
                </c:if>
            </span>
        </c:forEach>
        <c:if test="${page.next}">
            <span>[ <a href="/review/reviewList?num=${page.endPageNum + 1}">다음</a> ]</span>
        </c:if>
    </div>
</div>

<script>
    document.getElementById("btn-search").onclick = function () {

        let searchType = document.getElementsByName("searchType")[0].value;
        let keyword = document.getElementsByName("keyword")[0].value;
        location.href = "/review/reviewList?num=1" + "&searchType=" + searchType + "&keyword=" + keyword;
        console.log(searchType)
        console.log(keyword)
    };
</script>
<%@include file="/footer.jsp" %>
</body>
</html>
