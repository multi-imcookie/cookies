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
    <title></title>
    <script type="text/javascript">

        $(function () {
            $('.pages').click(function () {
                $.ajax({
                    url: "idealWorldCupList",
                    data: {
                        page: $(this).text()
                    },
                    success: function (result) { //결과가 담겨진 table부분코드
                        $('#d1').html(result)//jQuery를 사용하여 HTML 요소 내부의 내용을 변경하는 코드

                        // AJAX 호출 성공 후 화면 맨 위로 스크롤
                        scrollToTop();

                    },
                    error: function () {
                        alert('실패')
                    }
                }) //ajax
            })
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
            <% int pages = (int) request.getAttribute("pages");
                for (int p = 1; p <= pages; p++) { %>
            <button class="page-button pages"><%= p %></button>
            <% } %>
        </div>
    </div>
</div>
<%@include file="/footer.jsp" %>
</body>
</html>