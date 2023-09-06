<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div id="d1">
    <%
        String selectedRound = request.getParameter("kang");
        int round = Integer.parseInt(selectedRound) / 2;
    %>
</div>
<html>
<head>
    <%@ include file="/link.jsp" %>
    <meta charset="UTF-8">
    <title>Image Button Example</title>
    <style>
        #buttonsContainer {
            display: flex;
            justify-content: space-between;
        }

        .img-button {
            background: none;
            border: none;
            cursor: pointer;
            display: inline-block;
            padding: 0;
            width: 50%;
            box-sizing: border-box;
        }

        .img-button img {
            width: 300px;
            height: 300px;
            /*max-width: 100%;*/
            /*max-height: 100%;*/
            margin-bottom: 80px;
            /*object-fit: contain; !* 이미지 비율 유지하면서 내부에 꽉 채우도록 조정 *!*/
            object-fit: cover;
            transition: transform 0.3s ease;
        }

        /* 호버 효과 */
        .img-button:hover img {
            transform: scale(1.3); /* 호버 시 이미지 크기를 1.3배로 확대 */
        }

        .vs-container {
            position: relative;
            width: 100%;
        }

        .vs-image {
            position: absolute;
            z-index: 3;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
        }

        .match-info {
            text-align: center;
            position: relative;
            top: -50px; /* 원하는 위치에 맞게 조정 */
            margin-top: 50px; /* 아래로 내릴 값 설정 */
            margin-bottom: -20px;
            font-family: ImcreSoojin, serif;
            color: #452C07;
            font-size: 24px;
            font-weight: 400;
            line-height: 36px;
        }

        .snack-name {
            display: block;
            font-family: Pretendard, serif;
            color: #452C07;
            font-size: 20px;
            font-weight: 700;
            line-height: 48px;
        }

        .mdl-info{
            flex-direction: column;
            align-items: center;
        }

        .selectMenu {
            position: relative;
            width: 200px;
            font-family: sans-serif,helvetica;
            color: white;
            transform-style: preserve-3d;
            perspective: 1500px;
        }
        .selectMenu span {
            height: inherit;
            margin-left: 20px;
            line-height: 60px;
        }
        .selectMenu .front,
        .selectMenu .back {
            -moz-transition: all 0.32s cubic-bezier(0.18, 0.89, 0.32, 1.28);
            -webkit-transition: all 0.32s cubic-bezier(0.18, 0.89, 0.32, 1.28);
            transition: all 0.32s cubic-bezier(0.18, 0.89, 0.32, 1.28);
        }
        .selectMenu .front {
            margin-top: 30px;
            width: 200px;
            height: 60px;
            border-radius: 12px;
            font-size: 16px;
            font-weight: 600;
            line-height: 28px;
            background-color: #E04C47;
            color: #F9F5F2;
            -moz-backface-visibility: hidden;
            -webkit-backface-visibility: hidden;
            backface-visibility: hidden;
            cursor: pointer;
            padding-left: 51px;
        }
        .selectMenu .front:hover {
            background-color: #B48D69;
        }
        .selectMenu .front:after {
            position: absolute;
            content: "";
            top: 26px;
            right: 20px;
            width: 0;
            height: 0;
            border-left: 8px solid transparent;
            border-right: 8px solid transparent;
            border-top: 8px solid #fff;
        }
        .selectMenu .back {
            -moz-transform: rotateX(180deg);
            -webkit-transform: rotateX(180deg);
            transform: rotateX(180deg);
            -moz-backface-visibility: hidden;
            -webkit-backface-visibility: hidden;
            backface-visibility: hidden;
        }
        .selectMenu ul {
            position: absolute;
            width: calc(100% - 40px);
            top: -140px;
            padding: 20px;
            border-radius: 10px;
            background-color: #fff;
            box-shadow: 2px 4px 8px rgba(0, 0, 0, 0.32);
            list-style: none;
            z-index: 1;
        }
        .selectMenu ul li {
            text-align: center;
            color: #B48D69;
            line-height: 35px;
            cursor: pointer;
            font-family: Pretendard, sans-serif;
            font-size: 16px;
            font-weight: 400;
            line-height: 28px;
        }
        .selectMenu ul li:hover {
            background: #e7e7e7;
        }
        .selectMenu.flip .back {
            -moz-transform: rotateX(0deg);
            -webkit-transform: rotateX(0deg);
            transform: rotateX(0deg);
        }
        #championImage {
            width: 320px;
            height: auto; /* 자동으로 높이를 조정하여 비율 유지 */
            max-width: 100%; /* 최대 너비를 설정하여 화면 크기에 맞게 조정 */
            display: block; /* 이미지를 블록 레벨 요소로 설정하여 가로 중앙 정렬 */
            margin: 0 auto; /* 가로 중앙 정렬을 위한 마진 설정 */
        }
    </style>
    <script>
        var kangValue = ${param.kang};
    </script>
