<%--
  Created by IntelliJ IDEA.
  User: ohlocal
  Date: 2023-08-04
  Time: 오전 10:06
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div id="header">
    <h1 class="logo">
        <a href="/index.jsp">
            <img src="/resources/img/logo.svg" alt="로고">
        </a>
    </h1>
    <ul class="gnb">
        <li>
            <a class="p-medium" href="/snack/snackWiki.jsp">바삭 취조실</a>
            <ul class="depth2">
                <li><a class="p-medium" href="/snack/snackWiki.jsp">전과자 정보 조회</a></li>
                <li><a class="p-medium" href="/curation/curation.jsp">지명 수배</a></li>
                <li><a class="p-medium" href="/curation/curation.jsp">신상 조사</a></li>
            </ul>
        </li>
        <li>
            <a class="p-medium">바삭 월드컵</a>
            <ul class="depth2">
                <li><a class="p-medium" href="/entertainment/ideal.jsp">이상형 월드컵</a></li>
                <li><a class="p-medium" href="/entertainment/idealWorldCupAll?page=1">랭킹</a></li>
                <li><a class="p-medium" href="/entertainment/idealBoardAll?page=1">의견</a></li>
            </ul>
        </li>
        <li>
            <a class="p-medium" >쿠키랭킹</a>
            <ul class="depth2">
                <li><a class="p-medium" href="/ranking/rankingAll?page=1">리뷰 평점 랭킹</a></li>
            </ul>
        </li>
        <li>
            <a class="p-medium" href="#">작당모의</a>
            <ul class="depth2">
                <li><a class="p-medium" href="/board/notice/list?num=1">공지사항</a></li>
                <li><a class="p-medium" href="/review/reviewList?num=1">리뷰 게시판</a></li>
                <li><a class="p-medium" href="/board/list?num=1">자유 게시판</a></li>
            </ul>
        </li>
    </ul>
    <div class="user-menu">
        <ul class="user-left">
            <c:if test="${sessionScope.memberId == null}">
                <li><a class="p-medium" href="/login">로그인</a></li>
                <span></span>
                <li><a class="p-medium" href="/member/sign.jsp">회원가입</a></li>
            </c:if>
            <c:if test="${sessionScope.memberId != null}">
                <li><a class="p-medium" href="/logout">로그아웃</a></li>
                <span></span>
                <li><div class="p-medium">${sessionScope.memberNickName}님 어서오세요</div></li>
            </c:if>
        </ul>
        <ul class="user-right">
            <c:if test="${sessionScope.memberId != null}">
                <li><a href="/mypage">
                    <img src="/resources/img/icon/user.svg" alt="유저메뉴">
                </a></li>
            </c:if>
            <c:if test="${sessionScope.memberId == null}">
                <li><a href="/login">
                    <img src="/resources/img/icon/user.svg" alt="유저메뉴">
                </a></li>
            </c:if>
            <li><a href="/chat/chatbot.jsp">
                <img src="/resources/img/icon/chatbot.svg" alt="챗봇">
            </a></li>
        </ul>
    </div>
</div>