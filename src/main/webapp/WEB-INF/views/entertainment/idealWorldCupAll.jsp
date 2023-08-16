<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 2023-08-15
  Time: 오전 19:15
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page session="false" %>
<html>
<head>
    <%@ include file="/link.jsp" %>
    <script type="text/javascript">

        $(function() {
            $('.pages').click(function() {
                $.ajax({
                    url : "idealWorldCupList",
                    data : {
                        page : $(this).text()
                    },
                    success : function(result) { //결과가 담겨진 table부분코드
                        $('#d1').html(result)

                    },
                    error : function() {
                        alert('실패')
                    }
                }) //ajax
            })
        })
    </script>
</head>
<body>
<%@include file="/header.jsp" %>
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
                <td class="right"><img src = "/resources/img/entertainment/${one.ideal_snack_img}" width="200" height="200"></td>
                <td class="right">${one.ideal_snack_name}</td>
            </tr>
        </c:forEach>
    </table>
</div>
<hr color="#5C492C">
<%
    int pages = (int)request.getAttribute("pages");
    for(int p = 1; p <= pages; p++){
%>
<button style="background: #E9E2D9; color: #5C492C; width: 50px;" class="pages"><%= p %></button>
<%
    }
%>
<hr color=#5C492C>
<%@include file="/footer.jsp" %>
</body>
</html>