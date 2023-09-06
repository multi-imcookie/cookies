<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>리뷰게시판 보기</title>
    <%@ include file="/link.jsp" %>

    <script type="text/javascript">
        $(document).ready(function () {
            let formObj = $("form[role='form']");
            console.log(JSON.stringify(formObj));

            $(".btn-Update").on("click", function () {
                let memberId = "${sessionScope.memberId}";
                if (memberId === "" || memberId === null) {
                    self.location = '/login';
                    alert("로그인을 하셔야합니다")
                } else {
                    self.location = "reviewUpdate?review_id=${reviewDTO.review_id}";
                }
            });
            
            $(".btn-Delete").on("click", function () {
                let memberId = "${sessionScope.memberId}";
                if (memberId === "" || memberId === null) {
                    self.location = '/login';
                    alert("로그인을 하셔야합니다")
                } else if (confirm("삭제하시겠습니까?")) {
                    self.location = "reviewDelete?review_id=${reviewDTO.review_id}";
                }
            });


        });


        $(document).ready(function () {
            showReplyList();
        });

        function showReplyList() {
            $.ajax({
                type: 'POST',
                url: "/reviewReply/getReplyList",
                data: {"review_id": "${reviewDTO.review_id}"},
                success: function (result) {
                    let html = "";

                    // Unix 타임스탬프를 밀리초로 가지고 있는 변수
                    let timestamp = 1693937640000; // 예시 숫자

                    // 밀리초를 JavaScript Date 객체로 변환
                    let date = new Date(timestamp);


                    // 원하는 날짜 및 시간 형식으로 포맷팅
                    let formattedDate = date.toLocaleString("ko-KR", {
                        year: "numeric",
                        month: "2-digit",
                        day: "2-digit",
                        hour: "2-digit",
                        minute: "2-digit",
                        /*second: "2-digit",*/
                        hour12: true, // 오후/오전 표시 여부
                    });
                    if (result.length < 1) {
                        html = "등록된 댓글이 없습니다.";
                    } else {
                        $(result).each(function () {
                            html += '<div class="media text-muted pt-3" id="reply_id' + this.reply_id + '">';
                            html += '<p class="border-bottom harder-gray pb-3 mb-0">';
                            html += '<span class="d-block">';
                            html += '<strong class="text-gray-dark" style="font-size: large">' + this.member_nickname + '</strong>';
                            html += '  '; // 공백 추가
                            html += '<SMALL>' + formattedDate + '</SMALL>';
                            html += '<span style="padding-left: 10px; font-size: 11pt; float: right">';
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
            htmls += '<span style="padding-left: 10px; font-size: 11pt">';
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

        $(document).ready(function () {
            // btn-saveReply 버튼 클릭 이벤트 리스너
            $('#btn-saveReply').click(function () {
                let reply_content = $("#reply_content").val();
                let memberId = "${sessionScope.memberId}";
                if (memberId === "" || memberId === null) {
                    self.location = '/login';
                    alert("로그인을 하셔야합니다")
                } else if (reply_content.length < 1) {
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
                        success: function (views_result) {
                            $('#result').append(views_result);
                            location.reload();
                        }
                    });
                }
            });
        });

        // 수정 저장
        function btn_updateReply(reply_id, member_id, reply_content) {
            let editedContent = $('#editReply_content').val();
            let memberId = "${sessionScope.memberId}";
            if (memberId === "" || memberId === null) {
                self.location = '/login';
                alert("로그인을 하셔야합니다")
            } else if (editedContent.length < 1) {
                alert("댓글을 입력하세요");
            } else{
                $.ajax({
                    type: "POST",
                    url: "/reviewReply/updateReply",
                    data: JSON.stringify({
                        reply_id: reply_id,
                        reply_content: editedContent,
                        member_id: '${reviewDTO.member_id}'
                    }),
                    contentType: "application/json",
                    success: function (views_result) {
                            $('#result').append(views_result);
                            showReplyList();
                    },
                    error: function (error) {
                        console.log("에러 : " + error);
                        alert("댓글 수정에 실패했습니다.");
                    }
                });
            }
        }


        //댓글삭제
        function btn_deleteReply(reply_id) {
            let paramData = {"reply_id": reply_id};
            let memberId = "${sessionScope.memberId}";
            if (memberId === "" || memberId === null) {
                self.location = '/login';
                alert("로그인을 하셔야합니다")
            } else if (confirm("삭제하시겠습니까?")){
                $.ajax({
                    url: "/reviewReply/deleteReply",
                    data: paramData, type: 'POST',
                    success: function (result) {
                        showReplyList();
                    }, error: function (error) {
                        console.log("에러 : " + error);
                    }
                });
            }
        }

    </script>
    <style>
        .thumbnail img {
            max-width: 100%;
            border-radius: 5px;
        }

        .detail-container {
            display: flex;
            width: 100%;
            gap: 4%;
            justify-content: space-between;
        }

        .detail-content {
            width: 70%;
        }

        .detail-row {
            margin-bottom: 10px;
        }

        .modal-box {
            width: 900px;
            height: 640px;
        }

        #modal-close {
            position: absolute;
            top: 24px;
            right: 24px;
        }
        .find-btn1{
            display :inline-block;
        }
    </style>
</head>
<body id="page-top">
    <%@ include file="/header.jsp" %>
    <div class="modal-overlay">
        <div class="modal-box">
            <button type="button" id="modal-close" class="btn-close" aria-label="Close"></button>
            <div class="s-h-imcre24">리뷰 과자 정보</div>
            <div class="modal-detail-content p-regular">
                <div class="detail-container p-regular">
                    <div class="thumbnail detail-thumbnail"
                         style="background-image: url(${snackDTO.snack_img})"></div>
                    <div class="detail-content">
                        <p style="color: #B48D69;">${snackDTO.company}</p>
                        <div class="detail-row">
                            <span class="h-imcre24">${snackDTO.snack_name} </span>
                            <span style="color: #B48D69;">(${snackDTO.netwt}g / ${snackDTO.kcal}kcal)</span>
                            <c:choose>
                                <c:when test="${snackDTO.avg_score >= 1 && snackDTO.avg_score < 1.5}">
                                    <c:set var="scoreImg"
                                           value="<img src='/resources/img/score/score01.png' height='24'>"/>
                                </c:when>
                                <c:when test="${snackDTO.avg_score >= 1.5 && snackDTO.avg_score < 2}">
                                    <c:set var="scoreImg"
                                           value="<img src='/resources/img/score/score_01_half.png' height='24'>"/>
                                </c:when>
                                <c:when test="${snackDTO.avg_score >= 2 && snackDTO.avg_score < 2.5}">
                                    <c:set var="scoreImg"
                                           value="<img src='/resources/img/score/score02.png' height='24'>"/>
                                </c:when>
                                <c:when test="${snackDTO.avg_score >= 2.5 && snackDTO.avg_score < 3}">
                                    <c:set var="scoreImg"
                                           value="<img src='/resources/img/score/score_02_half.png' height='24'>"/>
                                </c:when>
                                <c:when test="${snackDTO.avg_score >= 3 && snackDTO.avg_score < 3.5}">
                                    <c:set var="scoreImg"
                                           value="<img src='/resources/img/score/score03.png' height='24'>"/>
                                </c:when>
                                <c:when test="${snackDTO.avg_score >= 3.5 && snackDTO.avg_score < 4}">
                                    <c:set var="scoreImg"
                                           value="<img src='/resources/img/score/score_03_half.png' height='24'>"/>
                                </c:when>
                                <c:when test="${snackDTO.avg_score >= 4 && snackDTO.avg_score < 4.5}">
                                    <c:set var="scoreImg"
                                           value="<img src='/resources/img/score/score04.png' height='24'>"/>
                                </c:when>
                                <c:when test="${snackDTO.avg_score >= 4.5 && snackDTO.avg_score < 5}">
                                    <c:set var="scoreImg"
                                           value="<img src='/resources/img/score/score_04_half.png' height='24'>"/>
                                </c:when>
                                <c:when test="${snackDTO.avg_score == 5}">
                                    <c:set var="scoreImg"
                                           value="<img src='/resources/img/score/score05.png' height='24'>"/>
                                </c:when>
                                <c:otherwise/>
                            </c:choose>
                            <p style="color: #B48D69; margin-top:5px">${scoreImg} 평점 (${snackDTO.avg_score}
                                / ${snackDTO.review_count}개)</p>
                        </div>
                        <div style="margin: 20px 0 30px 0;">
                            <div class="detail-row">탄수화물 : ${snackDTO.carb}g</div>
                            <div class="detail-row">당류 : ${snackDTO.sugars}g</div>
                            <div class="detail-row">나트륨 : ${snackDTO.sodium}mg</div>
                            <div class="detail-row">단백질 : ${snackDTO.protein}g</div>
                            <div class="detail-row">알러지 : ${snackDTO.allergy}</div>
                            <div class="detail-row">
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="sub-container">
        <div class="p-regular" style="width: 100%">
            <h3 class="s-h-imcre24">${reviewDTO.review_title}</h3>
            <div class="rating" id="rating">
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
            </div>
                <div style="display: inline-block">
                    <li>${scoreImg}</li>
                    <div style="font-size:15px" class="p-regular"> ${reviewDTO.review_score}점 <span>&#183;</span> ${reviewDTO.snack_name}
                        <span>&#183;</span> ${reviewDTO.member_nickname}
                        <span>&#183;</span> <%--<fmt:formatDate value="${reviewDTO.create_dt}" pattern="yyyy-MM-dd a HH:mm:ss"/>--%>
                        <c:set var="today" value="<%= new java.util.Date() %>" />
                        <c:choose>
                            <c:when test="${fn:substring(fn:replace(fn:trim(fn:substring(fn:substringBefore(reviewDTO.create_dt, ' '), 0, 10)), '-', ''), 0, 10) eq fn:substring(fn:replace(fn:trim(fn:substring(fn:substringBefore(today, ' '), 0, 10)), '-', ''), 0, 10)}">
                                <!-- 작성일이 오늘일 경우 -->
                                <fmt:formatDate value="${reviewDTO.create_dt}" pattern="HH:mm"/>
                            </c:when>
                            <c:otherwise>
                                <!-- 작성일이 오늘이 아닐 경우 -->
                                <fmt:formatDate value="${reviewDTO.create_dt}" pattern="yyyy년 MM월 dd일 HH:mm"/>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
                <div class="btn-wrap find-btn1" style="float: right">
                    <button class="btn-Update fill-btn find-btn1">수정</button>
                    <button class="btn-Delete fill-btn find-btn1">삭제</button>
                </div>

            <hr style="color: #452C07">
        </div>

        <div> ${reviewDTO.review_content} </div>

        <div class="thumbnail detail-thumbnail" style="background-image: url(${snackDTO.snack_img})"></div>

        <button class="fill-btn" id="snack-info">리뷰 과자 정보</button>

        <form name="form" method="post">
            <input type='hidden' name='review-id' value="${reviewDTO.review_id}">
        </form>


        <div class="btn-wrap">
            <a href="reviewList?num=1"><button class="light-fill-btn">뒤로가기</button></a>
        </div>


        <!-- 댓글 -->
        <div class="detail-container my-3 p-3 bg-white rounded shadow-sm p-regular"  style="padding-top: 10px; flex-direction: column">
            <form name="form" id="form" role="form" modelAttribute="reviewReplyDTO" method="post" style="width: 100%;">
                <div class="row">
                    <div class="col-sm-10">
                            <textarea id="reply_content" class="reply_content" style="width:100%;"
                                      placeholder="댓글을 입력해 주세요"></textarea>
                    </div>
                    <div class="col-sm-2">
                        <button type="button" class="btn-saveReply fill-btn" id="btn-saveReply"
                                style="width: 100%; margin-top: 10px"> 저 장
                        </button>
                    </div>
                </div>
            </form>
            <div id="replyList" style="width: 100%;"></div>
        </div>
    </div>
    <script>
        $("#snack-info").click(function () {
            modalShow();
        });
        $("#modal-close").click(function () {
            modalHide();
        });
    </script>
    <%@include file="/footer.jsp" %>
</body>
</html>

