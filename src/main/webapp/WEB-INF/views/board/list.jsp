<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
<head>
    <meta charset="UTF-8">
    <title>자유게시글 목록</title>
    <%@ include file="/link.jsp" %>
    <style>
        .list-box li:first-child {
            color: #CBB89B;
        }
    </style>
</head>

<body>
    <%@include file="/header.jsp" %>
    <div class="sub-container p-regular">
        <h2 class="s-h-imcre24">자유 게시판</h2>
        <div class="main-search">
            <div class="select-wrap">
                <label class="label-bold" for="searchType">Category</label>
                <select class="p-regular" name="searchType" id="searchType">
                    <option value="bbs_title" <c:if test="${page.searchType eq 'bbs_title'}">selected</c:if>>제목</option>
                    <option value="bbs_content" <c:if test="${page.searchType eq 'bbs_content'}">selected</c:if>>내용</option>
                    <option value="member_id" <c:if test="${page.searchType eq 'member_id'}">selected</c:if>>작성자</option>
                </select>
            </div>
            <span class="div-line"></span>
            <div class="search-wrap">
                <label class="label-bold" for="keyword">Search</label>
                <input class="p-regular" type="text" id="keyword" name="keyword" placeholder="검색하고 싶은 내용을 입력하세요." value="${page.keyword}">
            </div>
            <button class="search-btn" id="searchBtn"><img src="/resources/img/icon/search.svg" alt="돋보기 아이콘"></button>
        </div>

<!-- 혹시몰라서 서희님이 해두신거 원본 남겨요! -진기
        <form action="list" method="get">
            <select name="searchType">
                <option value="bbs_title" <c:if test="${page.searchType eq 'bbs_title'}">selected</c:if>>제목</option>
                <option value="bbs_content" <c:if test="${page.searchType eq 'bbs_content'}">selected</c:if>>내용</option>
                <option value="member_id" <c:if test="${page.searchType eq 'member_id'}">selected</c:if>>작성자</option>
            </select>

            <input type="text" name="keyword" value="${page.keyword}"/>

            <button type="button" id="searchBtn">검색</button>
            </form>
-->
            <%--  <select name="category">--%>
            <%--    <option value="question">질문게시판</option>--%>
            <%--    <option value="free">자유게시판</option>--%>
            <%--  </select>--%>
            <%--  <input type="text" name="keyword" placeholder="검색어를 입력하세요">--%>
            <%--  <button type="submit">검색</button>--%>
        <div class="board">
            <div class="board-top">
                <p class="list-count">
                    <!-- 게시글 총 개수 출력하는 부분! 없는거 같아서 일단 비워둠 -->
                </p>
                <button class="btn-Write fill-btn" id="writeButton">게시글 작성</button>
            </div>
            <div class="board-list-wrap">
                <c:forEach items="${list}" var="list">
                <a href="/board/view?bbs_id=${list.bbs_id}" class="list-box">
                    <div class="left">
                        <div class="left-text">
                            <h5 class="h-pre24">${list.bbs_title}</h5>
                            <ul class="p-regular left-bottom">
                                <li>${list.member_id}</li>
                                <span></span>
                                <li><c:set var="today" value="<%= new java.util.Date() %>" />
                                    <c:choose>
                                        <c:when test="${fn:substring(fn:replace(fn:trim(fn:substring(fn:substringBefore(list.create_dt, ' '), 0, 10)), '-', ''), 0, 10) eq fn:substring(fn:replace(fn:trim(fn:substring(fn:substringBefore(today, ' '), 0, 10)), '-', ''), 0, 10)}">
                                            <!-- 작성일이 오늘일 경우 -->
                                            <fmt:formatDate value="${list.create_dt}" pattern="HH:mm"/>
                                        </c:when>
                                        <c:otherwise>
                                            <!-- 작성일이 오늘이 아닐 경우 -->
                                            <fmt:formatDate value="${list.create_dt}" pattern="yyyy년 MM월 dd일 HH:mm"/>
                                        </c:otherwise>
                                    </c:choose></li>
                                <span></span>
                                <td>조회수 ${list.bbs_views}</td>
                            </ul>
                        </div>
                    </div>
                    <div class="right">
                    </div>
                </a>
                </c:forEach>
            </div>
        </div>
    </div>
        <!-- 서희님 원본2
        <table>
            <thead>
            <tr>
                <p><a href="write">글 작성하기</a></p><br>
                <th>번호</th>
                <th>제목</th>
                <th>작성자</th>
                <th>작성일</th>
                <th>조회수</th>
            </tr>
            </thead>

            <tbody>
            <c:forEach items="${list}" var="list">
                <tr>
                    <td>${list.bbs_id}</td>
                    <td>
                        <a href="/board/view?bbs_id=${list.bbs_id}">${list.bbs_title}</a>
                    </td>
                    <td>${list.member_id}</td>
                    <td>
                        <fmt:formatDate value="${list.create_dt}" pattern="yyyy-MM-dd"/>
                    </td>
                    <td>${list.bbs_views}</td>
                </tr>
            </c:forEach>
            </tbody>

        </table>

        <div>
            <c:if test="${page.prev}">
                <span>[ <a href="/board/list?num=${page.startPageNum - 1}${page.searchTypeKeyword}">이전</a> ]</span>
            </c:if>

            <c:forEach begin="${page.startPageNum}" end="${page.endPageNum}" var="num">
		<span>
			<c:if test="${select != num}">
                <a href="/board/list?num=${num}${page.searchTypeKeyword}">${num}</a>
            </c:if>

			<c:if test="${select == num}">
                <b>${num}</b>
            </c:if>
		</span>
            </c:forEach>

            <c:if test="${page.next}">
                <span>[ <a href="/board/list?num=${page.endPageNum + 1}${page.searchTypeKeyword}">다음</a> ]</span>
            </c:if>

            <div>
                <%--    <select name="searchType">--%>
                <%--      <option value="bbs_title" <c:if test="${page.searchType eq 'bbs_title'}">selected</c:if>>제목</option>--%>
                <%--      <option value="bbs_content" <c:if test="${page.searchType eq 'bbs_content'}">selected</c:if>>내용</option>--%>
                <%--      <option value="member_id" <c:if test="${page.searchType eq 'member_id'}">selected</c:if>>작성자</option>--%>
                <%--    </select>--%>

                <%--    <input type="text" name="keyword" value="${page.keyword}"/>--%>

                <%--    <button type="button" id="searchBtn">검색</button>--%>
            </div>
        </div>
        -->
    <script>
        document.getElementById("searchBtn").onclick = function () {

            let searchType = document.getElementsByName("searchType")[0].value;
            let keyword = document.getElementsByName("keyword")[0].value;

            location.href = "/board/list?num=1" + "&searchType=" + searchType + "&keyword=" + keyword;
        };
        // JavaScript를 사용하여 버튼 클릭 시 페이지 이동 기능 추가
        document.getElementById("writeButton").addEventListener("click", function() {
            window.location.href = "write";
        });
    </script>
    <%@include file="/footer.jsp" %>
</body>
</html>
