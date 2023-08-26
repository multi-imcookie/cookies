<%-- 아이디의 인증이 필요한 페이지일 경우에는 session의 id값이 null이면 로그인페이지로 이동하도록 처리 --%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:if test="${sessionScope.member_id == null}">
  <script>
    alert("로그인 하신 후에 사용해주세요");
    location.href="${path}/member/login";
  </script>
</c:if>
