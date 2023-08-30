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
    <style>
        /* 버튼 스타일 적용 */
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
    </style>
    <script type="text/javascript">
        $(function () {
            if((<%=totalpages%>) < 11){
                $('#nextPage').hide();
            }
            var currentPage = 1; // 현재 페이지 번호 초기화
            $('.page-button.pages').hide();// 이 부분은 버튼 초기 숨김 처리입니다.
            $('#prevPage').hide();

            $('.page-button.pages:lt(10)').show();// 이 부분은 버튼 초기 버튼 개수입니다.
            // $('.pages').eq(0).removeClass('page-button');
            $('.page-button.pages').eq(currentPage-1).addClass('selected-page'); // 페이지 1번 css변경

            // 이전 버튼 클릭 시
            $('#prevPage').click(function () {
                $('.pages').removeClass('selected-page');
                if(currentPage>10){
                    while(currentPage % 10 != 1){
                        currentPage--;
                    }
                    if(currentPage<21){
                        $('#prevPage').hide();
                    }
                    currentPage--;
                    console.log("1",currentPage)
                    $('#nextPage').show();
                    $('.page-button.pages:lt(' + (currentPage) + ')').show();
                    $('.page-button.pages:gt(' + (currentPage - 1) + ')').hide();
                    $('.page-button.pages:lt(' + (currentPage - 10) + ')').hide();
                }
                $('.page-button.pages').eq(currentPage-1).addClass('selected-page');
            });

            // 페이지 번호 클릭 시
            $('.pages').click(function () {
                currentPage = parseInt($(this).text());
                loadPage(currentPage);
                $('.pages').removeClass('selected-page');
                $(this).addClass('selected-page');
            });


            // 다음 버튼 클릭 시
            $('#nextPage').click(function () {
                $('.pages').removeClass('selected-page');
                if( ((<%=totalpages%>)/10) > ((currentPage - 1)/10) ){
                    while(currentPage % 10 != 0){
                        currentPage++;
                    }
                    currentPage++
                    if((<%=totalpages%>-currentPage)<10){
                        $('#nextPage').hide();
                    }
                    loadPage(currentPage);
                    $('#prevPage').show();
                    $('.page-button.pages:lt(' + (currentPage + 9) + ')').show();
                    $('.page-button.pages:lt(' + (currentPage - 1) + ')').hide();
                }
                $('.page-button.pages').eq(currentPage+1).addClass('selected-page');
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
    <div class="produce-title">
        <img src="/resources/img/entertainment/produce.png" class="produce-image">
        <div class="produce-count">${count}</div>
    </div>
    <div id="d1">
        <table>
            <thead>
                <tr>
                    <th class="rank">랭킹</th>
                    <th class="image">이미지</th>
                    <th class="name">이름</th>
                </tr>
            </thead>
            <tbody>
            <c:forEach items="${list}" var="one" varStatus="status">
                <c:if test="${status.index == 0}">
                    <tr class="rank-1">
                        <td class="medal"><img src="/resources/img/entertainment/medal-gold.svg" class="medal-image"></td>
                        <td class="snack-img"><img src="${one.snack_img}" class="image-style"></td>
                        <td class="snack-name">${one.snack_name}</td>
                    </tr>
                </c:if>
                <c:if test="${status.index == 1}">
                    <tr class="rank-2">
                        <td class="medal"><img src="/resources/img/entertainment/medal-silver.svg" class="medal-image"></td>
                        <td class="snack-img"><img src="${one.snack_img}" class="image-style"></td>
                        <td class="snack-name">${one.snack_name}</td>
                    </tr>
                </c:if>
                <c:if test="${status.index == 2}">
                    <tr class="rank-3">
                        <td class="medal"><img src="/resources/img/entertainment/medal-bronze.svg" class="medal-image"></td>
                        <td class="snack-img"><img src="${one.snack_img}" class="image-style"></td>
                        <td class="snack-name">${one.snack_name}</td>
                    </tr>
                </c:if>
                <c:if test="${status.index >= 3}">
                    <tr class="rank-other">
                        <td class="snack-ranking">${one.idealRanking}</td>
                        <td class="snack-img"><img src="${one.snack_img}" class="image-style"></td>
                        <td class="snack-name">${one.snack_name}</td>
                    </tr>
                </c:if>
            </c:forEach>
<%--            </tbody>--%>
        </table>
    </div>
    <div class="page-buttons">
        <button class="page-button" id="prevPage"><</button>
        <% for (int p = 1; p <= totalpages; p++) { %>
        <button class="page-button pages"><%= p %></button>
        <% } %>
        <button class="page-button" id="nextPage">></button>
    </div>
</div>
<%@include file="/footer.jsp" %>
</body>
</html>