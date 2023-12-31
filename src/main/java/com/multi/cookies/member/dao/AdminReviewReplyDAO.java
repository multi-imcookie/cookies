package com.multi.cookies.member.dao;

import com.multi.cookies.board.dto.ReviewReplyDTO;
import com.multi.cookies.member.dto.AdminReviewReplyDTO;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.HashMap;
import java.util.Map;

@Repository
public class AdminReviewReplyDAO {

    @Autowired
    private SqlSession sqlSession;

    public List<AdminReviewReplyDTO> getAllReviewReplies(int start, int pageSize) {
        Map<String, Object> params = new HashMap<>();
        params.put("start", start);
        params.put("pageSize", pageSize);
        return sqlSession.selectList("adminReviewReply.getAllReviewReplies", params);
    }

    // 검색된 리뷰 댓글 조회
    public List<AdminReviewReplyDTO> searchReviewReplies(String query) {
        return sqlSession.selectList("adminReviewReply.searchReviewReplies", query);
    }

    // 리뷰 댓글 상세 조회
    public AdminReviewReplyDTO getReviewReplyDetail(Long reply_id) {
        return sqlSession.selectOne("adminReviewReply.getReviewReplyDetail", reply_id);
    }

    // 리뷰 댓글 수정
    public void updateReviewReply(Long reply_id, String reply_content) {
        Map<String, Object> params = new HashMap<>();
        params.put("reply_id", reply_id);
        params.put("reply_content", reply_content);
        sqlSession.update("adminReviewReply.updateReviewReply", params);
    }

    // 리뷰 댓글 삭제
    public void deleteReviewReply(Long reply_id) {
        sqlSession.delete("adminReviewReply.deleteReviewReply", reply_id);
    }

    // 리뷰 댓글의 총 수를 가져옴
    public int getTotalReviewReplies() {
        return sqlSession.selectOne("adminReviewReply.getTotalReviewReplies");
    }
}


