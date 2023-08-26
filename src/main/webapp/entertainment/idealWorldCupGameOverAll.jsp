<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<head>
    <title>Title</title>
    <%@ include file="../link.jsp" %>
</head>
<body>
<%@include file="../header.jsp" %>
<div class="sub-container">
    <div id="container">
        <div id="snackInfo"></div> <!-- snack_name과 image 출력 -->
    </div>

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
                <input type="submit" value="다시하기" style="background: #5C492C; color: black; width: 70px;"
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
    // 다시하기 버튼을 누르면 세션 스토리지 초기화
    function resetSessionStorage() {
        sessionStorage.removeItem('champion');
        sessionStorage.removeItem('updated'); // 'updated' 키 제거
    }

    window.onload = function () {
        var urlParams = new URLSearchParams(window.location.search);
        var championJson = urlParams.get('champion');
        var champion = JSON.parse(decodeURIComponent(championJson));

        var snackInfoContainer = document.getElementById('snackInfo');

        // champion 배열을 순회하면서 snack_name과 snack_img 출력
        champion.forEach(function (item) {
            var snackName = item.snack_name;
            var snackImg = item.snack_img;

            // 출력 형식에 맞게 페이지에 추가
            var snackInfoDiv = document.createElement('div');
            var imgElement = document.createElement('img');
            imgElement.src = snackImg;
            var nameElement = document.createElement('p');
            nameElement.textContent = '우승 과자 : ' + snackName;

            snackInfoDiv.appendChild(nameElement);
            snackInfoDiv.appendChild(imgElement);

            // 이미지와 이름을 추가한 뒤에 snackInfoContainer에 추가
            snackInfoContainer.appendChild(snackInfoDiv);
        });

        // 서버에 업데이트를 한 경우 세션에 값을 설정하여 중복 업데이트를 방지
        var updatedSession = sessionStorage.getItem('updated');
        if (!updatedSession) {
            // MyBatis를 사용하여 DB 업데이트 수행
            fetch('/updateWinnerWins?snack_id=' + champion[0].snack_id)
                .then(response => response.text())
                .then(result => {
                    console.log('DB update result:', result);
                    // 업데이트를 했음을 세션에 설정
                    sessionStorage.setItem('updated', 'true');
                })
                .catch(error => {
                    console.error('Error updating DB:', error);
                });
        } else {
            console.log('Already updated in this session');
        }
    };
</script>
</body>
