package com.multi.cookies.member.controller;

import com.multi.cookies.member.dto.AdminReviewReplyDTO;
import com.multi.cookies.member.service.AdminReviewReplyService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;


import java.util.Map;

@Controller
public class AdminReviewReplyController {

    @Autowired
    private AdminReviewReplyService service;

    // 리뷰 댓글 목록 조회
    @RequestMapping("/review/replies")
    public String list(@RequestParam(value = "page", defaultValue = "1") int page, Model model) {
        Map<String, Object> repliesWithPaging = service.getReviewReplies(page);
        model.addAttribute("repliesWithPaging", repliesWithPaging);
        return "member/reviewReplies";
    }

    // 리뷰 댓글 검색
    @RequestMapping("/review/replies/search")
    public String search(@RequestParam(value = "query") String query, Model model) {
        Map<String, Object> searchedReplies = service.searchReviewReplies(query);
        model.addAttribute("searchedReplies", searchedReplies);
        return "member/reviewReplies";
    }

    // 리뷰 댓글 상세 조회
    @GetMapping("/review/replies/{reply_id}")
    public String detail(@PathVariable Long reply_id, Model model) {
        AdminReviewReplyDTO replyDetail = service.getReviewReplyDetail(reply_id);
        model.addAttribute("replyDetail", replyDetail);
        return "member/viewReviewReply";
    }

    // 리뷰 댓글 수정 페이지로 이동
    @GetMapping("/review/replies/{reply_id}/edit")
    public String editForm(@PathVariable Long reply_id, Model model) {
        AdminReviewReplyDTO replyDetail = service.getReviewReplyDetail(reply_id);
        model.addAttribute("replyDetail", replyDetail);
        return "review/editReviewReply";
    }


    // 리뷰 댓글 수정 처리
    @PostMapping("/review/replies/{reply_id}/edit")
    public String update(@PathVariable Long reply_id, @RequestParam String reply_content) {
        service.updateReviewReply(reply_id, reply_content);
        return "redirect:/review/replies/";
    }

    // 리뷰 댓글 삭제
    @PostMapping("/review/replies/{reply_id}/delete")
    public String delete(@PathVariable Long reply_id) {
        service.deleteReviewReply(reply_id);
        return "redirect:/review/replies";
    }
}


