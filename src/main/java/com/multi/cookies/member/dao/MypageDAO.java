package com.multi.cookies.member.dao;

import com.multi.cookies.member.dto.MemberDTO;
import com.multi.cookies.member.dto.MypageDTO;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class MypageDAO {
    @Autowired
    SqlSessionTemplate my;

    public MypageDTO getMemberInfo(int member_id) {
        return my.selectOne("member.getMemberInfo", member_id);
    }
}
