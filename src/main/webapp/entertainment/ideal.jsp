<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 2023-08-09
  Time: 오전 10:11
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <%@ include file="../link.jsp" %>
    <style>
        /*body {*/
        /*    background-color: #e2e6f0;*/
        /*}*/
        /*#wrapper {*/
        /*    position: absolute;*/
        /*    top: 45%;*/
        /*    left: 50%;*/
        /*    transform:translate(-50%,-50%);*/
        /*}*/
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
        .produce-img{
            width: 320px;
            height: auto; /* 자동으로 높이를 조정하여 비율 유지 */
            max-width: 100%; /* 최대 너비를 설정하여 화면 크기에 맞게 조정 */
        }
        .modal-box {
            position: absolute;
            display: flex;
            width: 980px;
            padding: 48px;
            box-sizing: border-box;
            flex-direction: column;
            align-items: center;
            gap: 24px;
            border-radius: 24px;
            background-color: #ffffff;
            margin: 0 auto;
            left: 50%;
            transform: translate(160%, 4%);
            transition: transform 0.2s cubic-bezier(0.68, -0.55, 0.27, 1.55);
        }

        .modal-box.active {
            transform: translate(-50%, 0%);
        }
        .spacer {
            height: 300px; /* 원하는 공백 높이로 조정 */
        }
    </style>
</head>
<body>
<%@include file="../header.jsp" %>
<div class="modal-overlay">
    <div class="modal-box">
        <p class="h-pre36">🍪<span>나의 PICK은?</span>🍪</p>
        <div class="mdl-info">
            <img class="produce-img" src="/resources/img/entertainment/produce-pick.png">
            <p>${count}</p>
            <span id="championName" class="snack-name"></span>
        </div>
        <div class="btn-wrap">
            <div id="wrapper">
                <div class="selectMenu">
                    <div class="front">
                        <span>시작하기</span>
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
<div class="spacer"></div> <!-- 공백 추가 -->
<%@include file="../footer.jsp" %>
<script>
    $(document).ready(function(){
        modalShow();
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
</body>
</html>
