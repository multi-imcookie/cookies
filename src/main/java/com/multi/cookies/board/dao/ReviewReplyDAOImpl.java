package com.multi.cookies.board.dao;

import com.multi.cookies.board.dto.ReplyDTO;
import com.multi.cookies.board.dto.ReviewReplyDTO;
import org.apache.ibatis.session.SqlSession;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import javax.inject.Inject;
import java.util.List;

@Repository
public class ReviewReplyDAOImpl implements ReviewReplyDAO {

    @Autowired
    SqlSessionTemplate my;


    // 댓글 목록
    @Override
    public List<ReviewReplyDTO> getReplyList(int review_id) throws Exception {
        return my.selectList("reviewReply.getReplyList", review_id);
    }
    // 댓글 작성
    @Override
    public int saveReply(ReviewReplyDTO reviewReplyDTO) throws Exception {
        return my.insert("reviewReply.saveReply", reviewReplyDTO);
    }
    // 댓글 수정
    @Override
    public int updateReply(ReviewReplyDTO reviewReplyDTO) throws Exception {
        return my.update("reviewReply.updateReply", reviewReplyDTO);
    }
    // 댓글 삭제
    @Override
    public int deleteReply(int reply_id) throws Exception {
        return my.delete("reviewReply.deleteReply", reply_id);
    }


}
