package com.multi.cookies.member.controller;

import com.multi.cookies.member.service.FindService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.PropertySource;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.Map;

@Controller
@PropertySource("classpath:sms.properties")
public class FindController {

    @Autowired
    FindService findService;

    @RequestMapping("/findId")
    @ResponseBody
    public Map<String, String> findId(@RequestParam Map<String, Object> map){ // map = username, phoneNumber
        String member_signId = findService.findId(map);  //id찾기
        Map<String, String> response = new HashMap<>(); //ajax로 값 넘겨줄 response
        System.out.println("map = " + map);
        response.put("name",(String)map.get("username"));
        response.put("member_signId", member_signId);
        response.put("showText","정보 보호를 위해 아이디의 일부만 보여집니다.");
        return response;
    }
    @RequestMapping("/findPassWord")
    @ResponseBody
    public Map<String, String> findPassWord(@RequestParam Map<String, Object> map){
        findService.findPassWord(map); //비밀변경후 , 문자로 전송
        Map<String, String> response = new HashMap<>(); //ajax로 넘겨줄 값 response
        response.put("phoneNumber", (String)map.get("phoneNumber"));
        return response;
    }
}
