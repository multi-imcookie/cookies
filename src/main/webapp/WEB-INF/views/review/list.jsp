<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<html>
<head>
  <title>게시글 목록</title>
  <%@ include file="/link.jsp" %>
  <script>
    $(document).ready(function(){
      $("#btnWrite").click(function(){
        // 페이지 주소 변경(이동)
        location.href = "${path}/review/write.do";
      });
    });
  </script>
</head>
<body>
<%@ include file="/header.jsp" %>
<h2>리뷰게시글</h2>



<input name="keyword" value="${map.keyword}">
<input type="submit" value="조회">
<button type="button" id="btnWrite">글쓰기</button>
<table border="1" width="600px">
    <tr>
        <th>번호</th>
        <th>사진</th>
        <th>제목</th>
        <th>작성자</th>
        <th>작성시간</th>
        <th>평점</th>
    </tr>

<c:forEach var="row" items="${list}">
  <tr>
    <td>${row.review_id}</td>
    <td>${row.review_img}</td>
    <td><a href="${path}/review/view.do?review_id=${row.review_id}">${row.review_title}</a></td>
    <td>${row.member_id}</td>
    <td>
      <fmt:formatDate value="${row.create_dt}" pattern="yyyy-MM-dd HH:mm:ss"/>
    </td>
    <td>${row.review_score}</td>

   </tr>
</c:forEach>
</table>
<%@include file="/footer.jsp" %>
</body>
</html>
