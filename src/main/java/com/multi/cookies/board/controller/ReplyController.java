package com.multi.cookies.board.controller;

import com.multi.cookies.board.dto.ReplyDTO;
import com.multi.cookies.board.service.ReplyService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import javax.inject.Inject;
import java.util.List;

@Controller
@RequestMapping("reply")
public class ReplyController {

    @Inject
    private ReplyService replyService;

    // 댓글 조회
    @RequestMapping(value = "list", method = RequestMethod.GET)
    public void list(@RequestParam("bbs_id") int bbs_id, Model model) throws Exception {
        List<ReplyDTO> replyList = replyService.list(bbs_id);
        model.addAttribute("replyList", replyList);
    }

    // 댓글 작성
    @RequestMapping(value = "write", method = RequestMethod.POST)
    public String postWrite(@ModelAttribute ReplyDTO dto ) throws Exception {

        replyService.write(dto);

        return "redirect:/board/view?bbs_id=" + dto.getBbs_id();
    }


    // 댓글 단일 조회 (수정 페이지)
    @RequestMapping(value = "update", method = RequestMethod.GET)
    public void Update(@RequestParam("bbs_id") int bbs_id, @RequestParam("reply_id") int reply_id, Model model) throws Exception {

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
    @RequestMapping(value = "delete", method = RequestMethod.GET)
    public String Delete(@RequestParam("bbs_id") int bbs_id, @RequestParam("reply_id") int reply_id) throws Exception {
        ReplyDTO dto = new ReplyDTO();

        dto.setBbs_id(bbs_id);
        dto.setReply_id(reply_id);

        replyService.delete(dto);

        return "redirect:/board/view?bbs_id=" + bbs_id;

    }
}