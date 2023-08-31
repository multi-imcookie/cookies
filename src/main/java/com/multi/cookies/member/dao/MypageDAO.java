package com.multi.cookies.member.dao;

import com.multi.cookies.board.dto.BoardDTO;
import com.multi.cookies.board.dto.ReviewDTO;
import com.multi.cookies.member.dto.MypageDTO;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

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

}
