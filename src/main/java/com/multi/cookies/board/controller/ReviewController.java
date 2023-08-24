package com.multi.cookies.board.controller;

import com.multi.cookies.board.dto.ReviewDTO;
import com.multi.cookies.board.service.ReviewService;
import com.multi.cookies.snack.service.SnackService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("review")
public class ReviewController {

    @Inject
    ReviewService reviewService;

    @Autowired
    SnackService snackService;

    // 1. 게시글 목록
    @RequestMapping("list.do")
    public ModelAndView list() throws Exception{
        List<ReviewDTO> list = reviewService.listAll();
        // ModelAndView - 모델과 뷰
        ModelAndView mav = new ModelAndView();
        mav.setViewName("review/list"); // 뷰를 list.jsp로 설정
        mav.addObject("list", list); // 데이터를 저장
        return mav; // list.jsp로 List가 전달된다.
    }

    // 2. 게시글 작성화면
    @RequestMapping(value="write.do", method=RequestMethod.GET)
    public String write(){
        return "review/write"; // write.jsp로 이동
    }

    // 2. 게시글 작성처리
    @RequestMapping(value="insert.do", method=RequestMethod.POST)
    public String insert(@ModelAttribute ReviewDTO reviewDTO) throws Exception{
        reviewService.create(reviewDTO);
        return "redirect:list.do";
    }

    // 3. 게시글 상세내용 조회, 게시글 조회수 증가 처리
    // HttpSession 세션객체
    @RequestMapping(value="view.do", method=RequestMethod.GET)
    public ModelAndView view(@RequestParam int review_id) throws Exception{

        // 모델(데이터)+뷰(화면)를 함께 전달하는 객체
        ModelAndView mav = new ModelAndView();
        // 뷰의 이름
        mav.setViewName("review/view");
        // 뷰에 전달할 데이터
        mav.addObject("dto", reviewService.read(review_id));

        // 리플렉션을 이용하여 값 가져오기
        // 원래 GPT 추천은 메소드를 만들든 따로 요청하게끔 했으나, 코드 최대한 안 건들이면서 해봄.
        // 물론 이 방법도 징징거려서 추천 받은 방법인데, 성능 저하나 등등 때문에 추천하진 않는다고 했음.
        Map<String, Object> modelMap = mav.getModel();
        ReviewDTO dto = (ReviewDTO) modelMap.get("dto");
        int snackId = dto.getSnack_id();

        mav.addObject("snack", snackService.snackInfo(snackId));
        return mav;
    }

    // 4. 게시글 수정
    // 폼에서 입력한 내용들은 @ModelAttribute BoardVO vo로 전달됨
    @RequestMapping(value="update.do", method=RequestMethod.POST)
    public String update(@ModelAttribute ReviewDTO reviewDTO) throws Exception{
        reviewService.update(reviewDTO);
        return "redirect:list.do";
    }

    // 5. 게시글 삭제
    @RequestMapping("delete.do")
    public String delete(@RequestParam int review_id) throws Exception{
        reviewService.delete(review_id);
        return "redirect:list.do";
    }


/*    // 01. 게시글 목록
    @RequestMapping("list.do")
// @RequestParam(defaultValue="") ==> 기본값 할당
    public ModelAndView list(@RequestParam(defaultValue="review_title") String searchOption,
                             @RequestParam(defaultValue="") String keyword) throws Exception{
        List<ReviewDTO> list = reviewService.listAll(searchOption, keyword);
        // 레코드의 갯수
        int count = reviewService.countArticle(searchOption, keyword);
        // 모델, 뷰
        ModelAndView mav = new ModelAndView();
    *//*mav.addObject("list", list);
      mav.addObject("count", count);
      mav.addObject("searchOption", searchOption);
      mav.addObject("keyword", keyword);*//*
        // 데이터를 맵에 저장
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("list", list); // list
        map.put("count", count); // 레코드의 갯수
        map.put("searchOption", searchOption); // 검색옵션
        map.put("keyword", keyword); // 검색키워드
        mav.addObject("map", map); // 맵에 저장된 데이터를 mav에 저장
        mav.setViewName("review/list"); // 뷰를 list.jsp로 설정
        return mav; // list.jsp로 List가 전달된다.
    }*/



}

