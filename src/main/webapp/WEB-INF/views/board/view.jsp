<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>게시판 글보기</title>
    <%@ include file="/link.jsp" %>
<style>
    .reply-container {
        display: flex; /* Flex 컨테이너로 설정 */
        flex-direction: row; /* 수평으로 나열하도록 설정 */
        justify-content: space-between; /* 요소들 사이의 간격을 최대로 설정 */
    }

    .reply-all {
        flex: 3; /* Flex 아이템이 차지하는 공간을 조정할 수 있습니다. */
        margin-left: 20px;

    }
    /* 호버 효과 스타일 */
    .reply-style {
        border-radius: 10px; /* 라운드된 테두리 적용 */
        background-color: #F9F5F2;
        margin-bottom: 10px;
        width: 100%;
        padding: 10px;
        position: relative;
    }
    .reply-style:hover{
        background-color: #F4EFEC; /* 호버 시 배경색 변경 */
    }

    .reply-nickname{
        font-size: 20px;
    }
    .reply-datetime{
        font-family: Pretendard, sans-serif;
        font-size: 14px;
        font-weight: 400; /* weight 다름 */
        line-height: 28px;
    }
    .reply-content{
        width: 400px;
        padding: 5px;
    }
    .reply-datetime-ref {
        position: absolute;
        top: 0; /* 상단 위치를 조절하여 우측 상단에 고정합니다. */
        right: 0; /* 오른쪽 위치를 조절하여 우측 상단에 고정합니다. */
        padding: 10px;
    }
    .reply-nickname, .reply-datetime {
        display: inline-block;
        vertical-align: top;
    }
    .reply-ref{
        background: #F9F5F2;
        color: #966D48;
        font-family: Pretendard, sans-serif;
        font-size: 14px;
        font-weight: 400; /* weight 다름 */
        line-height: 28px;
        width: 60px;
        height: 24px;
    }
</style>
</head>
<body>
<%@ include file="/header.jsp" %>
<div class="sub-container">
    <h3 class="h-imcre24">게시글</h3>
    <div class="form-style">
        <div class="input-section">
            <label class="label-wrap">작성자</label>
            <input type="text" name="member_nickname" value="${view.member_nickname}" readonly/><br/>
        </div>
        <div class="input-section">
            <label class="label-wrap">제목</label>
            <input type="text" name="bbs_title" value="${view.bbs_title}" readonly/><br/>
        </div>
        <div class="input-section">
            <label class="label-wrap">내용</label>
            <textarea cols="50" rows="5" name="bbs_content" readonly>${view.bbs_content}</textarea><br/>
        </div>
    </div>
    <div class="btn-wrap-column">
        <a class= "fill-btn p-medium" href="/board/update?bbs_id=${view.bbs_id}">게시물 수정</a>
        <a class= "light-fill-btn p-medium" href="/board/delete?bbs_id=${view.bbs_id}">게시물 삭제</a>
    </div>
        <div class="reply-container">
            <div class="reply-all">
                <c:forEach items="${reply}" var="reply">
                <div class="reply-style">
                    <div class="reply-nickname p-bold">${view.member_nickname}</div>
                    <div class="reply-datetime-ref">
                        <div class ="reply-datetime">
                            <c:set var="today" value="<%= new java.util.Date() %>" />
                            <c:choose>
                            <c:when test="${fn:substring(fn:replace(fn:trim(fn:substring(fn:substringBefore(reply.create_dt, ' '), 0, 10)), '-', ''), 0, 10) eq fn:substring(fn:replace(fn:trim(fn:substring(fn:substringBefore(today, ' '), 0, 10)), '-', ''), 0, 10)}">
                            <!-- 작성일이 오늘일 경우 -->
                                    <fmt:formatDate value="${reply.create_dt}" pattern="HH:mm"/>
                            </c:when>
                            <c:otherwise>
                            <!-- 작성일이 오늘이 아닐 경우 -->
                                <fmt:formatDate value="${reply.create_dt}" pattern="yyyy년 MM월 dd일 HH:mm"/>
                            </c:otherwise>
                            </c:choose>
                        </div>
                        <div class ="reply-ref">
                            <a href="/reply/update?bbs_id=${view.bbs_id}&reply_id=${reply.reply_id}">수정</a>
                            <a href="/reply/delete?bbs_id=${view.bbs_id}&reply_id=${reply.reply_id}">삭제</a>
                        </div>
                    </div>
                    <div class="reply-content p-regular">${reply.reply_content}</div>
                </div>
                </c:forEach>
            </div>
        </div>
    <div>
        <form method="post" action="/reply/write">

            <p>
                <input type="hidden" name="member_id" id="member_id" value=${sessionScope.memberId}>
            </p>
            <p>
                <textarea rows="5" cols="50" name="reply_content" id="reply_content"></textarea>
            </p>
            <p>
                <input type="hidden" name="bbs_id" value="${view.bbs_id}">
                <button type="button" class="btn-replyWrite fill-btn" id="btn-replyWrite" style="width: 100%; margin-top: 10px"> 댓글작성 </button>
            </p>
        </form>
    </div>
</div>
<script type="text/javascript">
    $(document).ready(function () {
// btn-saveReply 버튼 클릭 이벤트 리스너
        $('#btn-replyWrite').click(function () {
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
                    url: "/reply/write",
                    data: {
                        reply_content: reply_content,
                        bbs_id: '${view.bbs_id}',
                        member_id: '${sessionScope.memberId}'
                    },
                    success: function (views_result) {
                        $('#result').append(views_result);
                        location.reload();
                    }
                });
            }
        });
    });
</script>
<!-- 댓글 끝 -->
<%@include file="/footer.jsp" %>
</body>
</html>