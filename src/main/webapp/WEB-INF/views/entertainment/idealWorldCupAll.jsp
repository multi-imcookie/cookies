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
        .selected-page {
            background-color: #FF0000; /* 선택한 색상으로 변경 */
            color: #FFFFFF; /* 글자색 변경 */
            /* 원하는 스타일을 추가하세요 */
        }
        /* 페이지 버튼 스타일 적용 */
        .page-buttons {
            display: flex;
            justify-content: center; /* 수평 가운데 정렬 */
            gap: 10px; /* 버튼 사이의 간격 */
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
                $('.page-button.pages').eq(currentPage-1).addClass('selected-page');
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