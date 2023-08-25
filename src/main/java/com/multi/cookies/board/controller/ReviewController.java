package com.multi.cookies.board.controller;

import com.multi.cookies.board.dto.Page;
import com.multi.cookies.board.dto.ReplyDTO;
import com.multi.cookies.board.dto.ReviewDTO;
import com.multi.cookies.board.service.ReplyService;
import com.multi.cookies.board.service.ReviewService;
import com.multi.cookies.snack.service.SnackService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;


@Controller
@RequestMapping("review")
public class ReviewController {

    private static final Logger logger = LoggerFactory.getLogger(ReviewController.class);

    @Autowired
    SnackService snackService;
    @Autowired
    ReviewService reviewService;
    @Autowired
    ReplyService replyService;


    //작성화면
    @RequestMapping(value = "reviewWrite", method = RequestMethod.GET)
    public String write() {
        return "review/reviewWrite";
    }

    //작성
    @RequestMapping(value = "reviewWrite", method = RequestMethod.POST)
    public String write(@ModelAttribute ReviewDTO reviewDTO) throws Exception {
        reviewService.write(reviewDTO);
        return "redirect:reviewList?num=1";
    }

    //조회
    @RequestMapping(value = "reviewView", method = RequestMethod.GET)
    public void read(@RequestParam("review_id") int review_id, Model model) throws Exception {
        model.addAttribute(reviewService.read(review_id));

    }

    //삭제
    @RequestMapping(value = "reviewDelete", method = RequestMethod.POST)
    public String delete(ReviewDTO reviewDTO) throws Exception {
        logger.info("delete");

        reviewService.delete(reviewDTO.getReview_id());

        return "redirect:review/reviewList?num=1";
    }


    //수정 화면
    @RequestMapping(value = "reviewUpdate", method = RequestMethod.GET)
    public String update() {
        return "review/reviewUpdate";
    }

    //수정
    @RequestMapping(value = "reviewUpdate", method = RequestMethod.POST)
    public String update(@ModelAttribute ReviewDTO reviewDTO) throws Exception {
        reviewService.update(reviewDTO);
        return "redirect:reviewList?num=1";
    }

    // 목록
    @RequestMapping(value = "reviewList", method = RequestMethod.GET)
    public void getList(Model model, @RequestParam(value = "num", required = false, defaultValue = "1") int num,
                        @RequestParam(value = "searchType", required = false, defaultValue = "title") String searchType,
                        @RequestParam(value = "keyword", required = false, defaultValue = "") String keyword) throws Exception {
        Page page = new Page();
        page.setNum(num);
        page.setCount(reviewService.count());
        int test = reviewService.count();
       // list = service.listPage(page.getDisplayPost(), page.getPostNum());
        List<ReviewDTO> list = reviewService.list(page.getDisplayPost(), page.getPostNum(), searchType, keyword);
        System.out.println(list);
        model.addAttribute("list", list);
        model.addAttribute("page", page);
        model.addAttribute("select", num);
        System.out.println("controller" + test);
    }


}

