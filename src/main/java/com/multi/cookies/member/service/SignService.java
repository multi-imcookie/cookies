package com.multi.cookies.member.service;

import com.multi.cookies.member.dao.SignDAO;
import com.multi.cookies.member.dto.MemberDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

@Service
public class SignService {
    @Autowired
    SignDAO signDAO;
    @Autowired
    JasyptEncoderService jasyptEncoderService;
    public int sign(MemberDTO memberDTO){
//        String encodePw = bCryptPasswordEncoder.encode(memberDTO.getMember_pw());
        String encodePw = jasyptEncoderService.encrypt(memberDTO.getMember_pw());
        memberDTO.setMember_pw(encodePw);
        return signDAO.sign(memberDTO);
    }

    public int checkId(String member_signId) {
        return 0;
    }
}
