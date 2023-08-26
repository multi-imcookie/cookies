<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 2023-08-15
  Time: 오전 19:15
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
  <table>
    <tr>
      <td class="left">랭킹</td>
      <td class="left">이미지</td>
      <td class="left">이름</td>
    </tr>
    <c:forEach items="${list}" var="one">
      <tr>
        <td class="right">${one.idealRanking}</td> <!-- one.getId() -->
        <td class="right"><img src = "${one.snack_img}" width="300" height="200"></td>
        <td class="right">${one.snack_name}</td>
      </tr>
    </c:forEach>
  </table>