package com.multi.cookies.snack.api.scheduler;

import com.multi.cookies.snack.api.service.DBApiService;
import org.json.simple.parser.ParseException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import java.io.IOException;

@Component
public class Scheduler {

    @Autowired
    DBApiService dbApiService;

    @Scheduled(cron = "0 30 9 * * *")   // 초 분 시 일 월 요일
    public void autoUpdate() throws ParseException, IOException {
        dbApiService.updateDB();
        System.out.println("자동 업데이트 완료");
    }
}
