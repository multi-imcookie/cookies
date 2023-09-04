package com.multi.cookies.board.service;

import com.multi.cookies.board.dto.ReplyDTO;
import com.multi.cookies.board.dto.ReviewReplyDTO;

import java.util.List;

public interface ReviewReplyService {


    public List<ReviewReplyDTO> getReplyList(int review_id) throws Exception;

    public int saveReply(ReviewReplyDTO reviewReplyDTO) throws Exception;

    public int updateReply(ReviewReplyDTO reviewReplyDTO) throws Exception;

    public int deleteReply(int reply_id) throws Exception;

}