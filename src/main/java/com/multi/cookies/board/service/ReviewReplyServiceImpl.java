package com.multi.cookies.board.service;

import com.multi.cookies.board.dao.ReplyDAO;
import com.multi.cookies.board.dao.ReviewReplyDAO;
import com.multi.cookies.board.dto.ReplyDTO;
import com.multi.cookies.board.dto.ReviewReplyDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.inject.Inject;
import java.util.List;

@Service
public class ReviewReplyServiceImpl implements ReviewReplyService {

    @Autowired
    ReviewReplyDAO reviewReplydao;


    @Override
    public List<ReviewReplyDTO> getReplyList(int review_id) throws Exception {
        return reviewReplydao.getReplyList(review_id);
    }

    @Override
    public int saveReply(ReviewReplyDTO reviewReplyDTO) throws Exception {
        return reviewReplydao.saveReply(reviewReplyDTO);
    }

    @Override
    public int updateReply(ReviewReplyDTO reviewReplyDTO) throws Exception {
        return reviewReplydao.updateReply(reviewReplyDTO);
    }

    @Override
    public int deleteReply(int reply_id) throws Exception {
        return reviewReplydao.deleteReply(reply_id);
    }


}

