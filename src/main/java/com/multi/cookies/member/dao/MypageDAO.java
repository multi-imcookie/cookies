package com.multi.cookies.member.dao;

import com.multi.cookies.board.dto.BoardDTO;
import com.multi.cookies.board.dto.ReviewDTO;
import com.multi.cookies.member.dto.MypageDTO;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Repository
public class MypageDAO {
    @Autowired
    SqlSessionTemplate my;

    // 멤버 정보 조회
    public MypageDTO getMemberInfo(int member_id) {
        return my.selectOne("member.getMemberInfo", member_id);
    }

    // 작성한 리뷰 조회
    public List<ReviewDTO> getMyReview(int member_id) {
        return my.selectList("member.getMyReview", member_id);
    }

    // 작성한 게시글 조회
    public List<BoardDTO> getMyBoard(int member_id) {
        return my.selectList("member.getMyBoard", member_id);
    }

    // 회원 정보 업데이트
    public int updateMemberInfo(MypageDTO mypageDTO) {
        return my.update("member.updateMemberInfo", mypageDTO);
    }

    //
    public String getMemberPw(int member_id) {
        return my.selectOne("member.getMemberPassword", member_id);
    }

    // 프로필 사진 불러오기
    public String getProfile(int member_id) {
        System.out.println("dao member_id = " + member_id);
        return my.selectOne("member.getProfile", member_id);
    }

    // 프로필 사진 업데이트
    public void updateProfile(Map<String, String> params) {
        my.update("member.updateProfile", params);
    }

    // 프로필 사진 삭제
    public void deleteProfile(int member_id) {
        my.delete("member.deleteProfile", member_id);
    }
}
