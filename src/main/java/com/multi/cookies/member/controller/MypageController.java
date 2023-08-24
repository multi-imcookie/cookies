package com.multi.cookies.member.controller;

import com.multi.cookies.member.dto.MemberDTO;
import com.multi.cookies.member.dto.MypageDTO;
import com.multi.cookies.member.service.LoginService;
import com.multi.cookies.member.service.MypageService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;

@Controller
public class MypageController {
    @Autowired
    MypageService mypageService;

    @RequestMapping("getMemberInfo")
    @ResponseBody
    public MypageDTO getMemberInfo(@RequestParam String member_signID) {
        return mypageService.getMemberInfo(member_signID);
    }

    @RequestMapping("/mypage")
    public String mypage(HttpSession session, Model model) {
        MemberDTO loggedInUser = (MemberDTO) session.getAttribute("loggedInUser");

        if (loggedInUser != null) {
            MypageDTO mypageDTO = mypageService.getMemberInfo(loggedInUser.getMember_signId());
            model.addAttribute("mypageDTO", mypageDTO);
            return "mypage";
        } else {
            return "redirect:/login"; // 로그인 페이지로 이동
        }
    }
}
