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
            display: flex;
            flex: 1 0 0;
            flex-direction: column;
        }

        /* 호버 효과 스타일 */
        .reply-style {
            width: 100%;
            padding: 24px;
            position: relative;
            border-bottom: 1px solid rgba(203, 184, 155, 0.25);
        }

        .reply-nickname {
            font-size: 20px;
        }

        .reply-datetime {
            font-family: Pretendard, sans-serif;
            font-size: 14px;
            font-weight: 400; /* weight 다름 */
            line-height: 28px;
        }

        .reply-datetime-ref {
            position: absolute;
            top: 0; /* 상단 위치를 조절하여 우측 상단에 고정합니다. */
            right: 0; /* 오른쪽 위치를 조절하여 우측 상단에 고정합니다. */
            padding-top: 12px;
            display: flex;
            flex-direction: column;
            align-items: flex-end;
        }

        .reply-nickname, .reply-datetime {
            display: inline-block;
            vertical-align: top;
        }

        .reply-ref {
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
    <div class="p-regular" style="width: 100%">
        <h3 class="s-h-imcre24" style="text-align: left; padding-left: 24px">${view.bbs_title}</h3>
        <div class="review-view-info">
            <div class="review-view-left">
                <div style="display: inline-block">
                    <div class="p-regular review-view-data">
                        <p>${view.member_nickname}</p>
                        <span>&#183;</span>
                        <p>
                            <c:set var="today" value="<%= new java.util.Date() %>"/>
                            <c:choose>
                                <c:when test="${fn:substring(fn:replace(fn:trim(fn:substring(fn:substringBefore(view.create_dt, ' '), 0, 10)), '-', ''), 0, 10) eq fn:substring(fn:replace(fn:trim(fn:substring(fn:substringBefore(today, ' '), 0, 10)), '-', ''), 0, 10)}">
                                    <!-- 작성일이 오늘일 경우 -->
                                    <fmt:formatDate value="${view.create_dt}" pattern="HH:mm"/>
                                </c:when>
                                <c:otherwise>
                                    <!-- 작성일이 오늘이 아닐 경우 -->
                                    <fmt:formatDate value="${view.create_dt}" pattern="yyyy년 MM월 dd일 HH:mm"/>
                                </c:otherwise>
                            </c:choose>
                        </p>
                    </div>
                </div>
            </div>
            <div class="btn-wrap-row">
                <c:choose>
                    <c:when test="${empty sessionScope.memberId}">
                        <!-- 로그인하지 않은 경우 수정 alert창 띄움. -->
                        <%--                            <a class="fill-btn p-medium" href="javascript:void(0);" onclick="showLoginAlert();">게시물 수정</a>--%>
                        <a class="edit-btn" href="javascript:void(0);" onclick="showLoginAlert();"><img
                                src="/resources/img/icon/edit.svg"></a>
                    </c:when>
                    <c:otherwise>
                        <%--                            <a class="fill-btn p-medium" href="/board/update?bbs_id=${view.bbs_id}">게시물 수정</a>--%>
                        <a class="edit-btn" href="/board/update?bbs_id=${view.bbs_id}"><img
                                src="/resources/img/icon/edit.svg"></a>
                    </c:otherwise>
                </c:choose>

                <!-- 게시물 삭제 버튼 -->
                <c:choose>
                    <c:when test="${empty sessionScope.memberId}">
                        <!-- 로그인하지 않은 경우 버튼을 클릭하면 "로그인하세요" 알림창을 띄우는 JavaScript 코드를 실행합니다. -->
                        <%--                            <a class="light-fill-btn p-medium" href="javascript:void(0);" onclick="showLoginAlert();">게시물 삭제</a>--%>
                        <a class="edit-btn" href="javascript:void(0);" onclick="showLoginAlert();"><img
                                src="/resources/img/icon/trash.svg"></a>
                    </c:when>
                    <c:otherwise>
                        <%--                            <a class="light-fill-btn p-medium" href="/board/delete?bbs_id=${view.bbs_id}">게시물 삭제</a>--%>
                        <a class="edit-btn" href="/board/delete?bbs_id=${view.bbs_id}"><img
                                src="/resources/img/icon/trash.svg"></a>
                    </c:otherwise>
                </c:choose>
                <a class="edit-btn" href="/board/view?bbs_id=1"><img src="/resources/img/icon/back.svg" alt="수정버튼"></a>
            </div>
        </div>
        <hr style="color: #CBB89B">
    </div>
    <div class="p-regular" style="font-size: 18px; width: 100%; text-align: left">
        <p style="margin-bottom: 80px; padding-left: 24px">${view.bbs_content}</p>
        <hr style="color: #CBB89B">
    </div>

    <div class="detail-container p-regular" style="width:100%; padding-top: 10px; flex-direction: column">
        <input type="hidden" name="member_id" id="member_id" value=${sessionScope.memberId}>
        <form method="post" action="/reply/write" style="width: 100%;">
            <div style="display: flex; gap: 12px;">
                <div class="col-sm-10">
                    <textarea id="reply_content" class="reply_content" style="width:100%;"
                              placeholder="댓글을 입력해 주세요"></textarea>
                </div>
                <div class="col-sm-2">
                    <button type="button" class="btn-saveReply fill-btn" id="btn-replyWrite"
                            style="width: 100%; margin-top: 10px"> 댓글작성
                    </button>
                </div>
            </div>
        </form>
        <div class="reply-container text-muted">
            <div class="reply-all">
                <c:forEach items="${reply}" var="reply">
                    <div class="reply-style">
                        <div class="reply-nickname p-bold" style="font-size: large">${view.member_nickname}</div>
                        <div class="reply-datetime-ref">
                            <div class="reply-datetime">
                                <c:set var="today" value="<%= new java.util.Date() %>"/>
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
                            <div class="btn-wrap-row edit-btn-wrap">
                                <c:choose>
                                    <c:when test="${empty sessionScope.memberId}">
                                        <!-- 로그인하지 않은 경우 수정 및 삭제 버튼을 클릭하면 "로그인하세요" 알림창을 띄우는 JavaScript 코드를 실행합니다. -->
                                        <a href="javascript:void(0);" onclick="showLoginAlert();"><img src="/resources/img/icon/edit.svg"></a>
                                        <a href="javascript:void(0);" onclick="showLoginAlert();"><img src="/resources/img/icon/trash.svg"></a>
                                    </c:when>
                                    <c:otherwise>
                                        <!-- 로그인한 경우 수정 및 삭제 가능한 버튼을 표시합니다. -->
                                        <a class="edit-btn" href="/reply/update?bbs_id=${view.bbs_id}&reply_id=${reply.reply_id}"><img src="/resources/img/icon/edit.svg"></a>
                                        <a class="edit-btn" href="/reply/delete?bbs_id=${view.bbs_id}&reply_id=${reply.reply_id}"><img src="/resources/img/icon/trash.svg"></a>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                        <div class="p-regular">${reply.reply_content}</div>
                    </div>
                </c:forEach>
            </div>
        </div>
        <%--        <c:forEach items="${reply}" var="reply">--%>
        <%--        <div class="media text-muted pt-3">--%>
        <%--            <p class="reply-content">--%>
        <%--            <span class="d-block">--%>
        <%--                <strong class="text-gray-dark">${view.member_nickname}</strong>--%>
        <%--                <span class="btn-wrap-row edit-btn-wrap" style="float: right; margin-bottom: 8px">--%>
        <%--                    <c:choose>--%>
        <%--                                <c:when test="${empty sessionScope.memberId}">--%>
        <%--                    <!-- 로그인하지 않은 경우 수정 및 삭제 버튼을 클릭하면 "로그인하세요" 알림창을 띄우는 JavaScript 코드를 실행합니다. -->--%>
        <%--                                    <a class="edit-btn" href="javascript:void(0);" onclick="showLoginAlert();"><img src="/resources/img/icon/reply-chk.svg" alt="저장버튼"></a>--%>
        <%--                                    <a class="edit-btn" href="javascript:void(0);" onclick="showLoginAlert();"><img src="/resources/img/icon/trash.svg"></a>--%>
        <%--                                </c:when>--%>
        <%--                                <c:otherwise>--%>
        <%--                    <!-- 로그인한 경우 수정 및 삭제 가능한 버튼을 표시합니다. -->--%>
        <%--                                    <a class="edit-btn" href="/reply/update?bbs_id=${view.bbs_id}&reply_id=${reply.reply_id}"><img src="/resources/img/icon/reply-chk.svg" alt="저장버튼"></a>--%>
        <%--                                    <a class="edit-btn" href="/reply/delete?bbs_id=${view.bbs_id}&reply_id=${reply.reply_id}"><img src="/resources/img/icon/trash.svg"></a>--%>
        <%--                                </c:otherwise>--%>
        <%--                            </c:choose>--%>
        <%--                </span>--%>
        <%--            </span>--%>
        <%--                <textarea name="editReply_content" id="editReply_content" class="reply_content" style="width:100%;">--%>
        <%--                    ${reply.reply_content}--%>
        <%--                </textarea>--%>
        <%--            </p>--%>
        <%--        </div>--%>
        <%--        </c:forEach>--%>
    </div>


</div>
<script type="text/javascript">
    // "로그인하세요" 알림창을 띄우는 JavaScript 함수
    function showLoginAlert() {
        alert("로그인 해주세요");
    }
</script>
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