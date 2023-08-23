package com.multi.cookies.snack.api.controller;

import com.multi.cookies.snack.api.service.DBApiService;
import org.json.simple.parser.ParseException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.PropertySource;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Controller;
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
    @Scheduled(cron="0 0 15 * * * *")    // cron: 초 분 시 일 월 요일 연도
    @RequestMapping("updateDB")
    public void updateDB() throws ParseException, IOException { // DB 최신화
        dbApiService.updateDB();
    }

    @RequestMapping("insertDB")
    public void insertDB() throws ParseException, IOException {  // DB 생성
        dbApiService.insertDB();
    }

    @RequestMapping("initializeDB")
    public void initializeDB() {    // DB 초기화
        dbApiService.initializeDB();
    }

}
