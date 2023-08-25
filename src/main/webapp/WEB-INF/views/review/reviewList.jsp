<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page session="false" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>게시글 목록</title>
    <%@ include file="/link.jsp" %>
    <script type="text/javascript">
        $(document).ready(function(){
            let formObj = $("form[role='form']");
            console.log(formObj);

            $(".btn-Write").on("click", function(){
                self.location = "reviewWrite";
            });
        });
    </script>
</head>
<body>
<%@ include file="/header.jsp" %>
<div class="container">
    <h2>리뷰게시글</h2>

    <div>
        <select name="searchType">
            <option value="review_title">제목</option>
            <option value="snack_id">과자명</option>
            <option value="member_id">작성자</option>
        </select>
        <input type="text" name="keyword" />
        <button type="button" id="btn-search">검색</button>
    </div>


    <div class = "text-center">
        <button type="submit" class="btn-Write">게시글 작성</button>
    </div>
    <div>
        <!-- 레코드의 갯수를 출력 -->
        총 게시글 수 ${map.count}개
    </div>
    <table class="table table-bordered">
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



    </table>

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

    <script>
        document.getElementById("btn-search").onclick = function () {

            let searchType = document.getElementsByName("searchType")[0].value;
            let keyword =  document.getElementsByName("keyword")[0].value;
            location.href = "/review/reviewList?num=1" + "&searchType=" + searchType + "&keyword=" + keyword;
            console.log(searchType)
            console.log(keyword) };
    </script>

</div>
<%@include file="/footer.jsp" %>
</body>
</html>
