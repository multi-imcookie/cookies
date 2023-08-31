package com.multi.cookies.board.service;

import com.multi.cookies.board.dto.ReplyDTO;
import com.multi.cookies.board.dto.ReviewReplyDTO;

import java.util.List;

public interface ReviewReplyService {

    public List<ReviewReplyDTO> list(int review_id) throws Exception;
    public void write(ReviewReplyDTO reviewReplyDTO) throws Exception;
    public void modify(ReviewReplyDTO reviewReplyDTO) throws Exception;
    public void delete(ReviewReplyDTO reviewReplyDTO) throws Exception;

    // 단일 댓글 조회
    public ReviewReplyDTO replySelect(ReviewReplyDTO reviewReplyDTO) throws Exception;

}