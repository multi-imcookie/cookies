package com.multi.cookies.snack.controller;

import com.multi.cookies.snack.dto.SearchDTO;
import com.multi.cookies.snack.service.SnackService;
import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpServletRequest;

import java.util.List;


@Controller
public class SnackController {

    @Autowired
    SnackService snackService;

    //@RequestMapping("/snack/snackWikiSearch") //method = RequestMethod.GET
    @RequestMapping("/snack/snackWikiSearch")
    public String snackSearch(HttpServletRequest request, @RequestParam(value = "page", defaultValue = "1") int page, Model model) {
        System.out.println("컨트롤러 가동!");
        int pageSize = 10;

        String keyword = request.getParameter("keyword");
        System.out.println("입력값 확인! " + keyword);
        if (keyword == null) {
            // keyword가 null인 경우 처리해야 할 로직을 추가합니다.
            throw new IllegalArgumentException("키워드가 null입니다.");
        }


        // 마이바티스 매퍼를 통해 검색 결과를 가져옵니다.
        List<SearchDTO> searchResults = snackService.snackSearch(keyword, pageSize);
        System.out.println("DB에서 가져온 값 " + searchResults);

        int totalResults = snackService.getTotalResults(keyword);
        int totalPages = (int) Math.ceil((double) totalResults / pageSize);

        // 검색된 결과에서 페이징 처리를 위한 범위를 구합니다.
        int startIndex = (page - 1) * pageSize;
        int endIndex = Math.min(startIndex + pageSize, searchResults.size());

        int startPage = page % 10 == 0 ? page - 9 : (page / 10) * 10 + 1;
        int endPage = Math.min(startPage + 9, totalPages);

        // 범위 내에 있는 검색 결과를 추출하여 리스트로 저장합니다.
        List<SearchDTO> pageResults = searchResults.subList(startIndex, endIndex);

        // String requestURI = (String)request.getAttribute(HandlerMapping.PATH_WITHIN_HANDLER_MAPPING_ATTRIBUTE);
        model.addAttribute("keyword", keyword);
        model.addAttribute("searchResults", pageResults);
        model.addAttribute("totalPages", totalPages);
        model.addAttribute("totalResults", totalResults);
        model.addAttribute("currentPage", page);
        model.addAttribute("startPage", startPage);
        model.addAttribute("endPage", endPage);

        //       if(requestURI.equals("homeSnackSearch")){
        //           model.addAttribute("searchResults", searchResults);
        //           System.out.println("메인에서 검색!");
        //           return "snack/homeSnackSearch";
        //       } else {
        //           model.addAttribute("searchResults", searchResults);
        //           System.out.println("위키에서 검색!");
        //           return "/snack/snackWikiSearch";
        //       }
        return "snack/snackWikiSearch";
    }

    @RequestMapping("/snack/snackInfo")
    public void snackInfo(int snack_id, @RequestParam(required = false) String keyword, Model model) {
        System.out.println("snack_id : " + snack_id);
        SearchDTO searchDTO = snackService.snackInfo(snack_id);
        model.addAttribute("keyword", keyword);
        model.addAttribute("searchDTO", searchDTO);
    }


}