package com.multi.cookies.entertainment.controller;

import com.multi.cookies.entertainment.dao.IdealBoardDAO;
import com.multi.cookies.entertainment.dto.IdealBoardDTO;
import com.multi.cookies.entertainment.vo.PageVO;
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

    @RequestMapping("idealBoardList")
    public void list2(PageVO vo, Model model){
        vo.setStartEnd(vo.getPage());
        List<IdealBoardDTO> list = idealBoardDAO.list2(vo);
        System.out.println(list);
        model.addAttribute("list", list);
    }
    @RequestMapping("idealBoardAll")
    public void all2(PageVO vo, Model model) {
        vo.setStartEnd(vo.getPage());
        List<IdealBoardDTO> list = idealBoardDAO.all(vo);
        int count = idealBoardDAO.count();
        System.out.println("all count>> " + count);
        int pages = count / 10 + 1; //전체 페이지 개수 구하기
        model.addAttribute("list", list);
        model.addAttribute("count", count);
        model.addAttribute("pages", pages);
    }
//    @RequestMapping("idealBoardInsert")
//    public void insert(IdealBoardDTO idealBoardDTO) {
//        int result = idealBoardDAO.insert(idealBoardDTO);
//        System.out.println(result);
//    }
    @RequestMapping("idealBoardInsert")
    @ResponseBody
    public int insert(IdealBoardDTO idealBoardDTO) {
        int result = idealBoardDAO.insert(idealBoardDTO);
        return result;
    }
    @RequestMapping("idealBoardDelete")
    @ResponseBody
    public int delete(IdealBoardDTO idealBoardDTO, Model model) {
        int result = idealBoardDAO.delete(idealBoardDTO);
        //model.addAttribute("result", result);
        return result;
    }

}
