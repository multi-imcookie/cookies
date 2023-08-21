package com.multi.cookies.board.dao;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.multi.cookies.board.dto.ReplyDTO;

@Repository
public class ReplyDAOImpl implements ReplyDAO {

    @Inject
    private SqlSession sql;

    private static String namespace = "replyDTO";

    // 댓글 조회
    @Override
    public List<ReplyDTO> list(int bbs_id) throws Exception {
        return sql.selectList(namespace + ".replyList", bbs_id);
    }

    // 댓글 작성
    @Override
    public void write(ReplyDTO dto) throws Exception {
        sql.insert(namespace + ".replyWrite", dto);
    }

    // 댓글 수정
    @Override
    public void update(ReplyDTO dto) throws Exception {
        sql.update(namespace + ".replyUpdate", dto);
    }

    // 댓글 삭제
    @Override
    public void delete(ReplyDTO dto) throws Exception {
        sql.delete(namespace + ".replyDelete", dto);
    }


    // 단일 댓글 조회
    @Override
    public ReplyDTO replySelect(ReplyDTO dto) throws Exception {

        return sql.selectOne(namespace + ".replySelect", dto);
    }

}
