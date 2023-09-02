package com.multi.cookies.member.dao;

import com.multi.cookies.board.dto.ReviewDTO;
import com.multi.cookies.member.dto.AdminReviewDTO;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.HashMap;
import java.util.List;
import java.util.Map;


@Repository
public class AdminReviewDAO {
    @Autowired
    SqlSession sqlSession;

    // 페이징을 위한 리뷰 정보 가져오기
    public List<AdminReviewDTO> getAllReviews(int start, int pageSize) {
        Map<String, Object> params = new HashMap<>();
        params.put("start", start);
        params.put("pageSize", pageSize);
        return sqlSession.selectList("getAllReviews", params);
    }

    // 총 리뷰 수 가져오기
    public int getTotalReviews() {
        return sqlSession.selectOne("getTotalReviews");
    }

    // 리뷰 검색 기능
    public List<AdminReviewDTO> searchReviews(Map<String, String> params) {
        return sqlSession.selectList("searchReviews", params);
    }

    // 특정 리뷰 정보 가져오기
    public AdminReviewDTO getReviewById(int id) {
        return sqlSession.selectOne("getReviewById", id);
    }

    // 리뷰 정보 수정
    public void updateReview(int id, AdminReviewDTO review) {
        review.setReview_id(id);
        sqlSession.update("updateReview", review);
    }

    // 리뷰 생성
    public void createReview(ReviewDTO review) {
        sqlSession.insert("createReview", review);
    }

    // 리뷰 삭제
    public void deleteReview(int id) {
        sqlSession.delete("deleteReview", id);
    }
}
