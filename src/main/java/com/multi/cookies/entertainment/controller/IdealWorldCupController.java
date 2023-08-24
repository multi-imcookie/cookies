package com.multi.cookies.entertainment.controller;

import com.multi.cookies.entertainment.dao.IdealWorldCupDAO;
import com.multi.cookies.entertainment.dto.IdealWorldCupDTO;
import com.multi.cookies.entertainment.dto.InitialSnackListDTO;
import com.multi.cookies.entertainment.dto.PageDTO;
import com.multi.cookies.entertainment.service.IdealWorldCupService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.ArrayList;
import java.util.List;

@Controller
public class IdealWorldCupController {

    @Autowired
    IdealWorldCupDAO idealWorldCupDAO;
    @Autowired
    private IdealWorldCupService idealWorldCupService;

    @RequestMapping("/entertainment/idealWorldCupList")
    public void list2(PageDTO pageDTO, Model model) {
        pageDTO.setStartEnd(pageDTO.getPage());
        List<IdealWorldCupDTO> list = idealWorldCupDAO.list2(pageDTO);
        model.addAttribute("list", list);
    }

    @RequestMapping("/entertainment/idealWorldCupAll")
    public void all2(PageDTO pageDTO, Model model) {
        pageDTO.setStartEnd(pageDTO.getPage());
        List<IdealWorldCupDTO> list = idealWorldCupDAO.all(pageDTO);
        int count = idealWorldCupDAO.count();
        int pages = count / 10 + 1; //전체 페이지 개수 구하기
        model.addAttribute("list", list);
        model.addAttribute("count", count);
        model.addAttribute("pages", pages);
    }

    @RequestMapping("/updateWinnerWins")
    @ResponseBody
    public String updateWinnerWins(@RequestParam("snack_id") int snack_id) {
        try {
            // snackId를 기반으로 DB 업데이트 수행
            idealWorldCupDAO.updateWins(snack_id);
            return "Success"; // 성공 시 메시지 반환
        } catch (Exception e) {
            e.printStackTrace();
            return "Error"; // 실패 시 메시지 반환
        }
    }
    @RequestMapping("/entertainment/idealWorldCupGame")
    public void randomSnacks(@RequestParam("kang") int kang, Model model) {
        List<InitialSnackListDTO> randomSnacks = idealWorldCupService.getRandomSnacks(kang);
        model.addAttribute("randomSnacks", randomSnacks);
    }
}