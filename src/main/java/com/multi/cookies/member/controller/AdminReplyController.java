package com.multi.cookies.member.controller;

import com.multi.cookies.member.dto.AdminReplyDTO;
import com.multi.cookies.member.service.AdminReplyService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.ui.Model;
import java.util.Map;
import java.util.List;

@Controller
public class AdminReplyController {
    @Autowired
    private AdminReplyService adminReplyService;

    // 댓글 목록 조회
    @RequestMapping("/replies")
    public String list(@RequestParam(value = "page", defaultValue = "1") int page, Model model) {
        Map<String, Object> repliesWithPaging = adminReplyService.getReplies(page);
        model.addAttribute("repliesWithPaging", repliesWithPaging);
        return "member/replies";
    }

    // 검색 기능
    @RequestMapping("/replies/search")
    public String search(@RequestParam String type, @RequestParam String keyword, Model model) {
        List<AdminReplyDTO> replies = adminReplyService.searchReplies(type, keyword);
        model.addAttribute("replies", replies);
        return "member/searchResult";
    }

    // 댓글 수정 페이지로 이동
    @GetMapping("/reply/{id}/edit")
    public String editPage(@PathVariable int id, Model model) {
        AdminReplyDTO reply = adminReplyService.getReplyById(id);
        model.addAttribute("reply", reply);
        return "member/editReply";
    }

    // 댓글 수정
    @PostMapping("/reply/{id}/edit")
    public String editReply(@PathVariable int id, AdminReplyDTO reply) {
        adminReplyService.updateReply(id, reply);
        return "redirect:/replies";
    }

    // 댓글 삭제
    @PostMapping("/reply/{id}/delete")
    public String deleteReply(@PathVariable int id) {
        adminReplyService.deleteReply(id);
        return "redirect:/replies";
    }
}
