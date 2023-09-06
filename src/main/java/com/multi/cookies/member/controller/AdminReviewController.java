package com.multi.cookies.member.controller;

import com.multi.cookies.member.dto.AdminReviewDTO;
import com.multi.cookies.member.service.AdminReviewService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;


@Controller
public class AdminReviewController {
    @Autowired
    private AdminReviewService adminReviewService;

    // 리뷰 목록 조회
    @RequestMapping("/reviews")
    public String list(@RequestParam(value = "page", defaultValue = "1") int page, Model model) {
        Map<String, Object> reviewsWithPaging = adminReviewService.getReviews(page);
        model.addAttribute("reviewsWithPaging", reviewsWithPaging);
        return "member/reviews";
    }

    // 리뷰 검색
    @RequestMapping("/reviews/search")
    public String search(@RequestParam String type, @RequestParam String keyword, Model model) {
        List<AdminReviewDTO> reviews = adminReviewService.searchReviews(type, keyword);
        Map<String, Object> reviewsWithPaging = new HashMap<>();
        reviewsWithPaging.put("reviews", reviews);
        model.addAttribute("reviewsWithPaging", reviewsWithPaging);
        return "member/reviews";
    }

    // 리뷰 상세 조회
    @RequestMapping("/reviews/{id}")
    public String view(@PathVariable int id, Model model) {
        AdminReviewDTO review = adminReviewService.getReviewById(id);
        model.addAttribute("review", review);
        return "member/viewReview";
    }

    // 리뷰 수정 페이지로 이동
    @RequestMapping("/reviews/{id}/edit")
    public String edit(@PathVariable int id, Model model) {
        AdminReviewDTO review = adminReviewService.getReviewById(id);
        model.addAttribute("review", review);
        return "member/editReview";
    }

    // 리뷰 수정 처리
    @PostMapping("/reviews/{id}/update")
    public String update(@PathVariable int id, AdminReviewDTO review) {
        adminReviewService.updateReview(id, review);
        return "redirect:/reviews";
    }

    // 리뷰 삭제 처리
    @GetMapping("/reviews/{id}/delete")
    public String delete(@PathVariable int id) {
        adminReviewService.deleteReview(id);
        return "redirect:/reviews";
    }
}

