package com.multi.cookies.member.dao;

import com.multi.cookies.member.dto.LoginDTO;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.HashMap;
import java.util.Map;

@Repository
public class LoginDAO {
    @Autowired
    SqlSession sqlSession;
    public LoginDTO findIdByUsername(String id,String findNullFieldInId){
        return sqlSession.selectOne("login."+findNullFieldInId,id);
    }
    public LoginDTO findIdByLoginKey(String findNullFieldInId,LoginDTO loginDTO){
        return sqlSession.selectOne("login."+findNullFieldInId,loginDTO);
    }

    public int insert(LoginDTO loginDTO){
        return sqlSession.insert("login.insert",loginDTO);
    }

    public int cookieInsert(String id,String password){
        Map<String,Object> paramMap = new HashMap<>();
        paramMap.put("id",id);
        paramMap.put("password",password);
        return sqlSession.insert("cookie_insert",paramMap);
    }
    public int cookieSelect(Map<String,String> map){
        return sqlSession.selectOne("cookie_select",map);
    }

    public LoginDTO cookieOne(Map<String, String> map) {
        return sqlSession.selectOne("cookie_one",map);
    }
}
