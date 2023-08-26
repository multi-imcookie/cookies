package com.multi.cookies.board.service;

import com.multi.cookies.board.dto.ReplyDTO;

import java.util.List;

public interface ReplyService {

    // 댓글 조회
    public List<ReplyDTO> list(int bbs_id) throws Exception;

    // 댓글 작성
    public void write(ReplyDTO dto) throws Exception;

    // 댓글 수정
    public void update(ReplyDTO dto) throws Exception;

    // 댓글 삭제
    public void delete(ReplyDTO dto) throws Exception;


    // 단일 댓글 조회
    public ReplyDTO replySelect(ReplyDTO dto) throws Exception;
}
