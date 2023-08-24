<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div id="d1">
    <%
        String selectedRound = request.getParameter("kang");
        int round = Integer.parseInt(selectedRound)/2;
    %>
</div>
<head>
    <%@ include file="/link.jsp" %>
    <meta charset="UTF-8">
    <title>Image Button Example</title>
    <style>
        #buttonsContainer {
            display: flex;
            justify-content: center;
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
            max-width: 100%;
            max-height: 100%;
            object-fit: contain; /* 이미지 비율 유지하면서 내부에 꽉 채우도록 조정 */
        }
        .vs-container {
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .match-info {
            text-align: center;
            position: relative;
            top: -50px; /* 원하는 위치에 맞게 조정 */
            margin-top: 50px; /* 아래로 내릴 값 설정 */
        }

        /* ... 기존 스타일 ... */
        .h-imcre24, .s-h-imcre24 {
            font-family: ImcreSoojin, serif;
            color: #452C07;
            font-size: 24px;
            font-weight: 400;
            line-height: 36px;
        }

        /* ... 기존 스타일 ... */
        .s-h-imcre24 {
            text-align: center;
            padding: 160px 0 60px;
            box-sizing: border-box;
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
<div class="match-info">
    <p class="h-imcre24">${param.kang}강</p>
    <p>
        <span id="match" class="s-h-imcre24">1</span>
        <span class="s-h-imcre24"> / </span> <!-- / 문자 스타일 조정을 위한 span 추가 -->
        <span id="round" class="s-h-imcre24"><%=round%></span>
    </p>
<%--    <p>--%>
<%--        <span id="match" class="s-h-imcre24">1</span>--%>
<%--        <span class="s-h-imcre24"> / </span>--%>
<%--        <% if (round == 1) { %>--%>
<%--        <span class="s-h-imcre24">결승전</span>--%>
<%--        <% } else { %>--%>
<%--        <span id="round" class="s-h-imcre24"><%= round %></span>--%>
<%--        <% } %>--%>
<%--    </p>--%>
</div>
<div id="buttonsContainer">
    <button class="img-button" data-image="" data-id="" data-name="" id="button0">
        <div>
            <img src="" alt="">
        </div>
        <span class="snack-name"></span> <!-- snack_name 출력 -->
    </button>
    <div class="vs-container">
        <img src="/resources/img/entertainment/vs.png" alt="VS" class="vs-image">
    </div>
    <button class="img-button" data-image="" data-id="" data-name="" id="button1">
        <div>
            <img src="" alt="">
        </div>
        <span class="snack-name"></span> <!-- snack_name 출력 -->
    </button>
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
        }<c:if test="${not loop.last}">,</c:if>
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
            if (kangValue == 2) {
                var image = this.getAttribute('data-image');
                var snack_id = this.getAttribute('data-id');
                var snack_name = this.getAttribute('data-name');
                champion.push({ snack_id, snack_name, snack_img: image });

                var encodedChampion = encodeURIComponent(JSON.stringify(champion)); // URL 안전한 형태로 인코딩

                location.replace('idealWorldCupGameOverAll.jsp?champion=' + encodedChampion);
            }
            clickCnt++;
            match++; // 매치 번호 업데이트
            if (clickCnt == (kangValue / 2)) {
                kangValue = clickCnt;
                clickCnt = 0;
                match = 1;
                round= round/2;
                winnerList = winnerList.sort(() => Math.random() - 0.5);
                nextSnackList = winnerList;
                nextSnackList = nextSnackList.sort(() => Math.random() - 0.5);
                // console.log("1차끝", "nextSnackList =", nextSnackList, "winnerList =", winnerList)

                var image = this.getAttribute('data-image');
                var snack_id = this.getAttribute('data-id');
                var snack_name = this.getAttribute('data-name');
                winnerList.push({ snack_id, snack_name, snack_img: image });
                winnerList = [];
                index0 = (index0 + 2) % nextSnackList.length;
                updateButton(0, index0);
                index1 = (index1 + 2) % nextSnackList.length;
                updateButton(1, index1);

                // console.log("여긴(clickCnt==(kangValue/2))")
                // console.log("nextSnackList ", nextSnackList);
                // console.log("winnerList ", winnerList);
                // console.log("winnerList length ", winnerList.length);
                // console.log("kangValue", kangValue);
                // console.log("clickCnt ", clickCnt);

            } else {

                var image = this.getAttribute('data-image');
                var snack_id = this.getAttribute('data-id');
                var snack_name = this.getAttribute('data-name');
                winnerList.push({ snack_id, snack_name, snack_img: image });
                index0 = (index0 + 2) % nextSnackList.length;
                updateButton(0, index0);
                index1 = (index1 + 2) % nextSnackList.length;
                updateButton(1, index1);
                // console.log("여긴else");
                // console.log("nextSnackList ", nextSnackList);
                // console.log("winnerList ", winnerList);
                // console.log("winnerList length ", winnerList.length);
                // console.log("kangValue", kangValue);
                // console.log("clickCnt ", clickCnt);
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
