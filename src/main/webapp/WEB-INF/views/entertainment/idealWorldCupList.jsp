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
  .selected-page {
    background-image: url("/resources/img/entertainment/cookie-bite.png")!important;
    background-size: contain; /* 이미지를 버튼에 꽉 채우도록 설정 */
    background-repeat: no-repeat;
    width: 40px;
    height: 40px;
    text-align: center;
    font-size: 20px;
    font-weight: bold;
    color: #784132;
  }
  /* 페이지 버튼 스타일 적용 */
  .page-buttons {
    display: flex;
    justify-content: center; /* 수평 가운데 정렬 */
    gap: 5px; /* 버튼 사이의 간격 */

  }
  .page-button{
    background-image: url("/resources/img/entertainment/cookie.png");
    background-size: contain; /* 이미지를 버튼에 꽉 채우도록 설정 */
    background-repeat: no-repeat;
    width: 40px;
    height: 40px;
    text-align: center;
    font-size: 20px;
    font-weight: bold;
    color: #784132;
  }
  .page-button:hover {
    color: #F9F5F2; /* 호버시 글자 색상 변경 */
  }
  table {
    /*border-collapse: collapse;*/
    /*width: 100%;*/
    /*background: #fff;*/
    table-layout: auto;
    width: 100%; /* 테이블 전체 너비를 100%로 설정 */
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
    /*line-height: 36px;*/
    /*padding: 160px 0 60px;*/
    padding: 0.8em 1.5em; /* 수정된 부분 */
    box-sizing: border-box;
  }

  td, th {
    /*padding: 1em 1.5em;*/
    padding: 1em 1em;
    text-align: center;
    /*align-content: center;*/
  }

  /*tbody th {*/
  /*    background-color: #2ea879;*/
  /*}*/

  /*tbody tr:hover {*/
  /*    background-color: rgba(50,98,149,.3);*/
  /*}*/
  .rank-1{
    border: solid 0.125em #ECC81A;

  }
  .rank-2{
    border: solid 0.125em #C0C0C0;

  }
  .rank-3{
    border: solid 0.125em #d0c0b2;

  }
  .rank-other{
    border: solid 0.125em #F4F4F4;
  }
  .image-style{
    width: 200px;
    height: 200px;
    object-fit: cover ;
  }
  .produce-image{
    width: 214px;
    height: 180px;
  }
  .produce-title {
    margin-top: -70px;
    margin-bottom: -50px;
    position: relative;
    color: white;
  }
  .produce-count {
    position: absolute;
    top: 52%;
    left: 50%;
    transform: translate(-50%, 43%);
    font-family: Pretendard, sans-serif;
    font-size: 48px;
    font-weight: 700;
    line-height: 48px;
    color: black;
  }
  .snack-name{
    font-family: Pretendard, sans-serif;
    font-size: 28px;
    font-weight: bold;
    line-height: 28px;
  }
  .medal-image{
    /*z-index: 3;*/
    width: 120%;
    height: 120%;
  }
  .snack-ranking{
    font-family: Pretendard, sans-serif;
    font-size: 28px;
    font-weight: bold;
    line-height: 28px;
  }
  .progress-bar {
    width: 100%;
    height: 30px;
    background-color: #fdf5e2;
    font-weight: 600;
    font-size: .8rem;
  }
  .progress-bar .progress {
    height: 100%;
    width: 0; /* 초기에는 0으로 설정 */
    padding: 0;
    text-align: center;
    background-color: #89674a;
    color: #111;
  }

  .win-rate{
    font-family: Pretendard, sans-serif;
    font-size: 14px;
    font-weight: bold;
    /*line-height: 28px;*/
    text-align: left;
  }
</style>
<script type="text/javascript">
  var winRateArray= [];
  $(function () {
    $(document).ready(function () {
      var winRateArray = []; // 승률 값을 담을 배열

      // winRate 값을 배열에 추가
      $('.win-rate').each(function () {
        var winRate = parseFloat($(this).text());
        winRateArray.push(winRate);
      });

      // 배열 값들을 순서대로 가져와서 진행 막대의 너비로 적용
      $('.progress-bar').each(function (index) {
        var progressBar = $(this).find('.progress');
        progressBar.css('width', winRateArray[index] + '%');
      });
    });
  });
</script>
  <table>
    <thead>
    <tr>
      <th class="rank">랭킹</th>
      <th class="image">이미지</th>
      <th class="name">이름</th>
      <th class="winRatio">우승 확률</th>
    </tr>
    </thead>
    <c:forEach items="${list}" var="one">
      <tr class="rank-other">
        <td class="snack-ranking">${one.idealRanking}</td>
        <td class="snack-img"><img src="${one.snack_img}" class="image-style"></td>
        <td class="snack-name">${one.snack_name}</td>
        <td>
          <div class="win-rate">${one.winRate}%</div>
          <div class="progress-bar">
            <div class="progress"></div>
          </div>
        </td>
      </tr>
    </c:forEach>
  </table>