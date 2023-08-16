<%--
  Created by IntelliJ IDEA.
  User: 고물오빠
  Date: 2023-08-16
  Time: 오전 10:48
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>전과자</title>
    <%@ include file="/link.jsp" %>

</head>
<body>
<%@include file="/header.jsp" %>
${searchDTO.snack_id}, ${searchDTO.company}, ${searchDTO.snack_name}, ${searchDTO.snack_img}
<%-- <img src="resources/img/${bag.img}"> --%>
<%@include file="/footer.jsp" %>
</body>
</html>
