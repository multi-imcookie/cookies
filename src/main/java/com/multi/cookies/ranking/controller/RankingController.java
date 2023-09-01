package com.multi.cookies.ranking.controller;

import com.multi.cookies.ranking.dto.RankingDTO;
import com.multi.cookies.ranking.dto.RankingPageDTO;
import com.multi.cookies.ranking.dao.RankingDAO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;

@Controller
public class RankingController {

    @Autowired
    RankingDAO rankingDAO;

    @RequestMapping("/ranking/rankingList")
    public void rankingList(RankingPageDTO rankingPageDTO, Model model) {
        rankingPageDTO.setStartEnd(rankingPageDTO.getPage());
        List<RankingDTO> list = rankingDAO.rankingList(rankingPageDTO);
        model.addAttribute("list", list);
//        System.out.println("list from DAO: " + list);
    }

    @RequestMapping("/ranking/rankingAll")
    public void rankingAll(RankingPageDTO rankingPageDTO, Model model) {
        rankingPageDTO.setStartEnd(rankingPageDTO.getPage());
        List<RankingDTO> list = rankingDAO.rankingAll(rankingPageDTO);
        int count = rankingDAO.count();
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
//        System.out.println("listall = " + list);
//        System.out.println("count = " + count);
//        System.out.println("pages = " + pages);
    }

}