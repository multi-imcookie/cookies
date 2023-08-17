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
    public Map<String, String> findId(@RequestParam Map<String, Object> map){
        String id = findService.findId(map);  //id찾기
        Map<String, String> response = new HashMap<>(); //ajax로 값 넘겨줄 response
        response.put("id", id);
        response.put("name",(String)map.get("name"));
        return response;
    }


    @RequestMapping("/findPassWord")
    @ResponseBody
    public Map<String, String> findPassWord(@RequestParam Map<String, Object> map){
        findService.findPassWord(map); //비밀변경후 , 문자로 전송
        Map<String, String> response = new HashMap<>(); //ajax로 넘겨줄 값 response
        response.put("phoneNumber", (String)map.get("phoneNumber"));
//        System.out.println("response = " + response);
        return response;
    }
    @RequestMapping("/user_pop_up")
    public String userPopUp(@RequestParam String id ,@RequestParam String name, Model model){
        model.addAttribute("id",id);
        model.addAttribute("name",name);
        return "member/findId";
    }
    @RequestMapping("/phone")
    public String phonePopUp(@RequestParam String phonenumber, Model model){
        model.addAttribute("phonenumber",phonenumber);
        return "member/findPwd";
    }
}
