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
        .saveIdealBoard, .deleteIdealBoard, .pages {
            display: inline-block;
            padding: 8px 16px;
            background-color: #B48D69;
            color: #F9F5F2;
            border: none;
            border-radius: 12px;
            cursor: pointer;
            transition: background-color 0.3s, color 0.3s;
        }

        .saveIdealBoard:hover, .deleteIdealBoard:hover, .pages:hover {
            background-color: #966D48;
            color: #FFF;
        }

        /* 입력 필드 스타일 적용 */
        .input-wrap {
            background: #E9E2D9;
            padding: 16px;
            border-radius: 12px;
            margin: 20px 0;
        }

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
            display: flex;
            justify-content: center; /* 수평 가운데 정렬 */
            gap: 50px;
        }
        /* 페이지 버튼 스타일 적용 */
        .page-buttons {
            display: flex;
            justify-content: center; /* 수평 가운데 정렬 */
            gap: 10px; /* 버튼 사이의 간격 */
        }
        /* 선택된 페이지 버튼의 스타일 */
        .selected-page {
            background-color: #FF0000; /* 선택한 색상으로 변경 */
            color: #FFFFFF; /* 글자색 변경 */
            /* 원하는 스타일을 추가하세요 */
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
    </script>
</head>
<body>
<%@include file="/header.jsp" %>
<div class="sub-container">
    <h3>전체 의견 수: ${count}</h3>
    <div class="ideal-board-all">
    <div class="input-wrap" style="background:#E9E2D9">
        닉네임: <input id="ideal_nickname"><br>
        패스워드: <input id="ideal_pw"><br>
        내용: <input id="ideal_content"><br>
        <input class="saveIdealBoard" id="saveIdealBoard" type="button" value="의견 작성"
               style="background: #5C492C; color: black; width: 70px;">
    </div>
    <div id="d1" class="ideal-board">
        <table>
            <tr>
                <td class="left">닉네임</td>
                <td class="left">내용</td>
                <td class="left">작성시간</td>
            </tr>
            <c:forEach items="${list}" var="one">
                <tr>
                    <td class="right">${one.ideal_nickname}</td>
                    <td class="right">${one.ideal_content}</td>
                    <td class="right"><fmt:formatDate value="${one.create_dt}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                    <td class="right">
                        <button class="deleteIdealBoard" value="${one.ideal_id}"
                                style="background: #E9E2D9; color: #5C492C; width: 50px;">삭제
                        </button>
                    </td>
                </tr>
            </c:forEach>
        </table>
    </div>
    </div>
    <div class="page-buttons">
        <button class="page-button" id="prevPage">이전</button>
        <% int pages = (int) request.getAttribute("pages");
            for (int p = 1; p <= pages; p++) { %>
        <button class="page-button pages"><%= p %></button>
        <% } %>
        <button class="page-button" id="nextPage">다음</button>
    </div>
</div>
<%@include file="/footer.jsp" %>
</body>
</html>