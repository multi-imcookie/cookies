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
    public List<ReviewReplyDTO> list(int review_id) throws Exception {
        return reviewReplydao.list(review_id);
    }

    @Override
    public void write(ReviewReplyDTO reviewReplyDTO) throws Exception {
        reviewReplydao.write(reviewReplyDTO);
    }

    @Override
    public void modify(ReviewReplyDTO reviewReplyDTO) throws Exception {
        reviewReplydao.modify(reviewReplyDTO);
    }

    @Override
    public void delete(ReviewReplyDTO reviewReplyDTO) throws Exception {
        reviewReplydao.delete(reviewReplyDTO);
    }


    // 단일 댓글 조회
    @Override
    public ReviewReplyDTO replySelect(ReviewReplyDTO reviewReplyDTO) throws Exception {
        return reviewReplydao.replySelect(reviewReplyDTO);
    }


}

