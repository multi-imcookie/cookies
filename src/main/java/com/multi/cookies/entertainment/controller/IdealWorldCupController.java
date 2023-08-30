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

    // 새로운 메서드 추가: 승률 계산 및 리스트에 적용
    public List<IdealWorldCupDTO> calculateWinRateForList(List<IdealWorldCupDTO> list) {
        int totalGames = idealWorldCupDAO.calculateTotalGames(); // 총 게임 수 가져오기
        for (IdealWorldCupDTO dto : list) {
            double winRate = (double) dto.getWins() / totalGames * 100.0;
            winRate = Math.round(winRate * 100.0) / 100.0; // 소수점 둘째 자리까지 반올림
            dto.setWinRate(winRate);
//            System.out.println("winRate = " + winRate);
        }
        return list;
    }
    @RequestMapping("/entertainment/idealWorldCupList")
    public void list2(PageDTO pageDTO, Model model) {
        pageDTO.setStartEnd(pageDTO.getPage());
        List<IdealWorldCupDTO> list = idealWorldCupDAO.list2(pageDTO);

        // 승률 계산 메서드를 호출하여 리스트에 적용
        list = calculateWinRateForList(list);
        model.addAttribute("list", list);
    }

    @RequestMapping("/entertainment/idealWorldCupAll")
    public void all2(PageDTO pageDTO, Model model) {
        pageDTO.setStartEnd(pageDTO.getPage());
        List<IdealWorldCupDTO> list = idealWorldCupDAO.all(pageDTO);
        int count = idealWorldCupDAO.count();
        int pages = (count + 9) / 10; // 페이지 개수 계산 수정

        // 승률 계산 메서드를 호출하여 리스트에 적용
        list = calculateWinRateForList(list);

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