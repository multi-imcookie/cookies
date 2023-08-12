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
           4)이상형월드컵 게임, 랭킹 구현
           5)페이지 합칠지 나눌지 css어떻게할지 정리

--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<html>
<head>
    <%@ include file="/link.jsp" %>
    <%@include file="/header.jsp" %>
    <h3>전체 의견 수: ${count}</h3>
    <script type="text/javascript" src="resources/js/jquery-3.6.1.js"></script>
    <script type="text/javascript">

        $(function() {
            $('#saveIdealBoard').click(function() {  //글 작성 function
                ///////////////////length로 들어왔는지부터 check 1보다큰지 모두만족하면 실행하게

                let input_nickname = document.getElementById("ideal_nickname").value;
                let input_pw = document.getElementById("ideal_pw").value;
                let input_content = document.getElementById("ideal_content").value;
                if(input_nickname.length>0){
                    if(input_pw.length>0){
                        if(input_content>0){
                            $.ajax({
                                url : "idealBoardInsert",
                                data : {
                                    ideal_nickname: $('#ideal_nickname').val(),
                                    ideal_pw: $('#ideal_pw').val(),
                                    ideal_content: $('#ideal_content').val()
                                },
                                success : function(result) { //결과가 담겨진 table 부분 코드
                                    if(!alert("등록 완료")) document.location = 'idealBoardAll?page=1';
                                },
                                error : function() {
                                    alert('실패')
                                }
                            }) //ajax
                        }//content if
                        else{
                            alert('내용을 입력해주세요')
                        }
                    }//pw if
                    else{
                        alert('패스워드를 입력해주세요')
                    }
                }//id if
                else{
                    alert('닉네임을 입력해주세요')
                }
            })
            $('.deleteIdealBoard').click(function() {  //글 삭제 function
                id_value = $(this).attr('value')
                pw = prompt('비밀번호 입력')
                $.ajax({
                    url : "idealBoardDelete",
                    data : {
                        ideal_id: id_value,
                        ideal_pw: pw
                    },
                    success : function(result) {
                       // $('#d1').html(result)   // 결과값을 화면에 띄운다
                        // location.replace('idealBoardAll?page=1') //리스트페이지로 이동한다
                        if(result==1){
                            //if(confirm("삭제하시겠습니까?")) document.location = 'idealBoardAll?page=1'; // 지울건지 다시 물어본다
                            if(!alert("삭제완료")) document.location = 'idealBoardAll?page=1';
                        }
                        else{
                            alert('비밀번호가 다릅니다')
                        }
                    },
                    error : function() {
                        alert('실패')
                    }
                }) //ajax
            })

            $('.pages').click(function() {
                $.ajax({
                    url : "idealBoardList",
                    data : {
                        page : $(this).text()
                    },
                    success : function(result) { //결과가 담겨진 table부분코드
                         $('#d1').html(result)

                    },
                    error : function() {
                        alert('실패')
                    }
                }) //ajax
            })
        })
    </script>
</head>
<div class="input-wrap" style="background:#E9E2D9">
    닉네임: <input id="ideal_nickname"><br>
    패스워드: <input id="ideal_pw"><br>
    내용: <input id="ideal_content"><br>
    <input class="saveIdealBoard" id="saveIdealBoard" type="button" value="의견 작성" style="background: #5C492C; color: black; width: 70px;">
</div>
<body>
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
                <td class="right">${one.create_dt}</td>
                <td class="right">
                    <button  class="deleteIdealBoard" value="${one.ideal_id}" style="background: #E9E2D9; color: #5C492C; width: 50px;">삭제</button>
                </td>
            </tr>
        </c:forEach>
    </table>
</div>
<hr color="#5C492C">
<%
    int pages = (int)request.getAttribute("pages");
    for(int p = 1; p <= pages; p++){
%>
<button style="background: #E9E2D9; color: #5C492C; width: 50px;" class="pages"><%= p %></button>
<%
    }
%>
<hr color=#5C492C>
<%@include file="/footer.jsp" %>
</body>
</html>