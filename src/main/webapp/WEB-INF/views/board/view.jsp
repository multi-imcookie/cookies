<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>게시판 글보기</title>
    <%@ include file="/link.jsp" %>

</head>
<body>
<%@ include file="/header.jsp" %>
<div class="sub-container">
    <h3 class="h-imcre24">게시글</h3>
    <!--
<label>제목</label>
${view.bbs_title}<br />

<label>작성자</label>
${view.member_nickname}<br />

<label>내용</label><br />
${view.bbs_content}<br />
 -->

    <h2>${view.bbs_title}</h2>

    <hr/>
    <div class="member_nickname">
        <span>작성자 : </span>${view.member_nickname}
    </div>

    <hr/>

    <div class="bbs_content">
        ${view.bbs_content}
    </div>

    <hr/>

    <div>
        <a href="/board/update?bbs_id=${view.bbs_id}">게시물 수정</a>, <a href="/board/delete?bbs_id=${view.bbs_id}">게시물
        삭제</a>
    </div>

    <!-- 댓글 시작 -->

    <hr/>

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