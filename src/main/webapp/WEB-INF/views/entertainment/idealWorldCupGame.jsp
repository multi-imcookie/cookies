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
            object-fit: contain; /* 이미지 비율 유지하면서 내부에 꽉 채우도록 조정 */
            transition: transform 0.3s ease;
        }

        /* 호버 효과 */
        .img-button:hover img {
            transform: scale(1.3); /* 호버 시 이미지 크기를 1.1배로 확대 */
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
    </style>
    <script>
        var kangValue = ${param.kang};
    </script>
</head>
<body>
<%@include file="/header.jsp" %>
<div class="sub-container match-info">
    <p style="font-size: 30px; margin-bottom: -20px;">${param.kang}강</p>
    <p style="margin-top: -20px;">
        <span id="match">1</span>
        <span> / </span>
        <span id="round"><%=round%></span>
    </p>
</div>
<div id="buttonsContainer">
    <button class="img-button" data-image="" data-id="" data-name="" id="button0">
        <div>
            <img src="" alt="">
        </div>
        <span class="snack-name"></span> <!-- snack_name 출력 -->
    </button>
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
                button.style.transform = 'translateX(-50px)'; // 왼쪽으로 50px 이동
            } else{
                button.style.transition = 'transform 0.1s ease';
                button.style.transform = 'translateX(50px)'; // 오른쪽으로 50px 이동
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

                var encodedChampion = encodeURIComponent(JSON.stringify(champion)); // URL 안전한 형태로 인코딩

                location.replace('idealWorldCupGameOverAll.jsp?champion=' + encodedChampion);
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
<%@include file="/footer.jsp" %>
</body>
</html>
