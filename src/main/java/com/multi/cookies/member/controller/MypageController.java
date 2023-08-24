package com.multi.cookies.member.controller;

import com.multi.cookies.member.dto.MypageDTO;
import com.multi.cookies.member.service.LoginService;
import com.multi.cookies.member.service.MypageService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class MypageController {
    @Autowired
    MypageService mypageService;

    @Autowired
    LoginService loginService;

    @RequestMapping("getMemberInfo")
    @ResponseBody
    public MypageDTO getMemberInfo(@RequestParam String member_signID) {
        return mypageService.getMemberInfo(member_signID);
    }
}
