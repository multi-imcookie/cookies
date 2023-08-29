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
    public List<ReviewReplyDTO> listReply(int review_id) throws Exception {
        return my.selectList("reviewReply.listReply", review_id);
    }

    // 댓글 작성
    @Override
    public void writeReply(ReviewReplyDTO reviewReplyDTO) throws Exception {
        my.insert("reviewReply.writeReply", reviewReplyDTO);
    }

    // 댓글 수정
    @Override
    public void updateReply(ReviewReplyDTO reviewReplyDTO) throws Exception {
        my.update("reviewReply.updateReply", reviewReplyDTO);
    }

    // 댓글 삭제
    @Override
    public void deleteReply(ReviewReplyDTO reviewReplyDTO) throws Exception {
        my.delete("reviewReply.deleteReply", reviewReplyDTO);
    }


}
