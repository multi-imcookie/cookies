package com.multi.cookies.board.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.multi.cookies.board.dao.ReplyDAO;
import com.multi.cookies.board.dto.ReplyDTO;

@Service
public class ReplyServiceImpl implements ReplyService {

    @Inject
    private ReplyDAO dao;

    // 댓글 조회
    @Override
    public List<ReplyDTO> list(int bbs_id) throws Exception {
        return dao.list(bbs_id);
    }

    // 댓글 작성
    @Override
    public void write(ReplyDTO dto) throws Exception {
        dao.write(dto);
    }

    // 댓글 수정
    @Override
    public void update(ReplyDTO dto) throws Exception {
        dao.update(dto);
    }

    // 댓글 삭재
    @Override
    public void delete(ReplyDTO dto) throws Exception {
        dao.delete(dto);
    }


    // 단일 댓글 조회
    @Override
    public ReplyDTO replySelect(ReplyDTO dto) throws Exception {
        return dao.replySelect(dto);
    }

}
