package com.multi.cookies.member.controller;

import com.multi.cookies.member.dao.SignDAO;
import com.multi.cookies.member.dto.MemberDTO;
import com.multi.cookies.member.service.SignService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("member")
public class SignController {

    @Autowired
    SignDAO signDAO;

    // 회원가입 로직
    @RequestMapping("sign")
    @ResponseBody
    public int sign(MemberDTO memberDTO) {
        return signDAO.sign(memberDTO);
    }

    // 아이디 중복 여부 확인 로직
    @RequestMapping("checkId")
    @ResponseBody
    public int checkId(String member_signId) {
        return signDAO.checkId(member_signId);
    }
}