</head>
<body>
<%@include file="/header.jsp" %>
<div class="modal-overlay">
    <div class="modal-box">
            <p class="h-pre36">🎉<span>우승</span>🎉</p>
            <div class="mdl-info">
                <img id="championImage" src="">
                <span id="championName" class="snack-name"></span>
            </div>
        <div class="btn-wrap">
            <div id="wrapper">
                <div class="selectMenu">
                    <div class="front">
                        <span class="p-medium">다시하기</span>
                    </div>
                    <div class="back">
                        <ul>
                            <li id="round4">4강</li>
                            <li id="round8">8강</li>
                            <li id="round16">16강</li>
                            <li id="round32">32강</li>
                            <li id="round64">64강</li>
                            <li id="round128">128강</li>
                        </ul>
                    </div>
                </div>
            </div>
            <a class="light-fill-btn p-medium" href="/entertainment/idealWorldCupAll?page=1">랭킹 보기</a>
            <a class="fill-btn p-medium" href="/entertainment/idealBoardAll?page=1">의견 보기</a>
            <a class="light-fill-btn p-medium" href="/index.jsp">돌아가기</a>
        </div>
    </div>
</div>
<div class="sub-container">
    <div class="match-info">
        <p style="font-size: 30px">${param.kang}강</p>
        <p>
            <span id="match">1</span>
            <span> / </span>
            <span id="round"><%=round%></span>
        </p>
    </div>
    <div class="vs-container">
        <div id="buttonsContainer">
            <button class="img-button" data-image="" data-id="" data-name="" id="button0">
                <div>
                    <img src="" alt="">
                </div>
                <span class="snack-name"></span> <!-- snack_name 출력 -->
            </button>
            <button class="img-button" data-image="" data-id="" data-name="" id="button1">
                <div>
                    <img src="" alt="">
                </div>
                <span class="snack-name"></span> <!-- snack_name 출력 -->
            </button>
        </div>
        <div class="vs-image">
            <img src="/resources/img/entertainment/vs.png" alt="VS">
        </div>
    </div>
