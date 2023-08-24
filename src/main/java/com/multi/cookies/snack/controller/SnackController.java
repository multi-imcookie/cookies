package com.multi.cookies.snack.controller;

import com.multi.cookies.snack.dto.SearchDTO;
import com.multi.cookies.snack.service.SnackService;
import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.HandlerMapping;

import javax.servlet.http.HttpServletRequest;

import java.util.List;
import java.util.Map;


@Controller
public class SnackController {

    @Autowired
    SnackService snackService;

    @RequestMapping(value = {"/snack/snackWikiSearch", "/snack/snackReviewSearch"}, method = RequestMethod.GET)
   // @RequestMapping("/snack/snackWikiSearch")
    public String snackSearch(HttpServletRequest request, @RequestParam(value = "page", defaultValue = "1") int page, Model model) {
        System.out.println("컨트롤러 가동!");
        int pageSize = 10;

        String keyword = request.getParameter("keyword");
        System.out.println("입력값 확인! " + keyword);
        if (keyword == null) {
            // keyword가 null인 경우 처리해야 할 로직을 추가합니다.
            throw new IllegalArgumentException("키워드가 null입니다.");
        }

        Map<String, Object> paginationResult = snackService.snackSearch(keyword, pageSize, page);

        List<SearchDTO> pageResults = (List<SearchDTO>) paginationResult.get("pageResults");

        String requestURI = (String)request.getAttribute(HandlerMapping.PATH_WITHIN_HANDLER_MAPPING_ATTRIBUTE);

        model.addAttribute("keyword", keyword);
        model.addAttribute("searchResults", pageResults);
        model.addAttribute("totalPages", paginationResult.get("totalPages"));
        model.addAttribute("totalResults", paginationResult.get("totalResults"));
        model.addAttribute("currentPage", paginationResult.get("currentPage"));
        model.addAttribute("startPage", paginationResult.get("startPage"));
        model.addAttribute("endPage", paginationResult.get("endPage"));

             if(requestURI.equals("/snack/snackReviewSearch")){
                 System.out.println("리뷰에서 검색!");
                 return "/snack/snackReviewSearch";
             } else {
                 System.out.println("위키에서 검색!");
                 return "/snack/snackWikiSearch";
             }
      //return "snack/snackWikiSearch";
    }

    @RequestMapping(value = {"/snack/snackWikiInfo", "snack/snackReviewSearchInfo"}, method = RequestMethod.GET)
    public void snackInfo(int snack_id, @RequestParam(required = false) String keyword, Model model) {
        System.out.println("snack_id : " + snack_id);
        SearchDTO searchDTO = snackService.snackInfo(snack_id);
        model.addAttribute("keyword", keyword);
        model.addAttribute("searchDTO", searchDTO);
    }

    @RequestMapping(value = {"/snack/snackSelectPopup"}, method = RequestMethod.GET)
    public String openSnackReviewSearch() {
        return "/snack/snackReviewSearch";
    }

}