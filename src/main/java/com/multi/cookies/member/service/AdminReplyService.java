package com.multi.cookies.member.service;

import com.multi.cookies.member.dao.AdminReplyDAO;
import com.multi.cookies.member.dto.AdminReplyDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.Map;
import java.util.HashMap;
import java.util.List;

@Service
public class AdminReplyService {
    @Autowired
    private AdminReplyDAO adminReplyDao;

    public Map<String, Object> getReplies(int page) {
        int pageSize = 20; // 페이지당 표시될 댓글 수
        int start = (page - 1) * pageSize;
        List<AdminReplyDTO> replies = adminReplyDao.getAllReplies(start, pageSize);

        int totalReplies = adminReplyDao.getTotalReplies();
        int totalPages = (int) Math.ceil((double) totalReplies / pageSize);

        int startPage = ((page - 1) / 10) * 10 + 1;
        int endPage = Math.min(startPage + 9, totalPages);

        Map<String, Object> result = new HashMap<>();
        result.put("replies", replies);
        result.put("currentPage", page);
        result.put("totalPages", totalPages);
        result.put("startPage", startPage);
        result.put("endPage", endPage);

        return result;
    }

    public List<AdminReplyDTO> searchReplies(String type, String keyword) {
        Map<String, String> params = new HashMap<>();
        params.put("type", type);
        params.put("keyword", keyword);
        return adminReplyDao.searchReplies(params);
    }

    public AdminReplyDTO getReplyById(int id) {
        return adminReplyDao.getReplyById(id);
    }

    public void updateReply(int id, AdminReplyDTO reply) {
        adminReplyDao.updateReply(id, reply);
    }

    public void deleteReply(int id) {
        adminReplyDao.deleteReply(id);
    }
}