</div>
<script>
    var round = <%=round%>; // JSP에서 변수의 값을 JavaScript로 전달
    var matchElement = document.getElementById('match');
    var roundElement = document.getElementById('round');
    var nextSnackList = [
        <c:forEach items="${randomSnacks}" var="snack" varStatus="loop">
        {
            snack_id: "${snack.snack_id}",
            snack_name: "${snack.snack_name}",
            snack_img: "${snack.snack_img}"
        }<c:if test="${not loop.last}">, </c:if>
        </c:forEach>
    ];

    var index0 = 0;
    var index1 = 1;
    var buttons = document.querySelectorAll('.img-button');
    var winnerList = [];
    var clickCnt = 0;
    var match = 1;
    var round = kangValue / 2;
    var champion = [];

    function updateButton(buttonIndex, imageIndex) {
        buttons[buttonIndex].setAttribute('data-image', nextSnackList[imageIndex].snack_img);
        buttons[buttonIndex].setAttribute('data-id', nextSnackList[imageIndex].snack_id);
        buttons[buttonIndex].setAttribute('data-name', nextSnackList[imageIndex].snack_name);
        buttons[buttonIndex].querySelector('img').src = nextSnackList[imageIndex].snack_img;
        buttons[buttonIndex].querySelector('span').textContent = nextSnackList[imageIndex].snack_name;
    }

    buttons.forEach(function (button, buttonIndex) {
        button.addEventListener('click', function () {
            // 클릭 이벤트 발생 시 이동 애니메이션 적용
            if (buttonIndex === 0) {
                button.style.transition = 'transform 0.1s ease';
                button.style.transform = 'translateX(-70px)'; // 왼쪽으로 70px 이동
            } else {
                button.style.transition = 'transform 0.1s ease';
                button.style.transform = 'translateX(70px)'; // 오른쪽으로 70px 이동
            }
            // 애니메이션 종료 후 원래 위치로 복귀
            setTimeout(function () {
                button.style.transition = '';
                button.style.transform = 'translateX(0)';
            }, 100); // 애니메이션 시간과 동일한 시간으로 설정 (0.3초)

            if (kangValue == 2) {
                var image = this.getAttribute('data-image');
                var snack_id = this.getAttribute('data-id');
                var snack_name = this.getAttribute('data-name');
                champion.push({snack_id, snack_name, snack_img: image});
                // 챔피언 요소를 가져옵니다
                var championImageElement = document.getElementById('championImage');
                var championNameElement = document.getElementById('championName');
                // 챔피언의 src 속성을 설정합니다
                championImageElement.src = champion[0].snack_img;
                championNameElement.textContent = champion[0].snack_name;

                fetch('/updateWinnerWins?snack_id=' + champion[0].snack_id)
                    .then(response => response.text())
                    .then(result => {
                        console.log('DB update result:', result);

                        // 버튼 숨김 처리
                        $('#button0').hide();
                        $('#button1').hide();
                        // 모달 내용을 채우고 보여주기
                        modalShow();
                    })
                    .catch(error => {
                        console.error('Error updating DB:', error);
                    });
            }
            clickCnt++;
            match++; // 매치 번호 업데이트
            if (clickCnt == (kangValue / 2)) {
                kangValue = clickCnt;
                clickCnt = 0;
                match = 1;
                round = round / 2;
                winnerList = winnerList.sort(() => Math.random() - 0.5);
                nextSnackList = winnerList;
                nextSnackList = nextSnackList.sort(() => Math.random() - 0.5);
                // console.log("1차끝", "nextSnackList =", nextSnackList, "winnerList =", winnerList)

                var image = this.getAttribute('data-image');
                var snack_id = this.getAttribute('data-id');
                var snack_name = this.getAttribute('data-name');
                winnerList.push({snack_id, snack_name, snack_img: image});
                winnerList = [];
                index0 = (index0 + 2) % nextSnackList.length;
                updateButton(0, index0);
                index1 = (index1 + 2) % nextSnackList.length;
                updateButton(1, index1);
            } else {
                var image = this.getAttribute('data-image');
                var snack_id = this.getAttribute('data-id');
                var snack_name = this.getAttribute('data-name');
                winnerList.push({snack_id, snack_name, snack_img: image});
                index0 = (index0 + 2) % nextSnackList.length;
                updateButton(0, index0);
                index1 = (index1 + 2) % nextSnackList.length;
                updateButton(1, index1);
            }
            // match와 round 값 업데이트
            matchElement.textContent = match;
            roundElement.textContent = round;
        });
        updateButton(0, index0);
        updateButton(1, index1);
    });
</script>
<script>
    $(document).ready(function(){
        $(".selectMenu").click(function(){
            $(this).toggleClass("flip");
        });
        $(".back ul li").click(function(){
            var option = $(this).html();
            $(".front span").html(option);
        });

        // 추가한 새로운 스크립트
        $(".back ul li").click(function(){
            var selectedValue = $(this).html();
            if (selectedValue === "4강") {
                redirectToIdealWorldCupGame('4');
            }
            else if (selectedValue === "8강") {
                redirectToIdealWorldCupGame('8');
            }
            else if (selectedValue === "16강") {
                redirectToIdealWorldCupGame('16');
            }
            else if (selectedValue === "32강") {
                redirectToIdealWorldCupGame('32');
            }
            else if (selectedValue === "64강") {
                redirectToIdealWorldCupGame('64');
            }
            else if (selectedValue === "128강") {
                redirectToIdealWorldCupGame('128');
            }
        });

        function redirectToIdealWorldCupGame(round) {
            const form = document.createElement('form');
            form.method = 'get';
            form.action = '/entertainment/idealWorldCupGame';

            const input = document.createElement('input');
            input.type = 'hidden';
            input.name = 'kang';
            input.value = round;

            form.appendChild(input);
            document.body.appendChild(form);
            form.submit();
        }
    });
</script>
<%@include file="/footer.jsp" %>
</body>
</html>