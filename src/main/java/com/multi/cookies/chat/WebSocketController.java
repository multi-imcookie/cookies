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
                        "10) 짭쪼롬		11) 달다구리			12) 단짠단짠";
                break;
            case "2":
                menu = "전과자>>  20) 회원정보수정	21) 회원정보조회";
                break;
            case "20":
                menu = "";
                break;
            case "21":
                menu = "전과자>>  정보를 입력해주세요. \n" +
                        "휴대폰번호:000-0000-0000	이메일:______@_______.___	";
                break;
            case "10":
                menu = "전과자>>  전과자가 추천하는 짭쪼롬한 과자는								입니다. \n" +
                        "100)더많은과자추천        1) 처음으로";
                break;
            case "11":
                menu = "전과자>>  전과자가 추천하는 달달한 과자는								입니다. \n" +
                        "111)더많은과자추천        1) 처음으로";
                break;
            case "12":
                menu = "전과자>>  전과자가 추천하는 단짠단짠한 과자는								입니다. \n" +
                        "222)더많은과자추천        1) 처음으로";
                break;
            case "100":
                menu = "전과자>>  더 추천해드릴게요!                              \n" +
                        "1) 처음으로";
                break;
            case "111":
                menu = "전과자>>  더 추천해드릴게요!                              \n" +
                        "1) 처음으로";
                break;
            case "222":
                menu = "전과자>>  더 추천해드릴게요!                              \n" +
                        "1) 처음으로";
                break;
            default:
                menu = "전과자>>  선택한 번호는 없는 메뉴입니다. 다시 입력해주세요.";
                break;
        }
        return new OutputMessage(message.getFrom(), message.getText(), menu);
    }

}
