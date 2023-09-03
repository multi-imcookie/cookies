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
<div class="ideal-board-all">
  <div class="ideal-board" id="d1">
    <c:forEach items="${list}" var="one">
      <div class="comment">
        <div class="comment-nickname p-bold">${one.ideal_nickname}</div>

        <div class="comment-datetime-delete">
          <div class="comment-datetime"><fmt:formatDate value="${one.create_dt}" pattern="yyyy-MM-dd HH:mm:ss"/></div>
          <button class="deleteIdealBoard" value="${one.ideal_id}"><span class="center-text">삭제</span></button>
        </div>
        <div class="comment-content p-regular">${one.ideal_content}</div>
      </div>
    </c:forEach>
  </div>
</div>