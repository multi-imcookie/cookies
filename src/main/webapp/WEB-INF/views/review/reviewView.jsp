<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>리뷰게시판 보기</title>
    <%@ include file="/link.jsp" %>

    <script>
        $(document).ready(function(){
            let formObj = $("form[role='form']");
            console.log(formObj);


            $(".btn-Update").on("click", function(){
                self.location = "reviewUpdate?review_id=${reviewDTO.review_id}";

            });

            $(".btn-Delete").on("click", function(){
                if(confirm("삭제하시겠습니까?")){
                    formObj.attr("action", "/review/reviewDelete");
                    formObj.attr("method", "post");
                    formObj.submit();
                }
            });
        });

    </script>
    <style>
        .detail-container {
            display: flex;
            align-items: center;
            max-width: 800px;
            margin: 0 auto;
            background-color: white;
            border-radius: 10px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            padding: 20px;
        }

        .thumbnail img {
            max-width: 100%;
            border-radius: 5px;
        }

        .detail-content {
            margin-left: 20px;
        }

        .detail-row {
            margin-bottom: 10px;
        }
    </style>
</head>
<body id="page-top">
<%@ include file="/header.jsp" %>
<section class="page-section" id="review">
    <div class="container">
        <h2>리뷰게시글 보기</h2>

        <div class = "text-center">
            <button type="submit" class="btn-Update">수정</button>
            <button type="submit" class="btn-Delete">삭제</button>
        </div>

        <form name="form" method="post">
            <input type='hidden' name='review-id' value="${reviewDTO.review_id}">
        </form>

        <div> <label> 제목 : </label> ${reviewDTO.review_title} </div>

        <div id="reviewSnack">
            <div class="detail-container">
                <div class="thumbnail"><img src="${snackDTO.snack_img}" alt="썸네일"></div>
                <div class="detail-content">
                    <div class="detail-row">이름 : ${snackDTO.snack_name}</div>
                    <br>
                    <div class="detail-row">제조회사 : ${snackDTO.company}</div>
                    <br>
                    <div class="detail-row">원재료 : ${snackDTO.snack_ingredients}</div>
                    <br>
                    <div class="detail-row">알러지 : ${snackDTO.allergy}</div>
                </div>
            </div>
            <div>
                <label>내가 준 별점: </label>
                <div class="rating" id="rating"></div>
                <script>
                    var rating = ${reviewDTO.review_score};
                    var fullStars = Math.floor(rating);
                    let hasHalfStar = rating - fullStars >= 0.5;

                    for (var i = 0; i < fullStars; i++) {

                        document.getElementById("rating").innerHTML += "&#9733;";
                    }
                    if (hasHalfStar) {
                        document.getElementById("rating").innerHTML += "&#9733;";
                    }
                </script>
            </div>
        </div>

        <div> <label> 과자명 : </label> ${reviewDTO.snack_id} </div>
        <div> <label> 작성자 : </label> ${reviewDTO.member_id} </div>
        <div> 작성일자 : <fmt:formatDate value="${reviewDTO.create_dt}" pattern="yyyy-MM-dd a HH:mm:ss"/> </div>
        <div> <label> 내용 : </label> <input name="review_content" class="form-control" value="${reviewDTO.review_content}"> </div>

        <%--  <div> 사진
            <input name="review_img" class="form-control" value="${reviewDTO.review_img}">
          </div>--%>


        <div style="width:650px; text-align: center;">
            <a href="reviewList?num=1"><button>뒤로가기</button></a>
        </div>

        <!-- 댓글 -->
        <div id="reply">
            <ol class="replyList">
                <c:forEach items="${replyList}" var="replyList">
                    <li>
                        <p>${replyList.reply_content}</p>
                        <p>
                            작성자 : ${replyList.member_id}
                            작성날짜 :  <fmt:formatDate value="${replyList.create_dt}" pattern="yyyy-MM-dd" />
                        </p>
                    </li>
                </c:forEach>
            </ol>
        </div>


        <form name="replyForm" method="post">
            <input type="hidden" id="reply_id" name="reply_id" value="${reviewReplyDTO.reply_id}" />
            <input type="hidden" id="review_id" name="review_id" value="${reviewReplyDTO.review_id}">
            <input type="hidden" id="member_id" name="member_id" value="${reviewReplyDTO.member_id}">

            <%--            <div><label &lt;%&ndash;for="reply_content"&ndash;%&gt;>댓글</label>
                            <input type="text" id="reply_content" name="reply_content" placeholder="댓글 내용을 입력하세요">
                        </div>--%>

            <div>
                <label>댓글2</label><br>
                <textarea cols="50" rows="5" name="reply_content" id="reply_content" placeholder="댓글 내용을 입력하세요"></textarea>
            </div>

            <div>
                <button type="submit" class="btn-reviewReplyWrite" id="btn-reviewReplyWrite">작성</button>
            </div>
        </form>

    </div>
</section>


<%@include file="/footer.jsp" %>
</body>
</html>
