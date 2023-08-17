<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 2023-08-09
  Time: 오전 10:11
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page session="false" %>
<html>
<head>
    <title>Title</title>
    <%@ include file="../link.jsp" %>
</head>
<body>
<%@include file="../header.jsp" %>
<table>
    <tr>
        <form action="worldcup.jsp">
            <label for="kang">라운드를 선택 해주세요:</label>
            <select name="kang" id="kang">
                <option value="8">8강</option>
                <option value="4" selected>4강</option>
            </select>
            <br><br>
            <input type="submit" value="시작하기" style="background: #5C492C; color: black; width: 70px;">
        </form>
    </tr>
    <tr>
        <td><a href="/entertainment/idealWorldCupAll?page=1">
            <button>랭킹</button>
        </a></td>
    </tr>
    <tr>
        <td><a href="/entertainment/idealBoardAll?page=1">
            <button>의견</button>
        </a></td>
    </tr>
    <tr>
        <td><a href="../index.jsp">
            <button>뒤로가기</button>
        </a></td>
    </tr>
</table>
<%@include file="../footer.jsp" %>
</body>
</html>
