package com.multi.cookies.member.dao;

import com.multi.cookies.board.dto.ReviewReplyDTO;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class AdminReviewReplyDAO {
    @Autowired
    SqlSession sqlSession;

    public List<ReviewReplyDTO> replyList(int reviewId) {
        return sqlSession.selectList("reviewReply.replyList", reviewId);
    }

    public void replyWrite(ReviewReplyDTO reply) {
        sqlSession.insert("reviewReply.replyWrite", reply);
    }

    public void replyModify(ReviewReplyDTO reply) {
        sqlSession.update("reviewReply.replyModify", reply);
    }

    public void replyDelete(ReviewReplyDTO reply) {
        sqlSession.delete("reviewReply.replyDelete", reply);
    }
}

