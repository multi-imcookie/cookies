package com.multi.cookies.entertainment.controller;

import com.multi.cookies.entertainment.dao.IdealWorldCupDAO;
import com.multi.cookies.entertainment.dto.IdealWorldCupDTO;
import com.multi.cookies.entertainment.vo.PageVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

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
    @RequestMapping("/entertainment/idealWorldCupGame")
    public void list(Model model) {
        List<String> list = idealWorldCupDAO.list();
        model.addAttribute("list",list);
        //System.out.println(list);
    }

//    @RequestMapping("/getWinnerImage")
//    @ResponseBody
//    public String getWinnerImage(@RequestParam("winnerName") String winnerName) {
//        IdealWorldCupDTO winnerDTO = idealWorldCupDAO.one(winnerName);
//        if (winnerDTO != null) {
//            return winnerDTO.getIdeal_snack_img();
//        } else {
//            return "No image found for the winner.";
//        }
//    }
    @RequestMapping("/updateWinnerWins")
    @ResponseBody
    public String updateWinnerWins(@RequestParam("winnerName") String winnerName) {
        try {
            // winnerName을 기반으로 DB 업데이트 수행
            idealWorldCupDAO.updateWins(winnerName);
            return "Success"; // 성공 시 메시지 반환
        } catch (Exception e) {
            e.printStackTrace();
            return "Error"; // 실패 시 메시지 반환
        }
    }

}
