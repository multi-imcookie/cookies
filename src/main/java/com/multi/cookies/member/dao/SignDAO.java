package com.multi.cookies.member.dao;

import com.multi.cookies.member.dto.MemberDTO;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class SignDAO {

    @Autowired
    SqlSessionTemplate my;

    public int sign(MemberDTO memberDTO){
        return my.insert("member.sign", memberDTO);
    }

    public int checkId(String member_signId) {
        return my.selectOne("member.checkDuplicateId", member_signId);
    }
}
