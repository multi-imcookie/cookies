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
<style>
  table {
    border-collapse: collapse;
    width: 100%;
    background: #fff;
  }
  th {
    background-color: #B48D69;
    /*font-weight: bold;*/
    /*color: #232323;*/
    white-space: nowrap;

    font-family: ImcreSoojin, serif;
    color: #232323;
    font-size: 24px;
    font-weight: 400;
    line-height: 36px;
    padding: 160px 0 60px;
    box-sizing: border-box;
  }
  td, th {
    padding: 1em 1.5em;
    text-align: center;
    align-content: center;
  }
  .rank-other{
    border: solid 0.125em #F4F4F4;
  }
  .image-style{
    width: 200px;
    height: 200px;
    object-fit: cover ;
  }
  .snack-ranking{
    font-family: Pretendard, sans-serif;
    font-size: 28px;
    font-weight: bold;
    line-height: 28px;
  }
  .snack-name{
    font-family: Pretendard, sans-serif;
    font-size: 28px;
    font-weight: bold;
    line-height: 28px;
  }
</style>
  <table>
    <thead>
      <tr>
        <th class="rank">랭킹</th>
        <th class="image">이미지</th>
        <th class="name">이름</th>
      </tr>
    </thead>
    <c:forEach items="${list}" var="one">
      <tr class="rank-other">
        <td class="snack-ranking">${one.idealRanking}</td> <!-- one.getId() -->
        <td class="snack-img"><img src = "${one.snack_img}" class="image-style"></td>
        <td class="snack-name">${one.snack_name}</td>
      </tr>
    </c:forEach>
  </table>