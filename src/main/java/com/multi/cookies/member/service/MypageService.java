package com.multi.cookies.member.service;

import com.multi.cookies.member.dao.MypageDAO;
import com.multi.cookies.member.dto.MypageDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class MypageService {
    @Autowired
    MypageDAO mypageDAO;

    public MypageDTO getMemberInfo(int member_id) {
        return mypageDAO.getMemberInfo(member_id);
    }
}
