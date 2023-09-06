package com.multi.cookies.member.service;

import com.multi.cookies.member.dao.AdminReviewDAO;
import com.multi.cookies.member.dto.AdminDTO;
import com.multi.cookies.member.dto.AdminReviewDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class AdminReviewService {

    @Autowired
    private AdminReviewDAO adminReviewDAO;

    public Map<String, Object> getReviews(int page) {
        int pageSize = 20;
        int start = (page - 1) * pageSize;
        List<AdminReviewDTO> reviews = adminReviewDAO.getAllReviews(start, pageSize);

        int totalReviews = adminReviewDAO.getTotalReviews();
        int totalPages = (int) Math.ceil((double) totalReviews / pageSize);

        int startPage = ((page - 1) / 10) * 10 + 1;
        int endPage = Math.min(startPage + 9, totalPages);

        Map<String, Object> result = new HashMap<>();
        result.put("reviews", reviews);
        result.put("currentPage", page);
        result.put("totalPages", totalPages);
        result.put("startPage", startPage);
        result.put("endPage", endPage);

        return result;
    }

    public List<AdminReviewDTO> searchReviews(String type, String keyword) {
        Map<String, String> params = new HashMap<>();
        params.put("type", type);
        params.put("keyword", keyword);
        return adminReviewDAO.searchReviews(params);
    }

    public AdminReviewDTO getReviewById(int id) {
        return adminReviewDAO.getReviewById(id);
    }
    public void updateReview(int id, AdminReviewDTO review) {
        adminReviewDAO.updateReview(id, review);
    }

    public void deleteReview(int id) {
        adminReviewDAO.deleteReview(id);
    }
}

