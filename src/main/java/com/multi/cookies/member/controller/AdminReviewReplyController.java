package com.multi.cookies.member.controller;

import com.multi.cookies.board.dto.ReviewReplyDTO;
import com.multi.cookies.member.service.AdminReviewReplyService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/admin/reviewReply")
public class AdminReviewReplyController {
    @Autowired
    private AdminReviewReplyService adminReviewReplyService;

    @GetMapping("/list/{reviewId}")
    public List<ReviewReplyDTO> getReplyList(@PathVariable int reviewId) {
        return adminReviewReplyService.getReplyList(reviewId);
    }

    @PostMapping
    public void createReply(@RequestBody ReviewReplyDTO reply) {
        adminReviewReplyService.createReply(reply);
    }

    @PutMapping
    public void modifyReply(@RequestBody ReviewReplyDTO reply) {
        adminReviewReplyService.modifyReply(reply);
    }

    @DeleteMapping
    public void deleteReply(@RequestBody ReviewReplyDTO reply) {
        adminReviewReplyService.deleteReply(reply);
    }
}

