<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 2023-08-09
  Time: 오전 10:11
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page session="false" %>
<html>
<head>
    <title>Title</title>
    <%@ include file="../link.jsp" %>
</head>
<body>
<%@include file="../header.jsp" %>
<div class="sub-container">
    <table>
        <tr>
            <form action="/entertainment/idealWorldCupGame" method="get">
                <label for="kang">라운드를 선택 해주세요:</label>
                <select name="kang" id="kang">
                    <option value="4">4강</option>
                    <option value="8">8강</option>
                    <option value="16">16강</option>
                    <option value="32">32강</option>
                    <option value="64">64강</option>
                    <option value="128">128강</option>
                </select>
                <br><br>
                <input type="submit" value="시작하기" style="background: #5C492C; color: black; width: 70px;"
                       onclick="resetSessionStorage()">
            </form>
        </tr>
        <tr>
            <td><a href="/entertainment/idealWorldCupAll?page=1">
                <button>랭킹</button>
            </a></td>
        </tr>
        <tr>
            <td><a href="/entertainment/idealBoardAll?page=1">
                <button>의견</button>
            </a></td>
        </tr>
        <tr>
            <td><a href="../index.jsp">
                <button>뒤로가기</button>
            </a></td>
        </tr>
    </table>
</div>
<%@include file="../footer.jsp" %>
<script>
    // 시작하기 버튼을 누르면 세션 스토리지 초기화
    function resetSessionStorage() {
        sessionStorage.removeItem('champion');
        sessionStorage.removeItem('updated');
    }
</script>
</body>
</html>
