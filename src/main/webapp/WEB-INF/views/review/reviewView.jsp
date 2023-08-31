<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
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
                    self.location = "reviewDelete?review_id=${reviewDTO.review_id}";
                }
            });


            $(".btn-replyWrite").on("click", function() {
                //               self.location = "replyWrite?review_id=${reviewDTO.review_id}";
                let formObj = $("form[name='replyForm']");
                formObj.attr("action", "replyWrite");
                formObj.submit();
            });
        });


        $(document).ready(function(){
            createReply();
        });

        function createReply() {
            $(".btn-replyWrite").on("click", function() {
                //               self.location = "replyWrite?review_id=${reviewDTO.review_id}";
                let formObj = $("form[name='replyForm']");
                formObj.attr("action", "replyWrite");
                formObj.submit();
            });
        }




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
        <h3 class="s-h-imcre24">리뷰게시판</h3>

        <div class = "board-top">
            <button type="submit" class="btn-Update fill-btn">수정</button>
            <button type="submit" class="btn-Delete fill-btn">삭제</button>
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
                    var hasHalfStar = rating - fullStars >= 0.5;

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


        <div style="width:650px; text-align: center;">
            <a href="reviewList?num=1"><button>뒤로가기</button></a>
        </div>


        <!-- 댓글 -->

        <div>
            <form method="post" action="/review/replyWrite">
                <p>
                    <textarea cols="50" name="reply_content"></textarea>
                    <button type="submit">댓글 작성</button>
                </p>
                <p>
                    <input type="hidden" name="member_id" id="member_id" value="1">
                    <input type="hidden" name="review_id" value="${reviewDTO.review_id}">
                    <%--<button type="submit">댓글 작성</button>--%>
                <hr />
                </p>
            </form>
        </div>



        <ul>
            <c:forEach items="${reviewReply}" var="reviewReply">
                <li>
                    <div>
                        <p>${reviewReply.reply_content }</p>
                        <p>${reviewReply.member_id} / <fmt:formatDate value="${reviewReply.create_dt}" pattern="yyyy-MM-dd" /></p>
                        <p>
                            <a href="/review/reviewReplyModify?review_id=${reviewDTO.review_id}&reply_id=${reviewReplyDTO.reply_id}">수정</a> / <a href="">삭제</a>
                        </p>

                        <hr />
                    </div>
                </li>
            </c:forEach>
        </ul>



    </div>
</section>


<%@include file="/footer.jsp" %>
</body>
</html>

