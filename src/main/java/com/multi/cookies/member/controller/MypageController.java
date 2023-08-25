package com.multi.cookies.member.controller;

import com.multi.cookies.member.dto.MemberDTO;
import com.multi.cookies.member.dto.MypageDTO;
import com.multi.cookies.member.service.MypageService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;

@Controller
public class MypageController {
    @Autowired
    MypageService mypageService;

    @RequestMapping("/mypage")
    public String mypage() {
        return "mypage";
    }


    @RequestMapping("/getMemberInfo")
    public MypageDTO getMemberInfo(HttpSession session, Model model) {
        MemberDTO authInfo = (MemberDTO) session.getAttribute("authInfo");

        if (authInfo != null) {
            return mypageService.getMemberInfo(String.valueOf(authInfo.getMember_id()));
        } else {
            return null;
        }
    }
}
