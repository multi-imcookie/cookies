<%--
  Created by IntelliJ IDEA.
  User: ohlocal
  Date: 2023-08-23
  Time: 오후 5:14
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>전과자</title>
    <%@ include file="/link.jsp" %>
    <script type="text/javascript" src="/resources/js/mypage.js"></script>
</head>
<body>
<%@include file="/header.jsp" %>
<div class="sub-container">
    <h3 class="s-h-imcre24">마이페이지</h3>
    <div class="profile">
        <div class="profile-img"></div>
        <%--        <div class="btn-wrap-row p-regular">--%>
        <%--            <a href="#" class="small-fill-btn">변경하기</a>--%>
        <%--            <a href="#" class="small-fill-btn">삭제하기</a>--%>
        <%--        </div>--%>
    </div>
    <div class="member-info-wrap">
        <div class="member-info">
            <div class="member-info-top">
                <h6 class="h-pre24">${memberDTO.member_nickname}</h6>
                <span class="p-small grade-label">${memberDTO.member_grade}등급</span>
            </div>
            <ul class="member-info-bottom p-regular">
                <li>${memberAge}</li>
                <span></span>
                <li>${memberDTO.member_gender}</li>
                <span></span>
                <li>${memberDTO.member_birthday}</li>
                <span></span>
                <li>${memberDTO.member_email}</li>
            </ul>
        </div>
        <div class="btn-wrap-row edit-btn-wrap">
            <a href="/editMyInfo" class="edit-btn"><img src="/resources/img/icon/edit.svg" alt="회원 정보 수정버튼"></a>
            <a href="/editMyPassword" class="edit-btn"><img src="/resources/img/icon/passcode.svg" alt="비밀번호 변경 버튼"></a>
        </div>
    </div>
    <div class="tab-btn-wrap p-regular">
        <a id="myBoardBtn" class="tab-btn active">
            <svg xmlns="http://www.w3.org/2000/svg" width="25" height="24" viewBox="0 0 25 24" fill="none">
                <path d="M21.5 12L9.5 12M21.5 6L9.5 6M21.5 18L9.5 18M5.5 12C5.5 12.5523 5.05228 13 4.5 13C3.94772 13 3.5 12.5523 3.5 12C3.5 11.4477 3.94772 11 4.5 11C5.05228 11 5.5 11.4477 5.5 12ZM5.5 6C5.5 6.55228 5.05228 7 4.5 7C3.94772 7 3.5 6.55228 3.5 6C3.5 5.44772 3.94772 5 4.5 5C5.05228 5 5.5 5.44772 5.5 6ZM5.5 18C5.5 18.5523 5.05228 19 4.5 19C3.94772 19 3.5 18.5523 3.5 18C3.5 17.4477 3.94772 17 4.5 17C5.05228 17 5.5 17.4477 5.5 18Z"
                      stroke="#fff" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"></path>
            </svg>
            내가 쓴 게시글
        </a>
        <a id="myReviewBtn" class="tab-btn">
            <svg xmlns="http://www.w3.org/2000/svg" width="25" height="24" viewBox="0 0 25 24" fill="none">
                <path d="M3.5 7.8C3.5 6.11984 3.5 5.27976 3.82698 4.63803C4.1146 4.07354 4.57354 3.6146 5.13803 3.32698C5.77976 3 6.61984 3 8.3 3H16.7C18.3802 3 19.2202 3 19.862 3.32698C20.4265 3.6146 20.8854 4.07354 21.173 4.63803C21.5 5.27976 21.5 6.11984 21.5 7.8V13.5C21.5 14.8978 21.5 15.5967 21.2716 16.1481C20.9672 16.8831 20.3831 17.4672 19.6481 17.7716C19.0967 18 18.3978 18 17 18C16.5114 18 16.2671 18 16.0405 18.0535C15.7383 18.1248 15.4569 18.2656 15.2185 18.4645C15.0397 18.6137 14.8931 18.8091 14.6 19.2L13.14 21.1467C12.9229 21.4362 12.8143 21.5809 12.6812 21.6327C12.5647 21.678 12.4353 21.678 12.3188 21.6327C12.1857 21.5809 12.0771 21.4362 11.86 21.1467L10.4 19.2C10.1069 18.8091 9.96028 18.6137 9.7815 18.4645C9.54312 18.2656 9.26169 18.1248 8.95951 18.0535C8.73287 18 8.48858 18 8 18C6.60218 18 5.90326 18 5.35195 17.7716C4.61687 17.4672 4.03284 16.8831 3.72836 16.1481C3.5 15.5967 3.5 14.8978 3.5 13.5V7.8Z"
                      stroke="#CBB89B" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"></path>
                <path fill-rule="evenodd" clip-rule="evenodd"
                      d="M12.4973 8.33059C11.6975 7.4216 10.3639 7.17708 9.36188 8.00945C8.35986 8.84182 8.21879 10.2335 9.00568 11.2179C9.47361 11.8033 10.6197 12.8531 11.4719 13.6079C11.8237 13.9195 11.9996 14.0753 12.2114 14.1385C12.3925 14.1926 12.602 14.1926 12.7832 14.1385C12.9949 14.0753 13.1708 13.9195 13.5226 13.6079C14.3748 12.8531 15.5209 11.8033 15.9888 11.2179C16.7757 10.2335 16.6519 8.83306 15.6326 8.00945C14.6134 7.18584 13.297 7.4216 12.4973 8.33059Z"
                      stroke="#CBB89B" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"></path>
            </svg>
            내가 쓴 리뷰
        </a>
    </div>
    <div class="board p-regular" id="mypageBoard">
        <div class="board-top">
            <p class="list-count">
                <!-- 레코드의 갯수를 출력 -->
                총 작성한 게시글 ${boardDTO.size()}개
            </p>
        </div>
        <div class="board-list-wrap">
            <c:forEach var="myBoards" items="${boardDTO}">
                <a href="/board/view?bbs_id=${myBoards.bbs_id}" class="list-box">
                    <div class="left">
                        <div class="left-text">
                            <h5 class="h-pre24">${myBoards.bbs_title}</h5>
                            <ul class="p-regular left-bottom">
                                <li>${myBoards.bbs_category}</li>
                                <span></span>
                                <li>${myBoards.member_id}</li>
                                <span></span>
                                <li><fmt:formatDate value="${myBoards.create_dt}" pattern="yyyy-MM-dd"/></li>
                            </ul>
                        </div>
                    </div>
                    <div class="right">
                        <div class="reply-count">${myBoards.bbs_views}</div>
                    </div>
                </a>
            </c:forEach>
        </div>
    </div>
    <div class="board p-regular" id="mypageReview">
        <div class="board-top">
            <p class="list-count">
                <!-- 레코드의 갯수를 출력 -->
                총 작성한 리뷰 ${reviewDTO.size()}개
            </p>
        </div>
        <div class="board-list-wrap">
            <c:forEach var="myReviews" items="${reviewDTO}">
                <a href="/review/reviewView?review_id=${myReviews.review_id}" class="list-box">
                    <div class="left">
                        <c:if test="${myReviews.review_img != null}">
                            <%-- image가 있으면 div 추가 --%>
                            <div class="img-section">
                                    ${myReviews.review_img}
                            </div>
                        </c:if>
                        <c:if test="${myReviews.review_img == null}">
                            <%-- image가 없으면 div 없음 --%>
                        </c:if>
                        <div class="left-text">
                            <h5 class="h-pre24">${myReviews.review_title}</h5>
                            <ul class="p-regular left-bottom">
                                <li>${myReviews.review_score}</li>
                                <span></span>
                                <li>${myReviews.snack_id}</li>
                                <span></span>
                                <li>${myReviews.member_id}</li>
                                <span></span>
                                <li><fmt:formatDate value="${myReviews.create_dt}" pattern="yyyy-MM-dd"/></li>
                            </ul>
                        </div>
                    </div>
                    <div class="right">
                        <div class="reply-count">0</div>
                    </div>
                </a>
            </c:forEach>
        </div>
    </div>
</div>
<%@include file="/footer.jsp" %>
</body>
</html>
