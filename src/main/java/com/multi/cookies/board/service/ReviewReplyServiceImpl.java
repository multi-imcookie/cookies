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

    // 댓글 목록
    @Override
    public List<ReviewReplyDTO> listReply(int review_id) throws Exception {
        return reviewReplydao.listReply(review_id);
    }

    // 댓글 작성
    @Override
    public void writeReply(ReviewReplyDTO reviewReplyDTO) throws Exception {
        reviewReplydao.writeReply(reviewReplyDTO);
    }

    // 댓글 수정
    @Override
    public void updateReply(ReviewReplyDTO reviewReplyDTO) throws Exception {
        reviewReplydao.updateReply(reviewReplyDTO);
    }

    // 댓글 삭재
    @Override
    public void deleteReply(ReviewReplyDTO reviewReplyDTO) throws Exception {
        reviewReplydao.deleteReply(reviewReplyDTO);
    }


}

