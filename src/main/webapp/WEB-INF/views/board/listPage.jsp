<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>게시판 목록</title>
    <%@ include file="/link.jsp" %>
</head>
<body>
<%@ include file="/header.jsp" %>

<form action="list" method="get">
    <select name="category">
        <option value="question">질문게시판</option>
        <option value="free">자유게시판</option>
    </select>
    <input type="text" name="keyword" placeholder="검색어를 입력하세요">
    <button type="submit">검색</button>
</form>

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
                <a href="/view?bbs_id=${list.bbs_id}">${list.title}</a>
            </td>
            <td>
                <fmt:formatDate value="${list.create_dt}" pattern="yyyy-MM-dd" />
            </td>
            <td>${list.member_id}</td>
            <td>${list.views}</td>
        </tr>
    </c:forEach>

    </tbody>

</table>

<div>

    <c:if test="${page.prev}">
        <span>[ <a href="/listPage?num=${page.startPageNum - 1}">이전</a> ]</span>
    </c:if>

    <c:forEach begin="${page.startPageNum}" end="${page.endPageNum}" var="num">
		<span>

			<c:if test="${select != num}">
                <a href="/listPage?num=${num}">${num}</a>
            </c:if>

			<c:if test="${select == num}">
                <b>${num}</b>
            </c:if>

		</span>
    </c:forEach>

    <c:if test="${page.next}">
        <span>[ <a href="/listPage?num=${page.endPageNum + 1}">다음</a> ]</span>
    </c:if>


    <%-- <c:forEach begin="1" end="${pageNum}" var="num">
          <span>
              <a href="/board/listPage?num=${num}">${num}</a>
        </span>
    </c:forEach> --%>
</div>


</body>
</html>
