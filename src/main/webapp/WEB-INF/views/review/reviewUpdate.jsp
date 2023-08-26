<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>게시물 수정</title>
    <%@ include file="/link.jsp" %>
    <script type="text/javascript">
        document.addEventListener("DOMContentLoaded", function() {


            $(".btn-Update").click(function(){
                let review_title = $("#review_title").val();
                let snack_id = $("#snack_id").val();
                let review_content = $("#review_content").val();
                if(review_title == ""){
                    alert("제목을 입력하세요");
                    document.form.review_title.focus();
                    return;
                }
                if(snack_id == ""){
                    alert("과자명을 입력하세요");
                    document.form.snack_id.focus();
                    return;
                }
                if(review_content == ""){
                    alert("내용을 입력하세요");
                    document.form.review_content.focus();
                    return;
                }
                document.form.submit();
            });

            $(".btn-List").on("click", function(){
                self.location = "reviewList?num=1";
            });

        })
    </script>
</head>
<body id="page-top">
<%@include file="/header.jsp" %>
<section class="page-section" id="review">
    <div class="container">
        <h3>리뷰게시글 수정</h3>

        <form name="form" method="post">
            <input type='hidden' name='review-id' value="${reviewDTO.review_id}">


            <div> <label>제목1 : </label>
                <input type="text" name="review_title" class="form-control" size="80" placeholder="제목을 입력하세요" value="${reviewView.review_title}">
            </div>


            <div>
                <td>별점</td>
                <td>
                    <input type="radio" name="review_score" class="form-control" value="1">1점</input>
                    <input type="radio" name="review_score" class="form-control" value="2">2점</input>
                    <input type="radio" name="review_score" class="form-control" value="3">3점</input>
                    <input type="radio" name="review_score" class="form-control" value="4">4점</input>
                    <input type="radio" name="review_score" class="form-control" value="5">5점</input>
                </td><br>
            </div>


            <div> <label>내용 : </label>
                <textarea name="review_content" class="form-control" rows="4" cols="80" value="${reviewDTO.review_content}">${reviewView.review_content}</textarea>
            </div>

            <%--  <div> <label>사진</label>
                <input name="review_img" id="review_img" value="${dto.review_img}">
              </div>--%>
        </form>

        <div class = "text-center">
            <button type="submit" class="btn-Update">수정</button>
            <button type="submit" class="btn-List">뒤로가기</button>
        </div>

    </div>
</section>
<%@include file="/footer.jsp" %>
</body>
</html>

