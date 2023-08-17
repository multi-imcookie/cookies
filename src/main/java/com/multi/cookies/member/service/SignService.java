package com.multi.cookies.member.service;

import com.multi.cookies.member.dao.SignDAO;
import com.multi.cookies.member.dto.MemberDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class SignService {
    @Autowired
    SignDAO signDAO;

    public void sign(MemberDTO memberDTO){
        signDAO.sign(memberDTO);
    }

    public int checkId(String member_signId) {
        return 0;
    }
}
