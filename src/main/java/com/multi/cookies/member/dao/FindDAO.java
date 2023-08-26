package com.multi.cookies.member.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.Map;

@Repository
public class FindDAO {
    @Autowired
    SqlSession sqlSession;

    public String findIdByNameAndPhoneNumber(Map<String,Object> map){
//        System.out.println("map = " + map);
        return sqlSession.selectOne("find.signId",map);
    }
    public int findPassWordByNameAndIdAndPhoneNumber(Map<String, Object> map){
        return sqlSession.update("find.update_password",map);
    }
}
