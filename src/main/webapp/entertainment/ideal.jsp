<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 2023-08-09
  Time: 오전 10:11
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
        <td><a href="worldcup.jsp">
            <button>시작하기</button>
        </a></td>
    </tr>
    <tr>
        <td><a href="idealRanking.jsp">
            <button>랭킹</button>
        </a></td>
    </tr>
    <tr>
        <td><a href="../idealReply">
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
