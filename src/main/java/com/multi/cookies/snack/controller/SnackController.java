package com.multi.cookies.snack.controller;

import com.multi.cookies.snack.dto.SearchDTO;
import com.multi.cookies.snack.service.SnackService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.HandlerMapping;

import javax.servlet.http.HttpServletRequest;
import java.util.List;


@Controller
public class SnackController {

    @Autowired
    SnackService snackService;

    @RequestMapping("/snack/snackWikiSearch" ) //method = RequestMethod.GET
    public void snackSearch(HttpServletRequest request, Model model) {
        System.out.println("컨트롤러 가동!");

        String keyword = request.getParameter("keyword");
        System.out.println("입력값 확인! " + keyword);

        List<SearchDTO> searchResult = snackService.snackSearch(keyword);
        System.out.println("DB에서 가져온 값 " + searchResult);

       // String requestURI = (String)request.getAttribute(HandlerMapping.PATH_WITHIN_HANDLER_MAPPING_ATTRIBUTE);
        model.addAttribute("searchResult", searchResult);

 //       if(requestURI.equals("homeSnackSearch")){
 //           model.addAttribute("searchResult", searchResult);
 //           System.out.println("메인에서 검색!");
 //           return "snack/homeSnackSearch";
 //       } else {
 //           model.addAttribute("searchResult", searchResult);
 //           System.out.println("위키에서 검색!");
 //           return "/snack/snackWikiSearch";
 //       }

    }

    @RequestMapping("/snack/snackInfo")
    public void snackInfo(int snack_id, Model model){
        System.out.println("snack_id : " + snack_id);
        SearchDTO searchDTO = snackService.snackInfo(snack_id);
        model.addAttribute("searchDTO", searchDTO);
    }


}