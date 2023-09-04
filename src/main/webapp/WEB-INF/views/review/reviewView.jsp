<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>리뷰게시판 보기</title>
    <%@ include file="/link.jsp" %>

    <script type="text/javascript">
        $(document).ready(function(){
            let formObj = $("form[role='form']");
            console.log(JSON.stringify(formObj));

            $(".btn-Update").on("click", function(){
                self.location = "reviewUpdate?review_id=${reviewDTO.review_id}";
            });

            $(".btn-Delete").on("click", function(){
                if(confirm("삭제하시겠습니까?")){
                    self.location = "reviewDelete?review_id=${reviewDTO.review_id}";
                }
            });
        });


        $(document).ready(function(){
            showReplyList();
        });
        function showReplyList(){
            $.ajax({
                type: 'POST',
                url: "/reviewReply/getReplyList",
                data: {"review_id" : "${reviewDTO.review_id}"},
                success: function(result) {
                    let html = "";
                    /*let member_nickname = $("#member_nickname").val();*/
                    if(result.length < 1){
                        html = "등록된 댓글이 없습니다.";
                    } else {
                        $(result).each(function(){
                            html += '<div class="media text-muted pt-3" id="reply_id' + this.reply_id + '">';
                            html += '<p class="border-bottom harder-gray pb-3 mb-0">';
                            html += '<span class="d-block">';
                            html += '<strong class="text-gray-dark">' + this.member_nickname + '</strong>';
                            html += '<span style="padding-left: 7px; font-size: 9pt">';
                            html += '<a href="javascript:void(0)" onclick="btn_editReply(' + this.reply_id + ', \'' + this.member_id + '\', \'' + this.reply_content + '\' )" style="padding-right:5px">수정</a>';
                            html += '<a href="javascript:void(0)" onclick="btn_deleteReply(' + this.reply_id + ')" >삭제</a>';
                            html += '</span>';
                            html += '</span>';
                            html += this.reply_content;
                            html += '</p>';
                            html += '</div>';
                        });	//each end
                    }
                    $("#replyList").html(html);
                }	// Ajax success end
            });	// Ajax end
        }
        //댓글수정
        function btn_editReply(reply_id, member_id, reply_content) {
            let htmls = "";
            htmls += '<div class="media text-muted pt-3" id="reply_id' + reply_id + '">';
            htmls += '<p class="border-bottom harder-gray pb-3 mb-0">';
            htmls += '<span class="d-block">';
            htmls += '<strong class="text-gray-dark">' + member_id + '</strong>';
            htmls += '<span style="padding-left: 7px; font-size: 9pt">';
            htmls += '<a href="javascript:void(0)" onclick="btn_updateReply(' + reply_id + ', \'' + member_id + '\')" style="padding-right:5px">저장</a>';
            htmls += '<a href="javascript:void(0)" onClick="showReplyList()">취소<a>';
            htmls += '</span>';
            htmls += '</span>';
            htmls += '<textarea name="editReply_content" id="editReply_content" class="reply_content" style="width:100%;">';
            htmls += reply_content;
            htmls += '</textarea>';
            htmls += '</p>';
            htmls += '</div>';
            $('#reply_id' + reply_id).replaceWith(htmls);
            $('#reply_id' + reply_id + ' #editReply_content').focus();
        }


        $(document).ready(function() {
            // btn-saveReply 버튼 클릭 이벤트 리스너
            $('#btn-saveReply').click(function() {
                let reply_content = $("#reply_content").val();
                let member_id = $("#member_id").val();
                if (member_id == "") {
                    alert("로그인 해주세요");
                    return;
                }
                if (reply_content.length < 1) {
                    alert("댓글을 입력하세요");
                } else {
                    $.ajax({
                        type: "POST",
                        url: "/reviewReply/saveReply",
                        data: {
                            reply_content: reply_content,
                            review_id: '${reviewDTO.review_id}',
                            member_id: '${reviewDTO.member_id}'
                        },
                        success: function(views_result) {
                            $('#result').append(views_result);
                            location.reload();
                        }
                    });
                }
            });
        });

        // 수정 저장 버튼 클릭 이벤트 리스너
        function btn_updateReply(reply_id, member_id, reply_content) {
            let editedContent = $('#editReply_content').val();

            $.ajax({
                type: "POST",
                url: "/reviewReply/updateReply",
                data: JSON.stringify({
                    reply_id: reply_id,
                    reply_content: editedContent,
                    member_id: '${reviewDTO.member_id}'
                }),
                contentType: "application/json",
                success: function(views_result) {
                    if (editedContent.length < 1) {
                        alert("댓글을 입력하세요");
                    } else {
                        $('#result').append(views_result);
                        showReplyList();
                    }
                },
                error: function(error) {
                    console.log("에러 : " + error);
                    alert("댓글 수정에 실패했습니다.");
                }
            });
        }


        //댓글삭제
        function btn_deleteReply(reply_id) {
            let paramData = {"reply_id": reply_id};
            if (confirm("삭제하시겠습니까?")) {

            $.ajax({
                url: "/reviewReply/deleteReply",
                data: paramData, type: 'POST',
                success: function (result) {
                    showReplyList();
                }, error: function (error) {
                    console.log("에러 : " + error);
                }
            });
        } /*location.reload();*/
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
    <div class="sub-container">
        <h3 class="s-h-imcre24">리뷰게시판</h3>

        <div>
            <button class="btn-Delete fill-btn" style="width:2cm; height:1cm; float:right">삭제</button>
            <button class="btn-Update fill-btn" style="width:2cm; height:1cm; float:right">수정</button>
          <%--  <button class="btn-Delete fill-btn" style="width:2cm; height:1cm; float:right">삭제</button>--%>
        </div>

        <form name="form" method="post">
            <input type='hidden' name='review-id' value="${reviewDTO.review_id}">
        </form>

        <div>
            <div style="font-size:25px"> ${reviewDTO.review_title} </div>
            <div class="rating" id="rating"></div>
            <c:choose>
                <c:when test="${reviewDTO.review_score == 1}">
                    <c:set var="scoreImg"
                           value="<img src='/resources/img/score/score01.png' height='18'>"/>
                </c:when>
                <c:when test="${reviewDTO.review_score == 2}">
                    <c:set var="scoreImg"
                           value="<img src='/resources/img/score/score02.png' height='18'>"/>
                </c:when>
                <c:when test="${reviewDTO.review_score == 3}">
                    <c:set var="scoreImg"
                           value="<img src='/resources/img/score/score03.png' height='18'>"/>
                </c:when>
                <c:when test="${reviewDTO.review_score == 4}">
                    <c:set var="scoreImg"
                           value="<img src='/resources/img/score/score04.png' height='18'>"/>
                </c:when>
                <c:when test="${reviewDTO.review_score == 5}">
                    <c:set var="scoreImg"
                           value="<img src='/resources/img/score/score05.png' height='18'>"/>
                </c:when>
                <c:otherwise><c:set var="scoreImg" value=""/></c:otherwise>
            </c:choose>
            <li>${scoreImg} ${reviewDTO.review_score}</li>
        </div>

        <div style="font-size:13px" class="p-regular">  ${reviewDTO.snack_name} <span>&#183;</span> ${reviewDTO.member_nickname}
            <span>&#183;</span> <fmt:formatDate value="${reviewDTO.create_dt}" pattern="yyyy-MM-dd a HH:mm:ss"/></div>


        <div id="reviewSnack" class="p-regular">
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
            <%--<div>
                <label>내가 준 별점: </label>
                <div class="rating" id="rating"></div>
                <c:choose>
                    <c:when test="${reviewDTO.review_score == 1}">
                        <c:set var="scoreImg"
                               value="<img src='/resources/img/score/score01.png' height='18'>"/>
                    </c:when>
                    <c:when test="${reviewDTO.review_score == 2}">
                        <c:set var="scoreImg"
                               value="<img src='/resources/img/score/score02.png' height='18'>"/>
                    </c:when>
                    <c:when test="${reviewDTO.review_score == 3}">
                        <c:set var="scoreImg"
                               value="<img src='/resources/img/score/score03.png' height='18'>"/>
                    </c:when>
                    <c:when test="${reviewDTO.review_score == 4}">
                        <c:set var="scoreImg"
                               value="<img src='/resources/img/score/score04.png' height='18'>"/>
                    </c:when>
                    <c:when test="${reviewDTO.review_score == 5}">
                        <c:set var="scoreImg"
                               value="<img src='/resources/img/score/score05.png' height='18'>"/>
                    </c:when>
                    <c:otherwise><c:set var="scoreImg" value=""/></c:otherwise>
                </c:choose>
                <li>${scoreImg} ${reviewDTO.review_score}</li>
&lt;%&ndash;                <script>&ndash;%&gt;
&lt;%&ndash;                    var rating = ${reviewDTO.review_score};&ndash;%&gt;
&lt;%&ndash;                    var fullStars = Math.floor(rating);&ndash;%&gt;
&lt;%&ndash;                    var hasHalfStar = rating - fullStars >= 0.5;&ndash;%&gt;

&lt;%&ndash;                    for (var i = 0; i < fullStars; i++) {&ndash;%&gt;

&lt;%&ndash;                        document.getElementById("rating").innerHTML += "&#9733;";&ndash;%&gt;
&lt;%&ndash;                    }&ndash;%&gt;
&lt;%&ndash;                    if (hasHalfStar) {&ndash;%&gt;
&lt;%&ndash;                        document.getElementById("rating").innerHTML += "&#9733;";&ndash;%&gt;
&lt;%&ndash;                    }&ndash;%&gt;
&lt;%&ndash;                </script>&ndash;%&gt;
            </div>--%>
        </div>

<%--        <div> <label> 과자명 : </label> ${reviewDTO.snack_name} </div>
        <div> <label> 작성자 : </label> ${reviewDTO.member_nickname} </div>
        <div> 작성일자 : <fmt:formatDate value="${reviewDTO.create_dt}" pattern="yyyy-MM-dd a HH:mm:ss"/> </div>
        <div> <label> 내용 : </label> <input name="review_content" class="form-control" value="${reviewDTO.review_content}"> </div>--%>
        <div> ${reviewDTO.review_content} </div>

        <div style="width:650px; text-align: center;">
            <a href="reviewList?num=1"><button class="fill-btn">뒤로가기</button></a>
        </div>


        <!-- 댓글 -->
        <div class="my-3 p-3 bg-white rounded shadow-sm" style="padding-top: 10px">
            <form name="form" id="form" role="form" modelAttribute="reviewReplyDTO" method="post">
                <div class="row">
                    <div class="col-sm-10">
                        <textarea id="reply_content" class="reply_content" style="width:100%;" placeholder="댓글을 입력해 주세요"></textarea>
                    </div>
                    <div class="col-sm-2">
                        <button type="button" class="btn-saveReply fill-btn" id="btn-saveReply" style="width: 100%; margin-top: 10px"> 저 장 </button>
                    </div>
                </div>
            </form>
        </div>

        <div class="my-3" style="padding-top: 10px">
            Reply List
            <div id="replyList"></div>
        </div>


    </div>
</section>
<%@include file="/footer.jsp" %>
</body>
</html>

