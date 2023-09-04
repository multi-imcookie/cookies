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
        return sqlSession.selectList("adminReply.getAllReplies", params);
    }

    public int getTotalReplies() {
        return sqlSession.selectOne("adminReply.getTotalReplies");
    }

    public List<AdminReplyDTO> searchReplies(Map<String, String> params) {
        return sqlSession.selectList("adminReply.searchReplies", params);
    }

    public AdminReplyDTO getReplyById(int id) {
        return sqlSession.selectOne("adminReply.getReplyById", id);
    }

    public void updateReply(int id, AdminReplyDTO reply) {
        reply.setReply_id(id);
        sqlSession.update("adminReply.updateReply", reply);
    }

    public void deleteReply(int id) {
        sqlSession.delete("adminReply.deleteReply", id);
    }
}

