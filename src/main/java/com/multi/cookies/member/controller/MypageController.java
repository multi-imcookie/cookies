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
    public String mypage(HttpSession session, Model model) {
        String memberId = (String) session.getAttribute("memberId");
        if (memberId != null) {
            MypageDTO mypageDTO = mypageService.getMemberInfo(Integer.parseInt(memberId));
            if (mypageDTO != null) {
                model.addAttribute("userInfo", mypageDTO);
                return "member/mypage";
            }
        }
        return "redirect:/login"; // 로그인 정보가 없으면 로그인 페이지로 이동
    }
}
