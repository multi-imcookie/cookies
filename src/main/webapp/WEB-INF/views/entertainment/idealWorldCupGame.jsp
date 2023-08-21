<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div id="d1">
    <%
        //몇강인지 선택 받아와서 kang에 Integer로 저장
        String selectedRound = request.getParameter("kang");
        int kang = Integer.parseInt(selectedRound);
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
        }
    </style>
</head>
<body>
<%@include file="/header.jsp" %>
<div id="buttonsContainer">
    <button class="img-button" data-image="" id="button0">
        <div>
            <img src="/resources/img/entertainment/image1.jpg" alt="">
            <span></span>
        </div>
    </button>
    <button class="img-button" data-image="" id="button1">
        <div>
            <img src="/resources/img/entertainment/image2.jpg" alt="">
            <span></span>
        </div>
    </button>
</div>
<script>
    var SnackList = [
        <c:forEach items="${list}" var="image" varStatus="loop">
        "${image}"<c:if test="${not loop.last}">,</c:if>
        </c:forEach>
    ];
    var kangValue = <%= kang %>;
    var initialSnackList = SnackList.slice(0, kangValue); // 처음 랜덤으로 받아온 N개의 스넥을 몇강인지에따라 맞춰서 초기화
    var nextSnackList= initialSnackList; //과자 리스트에 처음 초기화 값은 몇강인지에 따라
    console.log(initialSnackList)

    var index0 = 0; //왼쪽 버튼의 인덱스
    var index1 = 1; //오른쪽 버튼의 인덱스
    var buttons = document.querySelectorAll('.img-button');
    var winsImages = []; //이기면 저장되는 배열
    var clickCnt = 0; //클릭횟수
    var winner =[];

    function updateButton(buttonIndex, imageIndex) { //버튼 0 (왼쪽)과 1 (오른쪽)에 이미지 배열 인덱스 번호 넣는 함수
        //nextSnackList에서 가져온다.
        buttons[buttonIndex].setAttribute('data-image', nextSnackList[imageIndex]); //배열에서 가져와서 해당 버튼의 data-image 속성에 설정하는 역할
        buttons[buttonIndex].querySelector('img').src = '/resources/img/entertainment/' + nextSnackList[imageIndex]; //이미지 경로 설정 배열에 인덱스

        //.jpg 제거 하는 부분
        var imageFileName = nextSnackList[imageIndex];
        var imageNameWithoutExtension = imageFileName.replace('.jpg', '');
        buttons[buttonIndex].querySelector('span').textContent = imageNameWithoutExtension;

    }

    buttons.forEach(function(button, buttonIndex) { // 클릭시 발생하는 함수 (1.인덱스 +1) (2.새로운 배열에 클릭한 사진 넣기)
        button.addEventListener('click', function() {
            var href;
            if (kangValue == 2) {
                var image = this.getAttribute('data-image');
                winner.push(image);
                console.log("winner ", winner)
                //location.href = 'idealWorldCupGameOverAll.jsp?winner='+winner
                location.replace('idealWorldCupGameOverAll.jsp?winner='+winner)
            }
            clickCnt++;
            if(clickCnt==(kangValue/2)) {
                kangValue = clickCnt;
                clickCnt = 0;
                winsImages = winsImages.sort(() => Math.random() - 0.5);
                nextSnackList = winsImages;
                nextSnackList = nextSnackList.sort(() => Math.random() - 0.5);
                // console.log("1차끝", "nextSnackList =", nextSnackList, "winsImages =", winsImages)

                var image = this.getAttribute('data-image');
                winsImages.push(image);
                winsImages = [];
                index0 = (index0 + 2) % nextSnackList.length;
                updateButton(0, index0);
                index1 = (index1 + 2) % nextSnackList.length;
                updateButton(1, index1);
                // console.log("여긴(clickCnt==(kangValue/2))")
                // console.log("nextSnackList ", nextSnackList);
                // console.log("winsImages ", winsImages);
                // console.log("winsImages length ", winsImages.length);
                // console.log("kangValue", kangValue);
                // console.log("clickCnt ", clickCnt);
            }
            else{
                    var image = this.getAttribute('data-image');
                    winsImages.push(image);
                    index0 = (index0 + 2) % nextSnackList.length;
                    updateButton(0, index0);
                    index1 = (index1 + 2) % nextSnackList.length;
                    updateButton(1, index1);
                    // console.log("nextSnackList ",nextSnackList);
                    // console.log("winsImages ",winsImages);
                    // console.log("winsImages length ",winsImages.length);
                    // console.log("kangValue", kangValue);
                    // console.log("clickCnt ",clickCnt);
            }
        });
        //updateButton(buttonIndex);
        updateButton(0, index0);
        updateButton(1, index1);
    });
</script>
<%@include file="/footer.jsp" %>
</body>
</html>