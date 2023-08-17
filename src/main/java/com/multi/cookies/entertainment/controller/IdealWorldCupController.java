package com.multi.cookies.entertainment.controller;

import com.multi.cookies.entertainment.dao.IdealWorldCupDAO;
import com.multi.cookies.entertainment.dto.IdealWorldCupDTO;
import com.multi.cookies.entertainment.vo.PageVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;

@Controller
public class IdealWorldCupController {

    @Autowired
    IdealWorldCupDAO idealWorldCupDAO;

    @RequestMapping("/entertainment/idealWorldCupList")
    public void list2(PageVO vo, Model model){
        vo.setStartEnd(vo.getPage());
        List<IdealWorldCupDTO> list = idealWorldCupDAO.list2(vo);
        model.addAttribute("list", list);
    }
    @RequestMapping("/entertainment/idealWorldCupAll")
    public void all2(PageVO vo, Model model) {
        vo.setStartEnd(vo.getPage());
        List<IdealWorldCupDTO> list = idealWorldCupDAO.all(vo);
        int count = idealWorldCupDAO.count();
        int pages = count / 10 + 1; //전체 페이지 개수 구하기
        model.addAttribute("list", list);
        model.addAttribute("count", count);
        model.addAttribute("pages", pages);
    }

}
