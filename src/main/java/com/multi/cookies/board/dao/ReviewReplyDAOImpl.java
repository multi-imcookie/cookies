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


    @Override
    public List<ReviewReplyDTO> list(int review_id) throws Exception {
        return my.selectList("reviewReply.replyList", review_id);
    }

    @Override
    public void write(ReviewReplyDTO reviewReplyDTO) throws Exception {
        my.insert("reviewReply.replyWrite", reviewReplyDTO);
    }

    @Override
    public void modify(ReviewReplyDTO reviewReplyDTO) throws Exception {
        my.update("reviewReply.replyModify", reviewReplyDTO);
    }

    @Override
    public void delete(ReviewReplyDTO reviewReplyDTO) throws Exception {
        my.delete("reviewReply.replyDelete", reviewReplyDTO);
    }

    // 단일 댓글 조회
    @Override
    public ReviewReplyDTO replySelect(ReviewReplyDTO reviewReplyDTO) throws Exception {

        return my.selectOne("reviewReply.replySelect", reviewReplyDTO);
    }


}
