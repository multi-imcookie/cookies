<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
<head>
    <meta charset="UTF-8">
    <title>채팅</title>
    <%@ include file="/link.jsp" %>

</head>
<body>
<%@include file="/header.jsp" %>
<div class="sub-container">
    <h3 class="h-imcre24">Chatbot</h3>
    <!-- <script src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js"></script> -->
    <script src="../resources/js/sockjs-0.3.4.js"></script>
    <script src="../resources/js/stomp.js"></script>
    <script src="../resources/js/webSocketSendToUserApp.js"></script>

    <script type="text/javascript">
        var stompClient = null;

        function setConnected(connected) {
            document.getElementById('response').innerHTML = '';
        }

        //서버로 연결함.
        function connect() {
            //chat주소 서버와의 소켓객체 생성
            var socket = new SockJS('${pageContext.request.contextPath}/chatbot');
            //소켓을 통해 클라이언트 객체 획득
            stompClient = Stomp.over(socket);
            //소켓 클라이언트를 통해 연결 획득
            stompClient.connect({}, function (frame) {
                setConnected(true); //연결 설정
                console.log('Connected: ' + frame);
                //소켓 클라이언트를 통해 챗팅하고 싶은 특정 사이트에 연결
                //messageOutput : 받은 메시지
                //topic/messages로 가입한 클라이언트에게 messageOutput을 보냄.
                //@SendTo("/topic/messages")와 동일해야함.
                //config.enableSimpleBroker("/topic");와 동일해야함.
                stompClient.subscribe('/topic/messages', function (
                    messageOutput) {
                    //서버에서 받은 메시지 출력
                    showMessageOutput(JSON.parse(messageOutput.body));
                });
            });
        }

        //서버로 연결 끊음.
        function disconnect() {
            if (stompClient != null) {
                stompClient.disconnect();
            }
            setConnected(false); //연결끊어졌을 때 설정 변경
            console.log("Disconnected");
        }

        //서버로 메세지 보냄
        function sendMessage() {
            //입력한 정보를 가지고 와서
            var from = "guest";
            var text = document.getElementById('text').value;
            //url을 /app/cht을 호출하고,data를 json형태의 sring으로 만들어서 보내라.
            stompClient.send("/app/chatbot", {}, JSON.stringify({
                'from': from,
                'text': text
            }));
        }

        //받은 데이터를 원하는 위치에 넣음.
        function showMessageOutput(messageOutput) {
            var response = document.getElementById('response');
            var p = document.createElement('p');
            p.style.wordWrap = 'break-word';

            //메뉴 텍스트와 링크를 p 태그에 추가
            // p.appendChild(document.createTextNode(messageOutput.menu + ' '));

            // 메뉴가 "20"인 경우에만 페이지 링크를 생성하고 추가
            if (messageOutput.text === "40") {
                p.appendChild(document.createTextNode("전과자 >> 회원정보 수정 페이지 입니다! >>>>>  "));
                var aTag = document.createElement('a');
                aTag.setAttribute('href', '/editMyInfo');
                aTag.innerHTML = '회원정보수정 페이지';
                p.appendChild(aTag);
            }
            if (messageOutput.text === "2") {
                p.appendChild(document.createTextNode("전과자 >> 과자취향을 알아보세요! >>>>>  "));
                var aTag = document.createElement('a');
                aTag.setAttribute('href', '../curation/curation.jsp');
                aTag.innerHTML = '과자취향분석하기';
                p.appendChild(aTag);
            }
            if (messageOutput.text === "3") {
                p.appendChild(document.createTextNode("전과자 >> 과자이상형 월드컵! >>>>>  "));
                var aTag = document.createElement('a');
                aTag.setAttribute('href', '../entertainment/ideal.jsp');
                aTag.innerHTML = '내과자순위알아보기';
                p.appendChild(aTag);
            }



            p.appendChild(document.createTextNode(messageOutput.menu));
            response.appendChild(p);
            document.getElementById('text').innerHTML = '';
        }
    </script>
    </head>
    <body onload="connect();">
    <br>
    <br>
    <%--	<div style="width: 500px;">--%>
    <div class="detail-container" p="medium">
        <div>안녕하세요! imcookie 챗봇 전과자입니다.</div>
        <div>현재 다음 기능을 제공하고 있습니다.</div>
        <br>
        <div>1.스낵추천</div>
        <br>
        <div>2.과자취향분석</div>
        <br>
        <div>3.과자월드컵!</div>
        <br>
        <div>4.회원정보관리</div>
        <br>
        <div id="response">

        </div>
        <div class="form-floating mb-3 mt-3" id="conversationDiv">
            <table>
                <tr>
                    <td><input type="text" class="form-control" id="text" style="width: 400px;"></td>
                    <td>
                        <button id="sendMessage" onclick="sendMessage();" class="btn btn-primary">Send</button>
                    </td>
                </tr>
            </table>
        </div>
    </div>
    </body>
</html>