package com.multi.cookies.member.controller;

import com.multi.cookies.member.dto.MemberDTO;
import com.multi.cookies.member.dto.MypageDTO;
import com.multi.cookies.member.service.MypageService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

@Controller
public class MypageController {
    @Autowired
    MypageService mypageService;

    @GetMapping("/mypage")
    public String mypage(HttpSession httpSession, Model model) {
        Integer memberId = (Integer) httpSession.getAttribute("memberId");
        System.out.println("member_id = " + memberId);

        if (memberId == null) {
            // 세션에 회원 번호가 없으면 로그인 페이지로 이동
            return "member/login";
        } else {
            // 세션에 회원 번호가 있으면 회원 정보를 가져와서 마이페이지로 이동
            MypageDTO memberDTO = mypageService.getMemberInfo(memberId);
            model.addAttribute("memberDTO", memberDTO);

            // 연령대 변환 로직
            String memberAge = mypageService.replaceMemberAge(memberDTO.getMember_age());
            model.addAttribute("memberAge", memberAge);

            return "member/mypage";
        }
    }
}
