<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>게시판 글보기</title>
    <%@ include file="/link.jsp" %>
<style>
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
    <ul>
        <c:forEach items="${reply}" var="reply">
            <li>
                <div>
                    <p>${view.member_nickname} /
                            <fmt:formatDate value="${reply.create_dt}" pattern="yyyy-MM-dd HH:mm:ss"/>
                    <p>${reply.reply_content }</p>

                    <p>
                        <a href="/reply/update?bbs_id=${view.bbs_id}&reply_id=${reply.reply_id}">수정</a> /
                        <a href="/reply/delete?bbs_id=${view.bbs_id}&reply_id=${reply.reply_id}">삭제</a>
                    </p>

                    <hr/>

                </div>
            </li>
        </c:forEach>
    </ul>
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