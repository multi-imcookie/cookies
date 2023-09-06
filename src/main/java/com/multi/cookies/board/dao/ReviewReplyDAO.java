package com.multi.cookies.board.dao;

import com.multi.cookies.board.dto.ReplyDTO;
import com.multi.cookies.board.dto.ReviewReplyDTO;

import java.util.List;

public interface ReviewReplyDAO {

    public List<ReviewReplyDTO> getReplyList(int review_id) throws Exception;

    public int saveReply(ReviewReplyDTO reviewReplyDTO) throws Exception;

    public int updateReply(ReviewReplyDTO reviewReplyDTO) throws Exception;

    public int deleteReply(int reply_id) throws Exception;

}