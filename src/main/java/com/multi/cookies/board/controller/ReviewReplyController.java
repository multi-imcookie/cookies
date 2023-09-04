package com.multi.cookies.board.controller;

import com.multi.cookies.board.dto.ReplyDTO;
import com.multi.cookies.board.dto.ReviewReplyDTO;
import com.multi.cookies.board.service.ReviewReplyService;
import com.multi.cookies.board.service.ReviewService;
import org.json.simple.parser.ParseException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.annotation.Lazy;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


@RestController
@RequestMapping("reviewReply")
public class ReviewReplyController {

    private static final Logger logger = LoggerFactory.getLogger(BoardController.class);

    @Autowired
    ReviewReplyService reviewReplyService;


    @RequestMapping(value = "getReplyList", method = RequestMethod.POST)
    public List<ReviewReplyDTO> getReplyList(@RequestParam("review_id") int review_id) throws Exception {
        return reviewReplyService.getReplyList(review_id);
    }

    @RequestMapping("saveReply")
    public void saveReply(@ModelAttribute ReviewReplyDTO reviewReplyDTO, Model model) throws Exception {
        if (reviewReplyDTO.getReply_content() != null && !reviewReplyDTO.getReply_content().isEmpty()) {
            int result = reviewReplyService.saveReply(reviewReplyDTO);
            model.addAttribute("result", result);
        } else {
            model.addAttribute("result", "EmptyReplyContent");
        }
    }

    @RequestMapping(value = "updateReply", method = RequestMethod.POST)
    public Map<String, Object> updateReply(@RequestBody ReviewReplyDTO reviewReplyDTO) throws Exception {
        Map<String, Object> result = new HashMap<>();
        try {
            reviewReplyService.updateReply(reviewReplyDTO);
            result.put("status", "OK");
        } catch (Exception e) {
            e.printStackTrace();
            result.put("status", "False");
        }
        return result;
    }
    @RequestMapping(value = "deleteReply", method = RequestMethod.POST)
    public Map<String, Object> deleteReply(@RequestParam("reply_id") int reply_id) throws Exception {
        Map<String, Object> result = new HashMap<>();
        try {
            reviewReplyService.deleteReply(reply_id);
            result.put("status", "OK");
        } catch (Exception e) {
            e.printStackTrace();
            result.put("status", "False");
            result.put("error", e.getMessage()); // 예외 메시지를 전달
        }
        return result;
    }
}


