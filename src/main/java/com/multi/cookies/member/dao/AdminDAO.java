package com.multi.cookies.member.dao;

import com.multi.cookies.member.dto.AdminDTO;
import com.multi.cookies.member.dto.MemberDTO;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.HashMap;
import java.util.List;
import java.util.Map;


@Repository
public class AdminDAO {
    @Autowired
    SqlSession sqlSession;

    // 모든 회원 정보 가져오기
    // 페이징을 위한 회원 정보 가져오기
    public List<AdminDTO> getAllMembers(int start, int pageSize) {
        Map<String, Object> params = new HashMap<>();
        params.put("start", start);
        params.put("pageSize", pageSize);
        return sqlSession.selectList("member.getAllMembers", params);
    }

    // 총 회원 수 가져오기
    public int getTotalMembers() {
        return sqlSession.selectOne("member.getTotalMembers");
    }
    // 검색 기능 추가
    public List<AdminDTO> searchMembers(Map<String, String> params) {
        return sqlSession.selectList("searchMembers", params);
    }


    // 특정 회원 정보 가져오기
    public AdminDTO getMemberById(int id) {
        return sqlSession.selectOne("getMemberById", id);
    }

    // 회원 정보 수정
    public void updateMember(int id, AdminDTO member) {
        member.setMember_id(id);
        sqlSession.update("updateMember", member);
    }

    // 회원 생성
    public void createMember(MemberDTO member) {
        sqlSession.insert("createMember", member);
    }

    // 회원 삭제
    public void deleteMember(int id) {
        sqlSession.delete("deleteMember", id);
    }

}
