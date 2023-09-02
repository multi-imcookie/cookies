package com.multi.cookies.member.service;

import com.multi.cookies.member.dao.AdminReviewReplyDAO;
import com.multi.cookies.member.dto.AdminReviewReplyDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class AdminReviewReplyService {

    @Autowired
    private AdminReviewReplyDAO dao;

    public Map<String, Object> getReplies(int page) {
        int pageSize = 20; // 페이지당 표시될 댓글 수
        int start = (page - 1) * pageSize;
        List<AdminReviewReplyDTO> replies = dao.getAllReplies(start, pageSize);

        int totalReplies = dao.getTotalReplies();
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

    // 검색된 리뷰 댓글 조회
    public Map<String, Object> searchReplies(String query) {
        List<AdminReviewReplyDTO> searchedReplies = dao.searchReplies(query);

        Map<String, Object> result = new HashMap<>();
        result.put("searchedReplies", searchedReplies);

        return result;
    }

    // 리뷰 댓글 상세 조회
    public AdminReviewReplyDTO getReplyDetail(Long reply_id) {
        return dao.getReplyDetail(reply_id);
    }

    // 리뷰 댓글 수정
    public void updateReply(Long reply_id, String reply_content) {
        dao.updateReply(reply_id, reply_content);
    }

    // 리뷰 댓글 삭제
    public void deleteReply(Long reply_id) {
        dao.deleteReply(reply_id);
    }
}