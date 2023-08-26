<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 2023-08-15
  Time: 오전 19:15
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <%@ include file="/link.jsp" %>
    <% int totalpages = (int) request.getAttribute("pages");%>
    <title></title>
    <script type="text/javascript">

        $(function () {
            var currentPage = 1; // 현재 페이지 번호 초기화
            // 이전 버튼 클릭 시
            $('#prevPage').click(function () {
                if (currentPage > 1) {
                    currentPage--;
                    loadPage(currentPage);
                }
                else{
                    loadPage(currentPage);
                }
            });
            // 페이지 번호 클릭 시
            $('.pages').click(function () {
                currentPage = parseInt($(this).text());
                loadPage(currentPage);
            });
            // 다음 버튼 클릭 시
            $('#nextPage').click(function () {
                if(currentPage<<%=totalpages%>){
                    currentPage++;
                    loadPage(currentPage);
                    console.log(currentPage)
                }
                else{
                    loadPage(currentPage);
                }
            });
            function loadPage(page) {
                $.ajax({
                    url: "idealWorldCupList",
                    data: {
                        page: page
                    },
                    success: function (result) {
                        $('#d1').html(result);
                        scrollToTop();
                    },
                    error: function () {
                        alert('실패');
                    }
                });
            }
        })
        // 화면을 맨 위로 스크롤하는 함수
        function scrollToTop() {
            window.scrollTo(0, 0);
        }
    </script>
</head>
<body>
<%@include file="/header.jsp" %>
<div class="sub-container">
    <h3>전체 과자 수: ${count}</h3>
    <div id="d1">
        <table>
            <tr>
                <td class="left">랭킹</td>
                <td class="left">이미지</td>
                <td class="left">이름</td>
            </tr>
            <c:forEach items="${list}" var="one">
                <tr>
                    <td class="right">${one.idealRanking}</td> <!-- one.getId() -->
                    <td class="right"><img src="${one.snack_img}" width="300" height="200"></td>
                    <td class="right">${one.snack_name}</td>
                </tr>
            </c:forEach>
        </table>
    </div>
    <div class="sub-container">
        <!-- 기존 내용 ... -->
        <div class="page-buttons">
            <button class="page-button" id="prevPage">이전</button>
            <% int pages = (int) request.getAttribute("pages");
                for (int p = 1; p <= pages; p++) { %>
            <button class="page-button pages"><%= p %></button>
            <% } %>
            <button class="page-button" id="nextPage">다음</button>
        </div>
    </div>
</div>
<%@include file="/footer.jsp" %>
</body>
</html>