<%--
  Created by IntelliJ IDEA.
  User: ohlocal
  Date: 2023-08-04
  Time: 오전 10:06
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div id="footer">
    <div class="f-left">
        <h1 class="logo">
            <a href="/index.jsp">
                <img src="/resources/img/logo.svg" alt="로고">
            </a>
        </h1>
        <ul class="team">
            <li class="team-admin">
                <p class="p-regular">팀명 : 불멸의 코더스</p>
                <a class="p-regular" href="#">관리자 페이지</a>
            </li>
            <li class="p-regular">손영석 · 최영규 · 정진기 · 오현지 · 최유정 · 안서희 · 임완태 · 이성보</li>
        </ul>
        <div class="team-email">
            <ul class="team-email-section">
                <li class="p-bold"><img src="/resources/img/icon/mail.svg" alt="메일 아이콘">son7162@gmail.com</li>
                <li class="p-bold"><img src="/resources/img/icon/mail.svg" alt="메일 아이콘">dksdbsdk66@naver.com</li>
            </ul>
            <ul class="team-email-section">
                <li class="p-bold"><img src="/resources/img/icon/mail.svg" alt="메일 아이콘">limwantae87@gmail.com</li>
                <li class="p-bold"><img src="/resources/img/icon/mail.svg" alt="메일 아이콘">12wlsrl@naver.com</li>
            </ul>
            <ul class="team-email-section">
                <li class="p-bold"><img src="/resources/img/icon/mail.svg" alt="메일 아이콘">5local9805@gmail.com</li>
                <li class="p-bold"><img src="/resources/img/icon/mail.svg" alt="메일 아이콘">qnelldo@gmail.com</li>
            </ul>
            <ul class="team-email-section">
                <li class="p-bold"><img src="/resources/img/icon/mail.svg" alt="메일 아이콘">yujeong4624@gmail.com</li>
                <li class="p-bold"><img src="/resources/img/icon/mail.svg" alt="메일 아이콘">ssaintbo@gmail.com</li>
            </ul>
        </div>
    </div>
    <ul class="f-right">
        <li>
            <a class="h-imcre24" href="/snack/snackWiki.jsp">바삭 취조실</a>
            <ul class="f-depth2">
                <li><a class="p-medium" href="/snack/snackWiki.jsp">전과자 정보 조회</a></li>
                <li><a class="p-medium" href="/curation/curation.jsp">지명 수배</a></li>
                <li><a class="p-medium" href="/curation/curation.jsp">신상 조사</a></li>
            </ul>
        </li>
        <li>
            <a class="h-imcre24" href="#">바삭 월드컵</a>
            <ul class="f-depth2">
                <li><a class="p-medium" href="/entertainment/ideal.jsp">이상형 월드컵</a></li>
                <li><a class="p-medium" href="/entertainment/idealWorldCupAll?page=1">랭킹</a></li>
                <li><a class="p-medium" href="/entertainment/idealBoardAll?page=1">의견</a></li>
            </ul>
        </li>
        <li>
            <a class="h-imcre24" href="#">쿠키랭킹</a>
            <ul class="f-depth2">
                <li><a class="p-medium" href="#">나이별 랭킹</a></li>
                <li><a class="p-medium" href="#">성분별 랭킹</a></li>
                <li><a class="p-medium" href="#">브랜드별 랭킹</a></li>
            </ul>
        </li>
        <li>
            <a class="h-imcre24" href="#">작당모의</a>
            <ul class="f-depth2">
                <li><a class="p-medium" href="#">공지사항</a></li>
                <li><a class="p-medium" href="#">리뷰 게시판</a></li>
                <li><a class="p-medium" href="/board/list?num=1">자유 게시판</a></li>
            </ul>
        </li>
    </ul>
</div>