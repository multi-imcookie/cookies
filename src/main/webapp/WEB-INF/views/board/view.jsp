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
${view.member_id}<br />

<label>내용</label><br />
${view.bbs_content}<br />
 -->

    <h2>${view.bbs_title}</h2>

    <hr/>
    <div class="member_id">
        <span>작성자 : </span>${view.member_id}
    </div>

    <hr/>

    <div class="bbs_content">
        ${view.bbs_content}
    </div>

    <hr/>

    <div>
        <a href="/board/update?bbs_id=${view.bbs_id}">게시물 수정</a>, <a href="/board/delete?bbs_id=${view.bbs_id}">게시물 삭제</a>
    </div>

    <!-- 댓글 시작 -->

    <hr/>

    <ul>
        <!-- <li>
            <div>
                <p>첫번째 댓글 작성자</p>
                <p>첫번째 댓글</p>
            </div>
        </li>
        <li>
            <div>
                <p>두번째 댓글 작성자</p>
                <p>두번째 댓글</p>
            </div>
        </li>
        <li>
            <div>
                <p>세번째 댓글 작성자</p>
                <p>세번째 댓글</p>
            </div>
        </li> -->

        <c:forEach items="${reply}" var="reply">
            <li>
                <div>
                    <p>${reply.member_id} /
                            <fmt:formatDate value="${reply.create_dt}" pattern="yyyy-MM-dd HH:mm:ss"/>
                    <p>${reply.reply_content }</p>

                    <p>
                        <a href="/reply/update?bbs_id=${view.bbs_id}&reply_id=${reply.reply_id}">수정</a> / <a
                            href="/reply/delete?bbs_id=${view.bbs_id}&reply_id=${reply.reply_id}">삭제</a>
                    </p>

                    <hr/>

                </div>
            </li>
        </c:forEach>
    </ul>

    <div>

        <form method="post" action="/reply/write">

            <p>
                <label>댓글 작성</label> <input type="text" name="member_id">
            </p>
            <p>
                <textarea rows="5" cols="50" name="reply_content"></textarea>
            </p>
            <p>
                <input type="hidden" name="bbs_id" value="${view.bbs_id}">
                <button type="submit">댓글 작성</button>
            </p>
        </form>

    </div>
</div>
<!-- 댓글 끝 -->

</body>
</html>