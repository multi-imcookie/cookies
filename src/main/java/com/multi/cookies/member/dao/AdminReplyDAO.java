package com.multi.cookies.member.dao;

import com.multi.cookies.member.dto.AdminReplyDTO;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import java.util.Map;
import java.util.HashMap;
import java.util.List;

@Repository
public class AdminReplyDAO {
    @Autowired
    SqlSession sqlSession;

    public List<AdminReplyDTO> getAllReplies(int start, int pageSize) {
        Map<String, Object> params = new HashMap<>();
        params.put("start", start);
        params.put("pageSize", pageSize);
        return sqlSession.selectList("getAllReplies", params);
    }

    public int getTotalReplies() {
        return sqlSession.selectOne("getTotalReplies");
    }

    public List<AdminReplyDTO> searchReplies(Map<String, String> params) {
        return sqlSession.selectList("searchReplies", params);
    }

    public AdminReplyDTO getReplyById(int id) {
        return sqlSession.selectOne("getReplyById", id);
    }

    public void updateReply(int id, AdminReplyDTO reply) {
        reply.setReply_id(id);
        sqlSession.update("updateReply", reply);
    }

    public void deleteReply(int id) {
        sqlSession.delete("deleteReply", id);
    }
}

