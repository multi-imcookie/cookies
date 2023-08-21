<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 2023-08-09
  Time: 오전 11:08
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<head>
    <title>Title</title>
    <%@ include file="../link.jsp" %>
    <script>
        window.onload = function() {
            var urlParams = new URLSearchParams(window.location.search);
            var winner = urlParams.get('winner');

            // winner 값을 HTML 내에 삽입하기
            var winnerElement = document.getElementById('winner');
            if (winnerElement) {
                winnerElement.textContent = winner;

                var imagePath = '/resources/img/entertainment/' + winner; // 이미지 경로 생성
                var imageElement = document.createElement('img');
                imageElement.src = imagePath; // 이미지 경로 설정
                winnerElement.appendChild(imageElement); // 이미지를 winnerElement에 추가

                // MyBatis를 사용하여 DB 업데이트 수행
                fetch('/updateWinnerWins?winnerName=' + winner)
                    .then(response => response.text())
                    .then(result => {
                        console.log('DB update result:', result);
                    })
                    .catch(error => {
                        console.error('Error updating DB:', error);
                    });
            }
        };
    </script>
</head>
<body>
<%@include file="../header.jsp" %>
<table>
    <tr>
        <form action="/entertainment/idealWorldCupGame" method="get">
            <label for="kang">라운드를 선택 해주세요:</label>
            <select name="kang" id="kang">
                <option value="8">8강</option>
                <option value="4" selected>4강</option>
            </select>
            <br><br>
            <input type="submit" value="다시 하기" style="background: #5C492C; color: black; width: 70px;">
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
<div id="winner"></div>
<%@include file="../footer.jsp" %>
</body>
