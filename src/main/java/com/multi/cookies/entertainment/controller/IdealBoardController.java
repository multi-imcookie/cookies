package com.multi.cookies.entertainment.controller;

import com.multi.cookies.entertainment.dao.IdealBoardDAO;
import com.multi.cookies.entertainment.dto.IdealBoardDTO;
import com.multi.cookies.entertainment.dto.PageDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Controller
public class IdealBoardController {

    @Autowired
    IdealBoardDAO idealBoardDAO;

    @RequestMapping("/entertainment/idealBoardList")
    public void list2(PageDTO pageDTO, Model model){
        pageDTO.setStartEnd(pageDTO.getPage());
        List<IdealBoardDTO> list = idealBoardDAO.list2(pageDTO);
        model.addAttribute("list", list);
    }
    @RequestMapping("/entertainment/idealBoardAll")
    public void all2(PageDTO pageDTO, Model model) {
        pageDTO.setStartEnd(pageDTO.getPage());
        List<IdealBoardDTO> list = idealBoardDAO.all(pageDTO);
        int count = idealBoardDAO.count();
        int pages=0;
        if(count%10==0) {
            pages = count / 10 ; //전체 페이지 개수 구하기
        }
        else{
            pages = count / 10 + 1; //전체 페이지 개수 구하기
        }
        model.addAttribute("list", list);
        model.addAttribute("count", count);
        model.addAttribute("pages", pages);
    }
    @RequestMapping("/entertainment/idealBoardInsert")
    @ResponseBody
    public int insert(IdealBoardDTO idealBoardDTO) {
        int result = idealBoardDAO.insert(idealBoardDTO);
        return result;
    }
    @RequestMapping("/entertainment/idealBoardDelete")
    @ResponseBody
    public int delete(IdealBoardDTO idealBoardDTO, Model model) {
        int result = idealBoardDAO.delete(idealBoardDTO);
        return result;
    }
}
