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

        // 스크롤 가능한 div 요소와 스크롤 위치를 아래로 유지하는 함수
        function scrollToBottom() {
            var scrollableDiv = document.getElementById('message');
            scrollableDiv.scrollTop = scrollableDiv.scrollHeight;
        }

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

        // 입력 필드 비우기
        document.getElementById('text').value = '';

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

            let response = document.getElementById('response');
            let userMessage = document.createElement('div');
            userMessage.className = 'user-bubble';
            userMessage.innerHTML = '<p>' + text + "번" + '</p>'; // <p> 태그로 감싸기
            response.appendChild(userMessage);
            scrollToBottom();
        }

        //받은 데이터를 원하는 위치에 넣음.
        function showMessageOutput(messageOutput) {
            let response = document.getElementById('response');
            let chatbotMessage = document.createElement('div');
            let aTag = document.createElement('a');
            let pTag = document.createElement('p');
            chatbotMessage.className = 'chat-bubble';


            //메뉴 텍스트와 링크를 p 태그에 추가
            // p.appendChild(document.createTextNode(messageOutput.menu + ' '));

            // 메뉴가 "20"인 경우에만 페이지 링크를 생성하고 추가
            if (messageOutput.text === "40") {
                pTag.appendChild(document.createTextNode("회원정보 수정 페이지로 바로 이동 👉 "));
                aTag.setAttribute('href', '/editMyInfo');
                aTag.innerHTML = '회원정보수정 페이지';
                pTag.appendChild(aTag);
                chatbotMessage.appendChild(pTag);
            }
            if (messageOutput.text === "2") {
                pTag.appendChild(document.createTextNode("과자취향을 알아보세요! 👉 "));
                aTag.setAttribute('href', '../curation/curation.jsp');
                aTag.innerHTML = '과자취향분석하기';
                pTag.appendChild(aTag);
                chatbotMessage.appendChild(pTag);
            }
            if (messageOutput.text === "3") {
                pTag.appendChild(document.createTextNode("과자이상형 월드컵! 👉 "));
                aTag.setAttribute('href', '../entertainment/ideal.jsp');
                aTag.innerHTML = '내과자순위알아보기';
                pTag.appendChild(aTag);
                chatbotMessage.appendChild(pTag);
            }


            pTag.appendChild(document.createTextNode(messageOutput.menu));
            chatbotMessage.appendChild(pTag);
            response.appendChild(chatbotMessage);
            document.getElementById('text').innerHTML = '';
            scrollToBottom();

        }
    </script>

    <body onload="connect();">

    <%--   <div style="width: 500px;">--%>
    <div class="chatbot-container">
        <div id="message" class="message p-regular">
            <div class="detail-container" p="medium">
                <div class="chat-bubble"><p>안녕하세요! I'm cookie 전과자 챗봇입니다. 😊<br>원하시는 메뉴 번호를 입력해주세요.</p></div>
                <div class="chat-bubble"><p>1.과자 추천</p></div>
                <div class="chat-bubble"><p>2.과자 취향분석</p></div>
                <div class="chat-bubble"><p>3.과자 월드컵</p></div>
                <div class="chat-bubble"><p>4.회원정보 관리</p></div>
                <div id="response">
                </div>
            </div>
        </div>
        <div id="conversationDiv" class="form-style">
            <input type="text" id="text">
            <button id="sendMessage" onclick="sendMessage();" class="fill-btn">Send</button>
        </div>
    </div>
</div>
<%@include file="/footer.jsp" %>
</body>
</html>