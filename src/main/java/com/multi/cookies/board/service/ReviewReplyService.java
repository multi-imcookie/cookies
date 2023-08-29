package com.multi.cookies.board.service;

import com.multi.cookies.board.dto.ReplyDTO;
import com.multi.cookies.board.dto.ReviewReplyDTO;

import java.util.List;

public interface ReviewReplyService {

    // 댓글 목록
    public List<ReviewReplyDTO> listReply(int review_id) throws Exception;

    // 댓글 작성
    public void writeReply(ReviewReplyDTO reviewReplyDTO) throws Exception;

    // 댓글 수정
    public void updateReply(ReviewReplyDTO reviewReplyDTO) throws Exception;

    // 댓글 삭제
    public void deleteReply(ReviewReplyDTO reviewReplyDTO) throws Exception;

}