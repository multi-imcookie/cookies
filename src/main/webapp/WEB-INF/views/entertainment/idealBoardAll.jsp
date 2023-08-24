<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 2023-08-11
  Time: 오전 11:05
  To change this template use File | Settings | File Templates.
  // TODO: (해결시 삭제 하겠음)
           1)글 작성시 닉네임, 비밀번호, 내용 입력안하면 alter 띄우고 insert안되는 기능 (해결)
           2)삭제 버튼 누르면 비밀번호 입력하는 alter띄우기 (해결)
           3)삭제 비밀번호 틀리면 삭제 안되게 하기 (해결)
           4)이상형월드컵 게임 (해결)
           5)이상형월드컵 랭킹 구현 (해결)
           6)db 유니크 키
           7)페이지 합칠지 나눌지 css어떻게할지 정리

--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page session="false" %>
<html>
<head>
    <%@ include file="/link.jsp" %>
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

        /* 페이지 버튼 스타일 적용 */
        .pages {
            background: #E9E2D9;
            color: #5C492C;
            width: 50px;
            padding: 8px;
            margin-right: 4px;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            transition: background-color 0.3s, color 0.3s;
        }

        .pages:hover {
            background-color: #CBB89B;
            color: #452C07;
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

            $('.pages').click(function () {
                $.ajax({
                    url: "idealBoardList",
                    data: {
                        page: $(this).text()
                    },
                    success: function(result) { //결과가 담겨진 table부분코드
                        $('#d1').html(result)//jQuery를 사용하여 HTML 요소 내부의 내용을 변경하는 코드

                        // AJAX 호출 성공 후 화면 맨 위로 스크롤
                        scrollToTop();

                    },
                    error: function () {
                        alert('실패')
                    }
                }) //ajax
            })
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
    <div class="input-wrap" style="background:#E9E2D9">
        닉네임: <input id="ideal_nickname"><br>
        패스워드: <input id="ideal_pw"><br>
        내용: <input id="ideal_content"><br>
        <input class="saveIdealBoard" id="saveIdealBoard" type="button" value="의견 작성"
               style="background: #5C492C; color: black; width: 70px;">
    </div>
    <div id="d1">
        <table>
            <tr>
                <td class="left">글 번호</td>
                <td class="left">닉네임</td>
                <td class="left">내용</td>
                <td class="left">작성시간</td>
            </tr>
            <c:forEach items="${list}" var="one">
                <tr>
                    <td class="right">${one.ideal_id}</td> <!-- one.getId() -->
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
    <hr color="#5C492C">
    <%
        int pages = (int) request.getAttribute("pages");
        for (int p = 1; p <= pages; p++) {
    %>
    <button style="background: #E9E2D9; color: #5C492C; width: 50px;" class="pages"><%= p %>
    </button>
    <%
        }
    %>
    <hr color=#5C492C>
</div>
<%@include file="/footer.jsp" %>
</body>
</html>