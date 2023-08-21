<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>


<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>리뷰게시글 작성</title>
    <%@ include file="/link.jsp" %>
    <script>
        $(document).ready(function(){
            $("#btnSave").click(function(){
                var review_title = $("#review_title").val();
                var review_content = $("#review_content").val();
                if(review_title == ""){
                    alert("제목을 입력하세요");
                    document.form1.review_title.focus();
                    return;
                }
                if(review_content == ""){
                    alert("내용을 입력하세요");
                    document.form1.review_content.focus();
                    return;
                }
                document.form1.submit();
            });
        });
    </script>

</head>
<body>
<%@include file="/header.jsp" %>

<h3>리뷰게시판 작성</h3>

<form name="form1" method="post" action="${path}/review/insert.do">

    <label>글제목</label>
    <input type="text" name="review_title" id="review_title" placeholder="제목을 입력하세요">
    

    <td>별점</td>
    <td>
        <input type="radio" name="review_score" value="1">1점</input>
        <input type="radio" name="review_score" value="2">2점</input>
        <input type="radio" name="review_score" value="3">3점</input>
        <input type="radio" name="review_score" value="4">4점</input>
        <input type="radio" name="review_score" value="5">5점</input>
    </td><br>


    <label>내용</label><br>
    <textarea cols="50" rows="5" name="review_content" id="review_content" placeholder="내용을 입력하세요"></textarea><br>

<%--    <label>사진파일 선택:</label>
    <input type="file" id="review_img" name="review_img"><br>--%>


    <div style="width:650px; text-align: center;">
        <button type="button" id="btnSave">확인</button>
        <button type="reset">취소</button>
    </div>

</form>

<br>
<%@include file="/footer.jsp" %>
</body>
</html>