package com.multi.cookies.chat;

import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.stereotype.Controller;

@Controller
public class WebSocketController {

    @MessageMapping("/chatbot")
    @SendTo("/topic/messages")
    public OutputMessage send(Message message) throws Exception {
        String menu = "";
        switch (message.getText()) {
            case "1":
                menu = "전과자>>  어떤 맛을 원하시나요?  \n" +
                        "10) 짭쪼롬		11) 달달		12) 단짠단짠";
                break;
            case "2":
                menu = "";
                break;
            case "3":
                menu = "";
                break;
            case "4":
                menu = "전과자>>  20) 회원정보수정";
                break;
            case "40":
                menu = "";
                break;
            case "10":
                menu = "전과자>>  포카칩, 오감자, 포테토칩, 스윙칩, 양파링, 포스틱 추천드려요. \n" +
                        "1) 처음으로";
                break;
            case "11":
                menu = "전과자>>  콘초, 빼빼로, 홈런볼, 다이제, 미쯔, 초코송이, 초코칩 추천드려요. \n" +
                        "1) 처음으로";
                break;
            case "12":
                menu = "전과자>>  쌀과자, 허니버터칩, 고래밥 추천드려요. \n" +
                        "1) 처음으로";
                break;

            default:
                menu = "전과자>>  선택한 번호는 없는 메뉴입니다. 다시 입력해주세요.";
                break;
        }
        return new OutputMessage(message.getFrom(), message.getText(), menu);
    }

}
