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
        System.out.println("map = " + map); //입력값 출력
        // 검색시 닉네임 ,폰번호 다른경우 "잘못된이름" , 일치하는 경우 "아이디 뒷부분 * 출력
        String idResult = findService.findId(map);  //nickname과 phone번호로 자체 로그인 아이디 검색
        Map<String, String> response = new HashMap<>(); //ajax로 값 넘겨줄 response
//        response.put("name",(String)map.get("username"));
        response.put("findId","1");
        response.put("idResult", idResult); //잘못된 닉네임 전화번호  or 아이디 ** 출력
        response.put("showText","정보 보호를 위해 아이디의 일부만 보여집니다.");
        System.out.println("response = " + response); // 가공값 출력
        return response;
    }
    @RequestMapping("/findPassWord")
    @ResponseBody
    public Map<String, String> findPassWord(@RequestParam Map<String, Object> map){
        String findResult = findService.findPassWord(map); //비밀변경후 , 문자로 전송
        System.out.println("map = " + map); //입력값 출력
        Map<String, String> response = new HashMap<>(); //ajax로 넘겨줄 값 response
        response.put("findPassWord","1");
        response.put("phoneNumber", (String)map.get("phoneNumber"));
        response.put("findResult",findResult);
        System.out.println("response = " + response);//가공값 출력
        return response;
    }
}
