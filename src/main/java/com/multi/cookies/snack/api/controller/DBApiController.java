package com.multi.cookies.snack.api.controller;

import com.multi.cookies.snack.api.service.DBApiService;
import org.json.simple.parser.ParseException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.PropertySource;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import java.io.IOException;

@Controller
@RequestMapping("api")
@PropertySource("classpath:apikey.properties")
public class DBApiController {

    @Autowired
    DBApiService dbApiService;

    /**
     * TODO: 스케쥴러 미작동(수정예정)
     */
    @Scheduled(cron = "0 0 15 * * * *")    // cron: 초 분 시 일 월 요일 연도
    @RequestMapping("updateDB")
    public String updateDB(Model model) throws ParseException, IOException { // DB 최신화
        int result = dbApiService.updateDB();
        model.addAttribute("result", result);
        return "/api/updateDB";
    }

    @RequestMapping("insertDB")
    public String insertDB(Model model) throws ParseException, IOException {  // DB 생성
        int result = dbApiService.insertDB();
        model.addAttribute("result", result);
        return "/api/insertDB";
    }

    @RequestMapping("initializeDB")
    public String initializeDB(Model model) {    // DB 초기화
        int result = dbApiService.initializeDB();
        model.addAttribute("result", result);
        return "/api/initializeDB";
    }

}
