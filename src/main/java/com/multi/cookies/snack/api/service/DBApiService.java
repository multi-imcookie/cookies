package com.multi.cookies.snack.api.service;


import com.multi.cookies.snack.api.dto.DBApiDTO;
import org.json.simple.parser.ParseException;
import org.springframework.scheduling.annotation.Scheduled;

import java.io.IOException;
import java.util.List;

public interface DBApiService {
    String callHaccpAPI(int page) throws IOException;
    @Scheduled(cron = "0 49 17 * * * *")    // cron: 초 분 시 일 월 요일 연도
    int updateDB() throws ParseException, IOException;
//    int insertDB() throws IOException, ParseException;
    int initializeDB();
    List<DBApiDTO> parseJsonData(int page) throws ParseException, IOException;
}
