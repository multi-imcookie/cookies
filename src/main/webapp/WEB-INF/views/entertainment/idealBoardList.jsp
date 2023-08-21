<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 2023-08-11
  Time: 오전 11:43
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<script type="text/javascript">

  $(function() {
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
            if(pw!=null){
              alert('비밀번호가 다릅니다')
            }
          }
        },
        error : function() {
          alert('실패')
        }
      }) //ajax
    })
  })
</script>
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
      <td class="right"><fmt:formatDate value="${one.create_dt}" pattern="yyyy-MM-dd hh:mm:ss"/></td>
      <td class="right">
        <button  class="deleteIdealBoard" value="${one.ideal_id}" style="background: #E9E2D9; color: #5C492C; width: 50px;">삭제</button>
      </td>
    </tr>
  </c:forEach>
</table>