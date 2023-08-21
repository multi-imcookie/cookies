package com.multi.cookies.board.controller;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.multi.cookies.board.dto.ReplyDTO;
import com.multi.cookies.board.dto.BoardDTO;
import com.multi.cookies.board.service.ReplyService;

@Controller
@RequestMapping("reply")
public class ReplyController {

    @Inject
    private ReplyService replyService;

    // 댓글 조회

    // 댓글 작성
    @RequestMapping(value = "write", method = RequestMethod.POST)
    public String postWrite(ReplyDTO dto) throws Exception {

        replyService.write(dto);

        return "redirect:/board/view?bbs_id=" + dto.getBbs_id();
    }


    // 댓글 단일 조회 (수정 페이지)
    @RequestMapping(value = "update", method = RequestMethod.GET)
    public void getUpdate(@RequestParam("bbs_id") int bbs_id, @RequestParam("reply_id") int reply_id, Model model) throws Exception {

        ReplyDTO dto = new ReplyDTO();
        dto.setBbs_id(bbs_id);
        dto.setReply_id(reply_id);

        ReplyDTO reply = replyService.replySelect(dto);

        model.addAttribute("reply", reply);
    }



    // 댓글 수정
    @RequestMapping(value = "update", method = RequestMethod.POST)
    public String postUpdate(ReplyDTO dto) throws Exception {

        replyService.update(dto);

        return "redirect:/board/view?bbs_id=" + dto.getBbs_id();
    }


    // 댓글 삭제

}