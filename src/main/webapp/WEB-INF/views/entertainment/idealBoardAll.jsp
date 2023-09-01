<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 2023-08-11
  Time: 오전 11:05
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <%@ include file="/link.jsp" %>
    <% int totalpages = (int) request.getAttribute("pages");%>
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
        .saveIdealBoard, .deleteIdealBoard {
            display: inline-block;
            padding: 8px 16px;
            background-color: #B48D69;
            color: #F9F5F2;
            border: none;
            border-radius: 12px;
            cursor: pointer;
            transition: background-color 0.3s, color 0.3s;
        }

        .saveIdealBoard:hover, .deleteIdealBoard:hover{
            background-color: #966D48;
            color: #FFF;
        }

        /* 입력 필드 스타일 적용 */
        .input-wrap input {
            display: block;
            margin-bottom: 12px;
            padding: 8px 12px;
            border: 1px solid #CBB89B;
            border-radius: 6px;
            background-color: #FFF;
            font-size: 14px;
        }
        .ideal-board-all {
            display: flex; /* Flex 컨테이너로 설정 */
            flex-direction: row; /* 수평으로 나열하도록 설정 */
            justify-content: space-between; /* 요소들 사이의 간격을 최대로 설정 */
        }

        /* 이하의 CSS 스타일은 필요에 따라 조정할 수 있습니다. */
        .form-style {
            flex: 1; /* Flex 아이템이 차지하는 공간을 조정할 수 있습니다. */
            margin-right: 20px;
        }

        .ideal-board {
            flex: 3; /* Flex 아이템이 차지하는 공간을 조정할 수 있습니다. */
            margin-left: 20px;
        }
        /* 호버 효과 스타일 */
        .comment {
            border-radius: 10px; /* 라운드된 테두리 적용 */
            background-color: #F9F5F2;
            margin-bottom: 10px;
            width: 100%;
            padding: 10px;
            position: relative;
        }
        .comment:hover{
            background-color: #F4EFEC; /* 호버 시 배경색 변경 */
        }

        .comment-nickname{
            font-size: 20px;
        }
        .comment-datetime{
            font-family: Pretendard, sans-serif;
            font-size: 14px;
            font-weight: 400; /* weight 다름 */
            line-height: 28px;
        }
        .comment-content{
            width: 400px;
            padding: 5px;
        }
        .comment-delete {
            position: absolute;
            top: 0; /* 상단 위치를 조절하여 우측 상단에 고정합니다. */
            right: 0; /* 오른쪽 위치를 조절하여 우측 상단에 고정합니다. */
            padding: 10px;
        }
        .comment-nickname, .comment-datetime, .comment-delete {
            display: inline-block;
            vertical-align: top;
        }
        .deleteIdealBoard{
            background: #F9F5F2;
            color: #966D48;
            font-family: Pretendard, sans-serif;
            font-size: 14px;
            font-weight: 400; /* weight 다름 */
            line-height: 28px;
            width: 60px;
            height: 24px;
        }
        td {
            border-spacing: 10px; /* td 간격 설정 (원하는 크기로 조정) */
        }
        td{
            padding: 5px;
        }
        .center-text {
            display: flex;
            justify-content: center;
            align-items: center;
            width: 100%;
            height: 100%;
        }
    </style>

    <script type="text/javascript">
        $(function () {
            $('#saveIdealBoard').click(function () {  //글 작성 function
                ///////////////////length로 들어왔는지부터 check 1보다큰지 모두만족하면 실행하게

                let input_nickname = document.getElementById("ideal_nickname").value;
                let input_pw = document.getElementById("ideal_pw").value;
                let input_content = document.getElementById("ideal_content").value;
                if (input_nickname.length > 0) {
                    if (input_pw.length > 0) {
                        if (input_content.length > 0) {
                            $.ajax({
                                url: "idealBoardInsert",
                                data: {
                                    ideal_nickname: $('#ideal_nickname').val(),
                                    ideal_pw: $('#ideal_pw').val(),
                                    ideal_content: $('#ideal_content').val()
                                },
                                success: function () {
                                    if (!alert("등록 완료")) {
                                        //document.location = 'idealBoardAll?page=1'
                                        window.location.reload();
                                    }
                                },
                                error: function () {
                                    alert('실패')
                                }
                            }) //ajax
                        }//content if
                        else {
                            alert('내용을 입력해주세요')
                        }
                    }//pw if
                    else {
                        alert('패스워드를 입력해주세요')
                    }
                }//id if
                else {
                    alert('닉네임을 입력해주세요')
                }
            })
            $('.deleteIdealBoard').click(function () {  //글 삭제 function
                id_value = $(this).attr('value')
                pw = prompt('비밀번호 입력')
                $.ajax({
                    url: "idealBoardDelete",
                    data: {
                        ideal_id: id_value,
                        ideal_pw: pw
                    },
                    success: function (result) {
                        if (result == 1) {
                            //if(confirm("삭제하시겠습니까?")) document.location = 'idealBoardAll?page=1'; // 지울건지 다시 물어본다
                            if (!alert("삭제완료")) {
                                //document.location = 'idealBoardAll?page=1';
                                window.location.reload();
                            }
                        } else {
                            if (pw != null) {
                                alert('비밀번호가 다릅니다')
                            }
                        }
                    },
                    error: function () {
                        alert('실패')
                    }
                }) //ajax
            })
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
                    loadPage(currentPage);
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
                    url: "idealBoardList",
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
        // 페이지가 로드될 때 기본값 "익명"을 설정합니다.
        document.addEventListener("DOMContentLoaded", function() {
            document.getElementById("ideal_nickname").value = "익명";
        });

    </script>
</head>
<body>
<%@include file="/header.jsp" %>
<div class="sub-container">
    <h3 class="s-h-imcre24">전체 의견 수 : ${count}</h3>
    <div class="ideal-board-all">
        <div class="form-style">
            <div class="input-section">
                <label for="ideal_nickname" class="label-wrap">닉네임</label>
                <input type="text" name="ideal_nickname" id="ideal_nickname" placeholder="익명">
            </div>
            <div class="input-section">
                <label for="ideal_pw" class="label-wrap">패스워드</label>
                <input type="password" name="ideal_pw" id="ideal_pw" placeholder="비밀번호를 입력하세요">
            </div>
            <div class="input-section">
                <label for="ideal_content" class="label-wrap">내용</label>
                <textarea cols="30" rows="3" name="ideal_content" id="ideal_content" placeholder="의견을 입력하세요"></textarea>
            </div>
            <input class="saveIdealBoard" id="saveIdealBoard" type="button" value="의견 작성">
        </div>
        <div class="ideal-board" id="d1">
                <c:forEach items="${list}" var="one">
                        <div class="comment">
                            <div class="comment-nickname p-bold">${one.ideal_nickname}</div>

                            <div class="comment-datetime"><fmt:formatDate value="${one.create_dt}" pattern="yyyy-MM-dd HH:mm:ss"/></div>
                            <div class="comment-delete">
                                <button class="deleteIdealBoard" value="${one.ideal_id}"><span class="center-text">삭제</span></button>
                            </div>
                            <div class="comment-content p-regular">${one.ideal_content}</div>
                        </div>
                </c:forEach>
        </div>
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