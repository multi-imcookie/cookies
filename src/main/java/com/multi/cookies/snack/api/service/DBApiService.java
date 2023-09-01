package com.multi.cookies.snack.api.service;


import com.multi.cookies.snack.api.dto.DBApiDTO;
import org.json.simple.parser.ParseException;
import org.springframework.scheduling.annotation.Scheduled;

import java.io.IOException;
import java.util.List;

public interface DBApiService {
    String callHaccpAPI(int page, String prdkind) throws IOException;
    int updateDB() throws ParseException, IOException;
//    int insertDB() throws IOException, ParseException;
    int initializeDB();
    List<DBApiDTO> parseJsonData(int page, String prdkind) throws ParseException, IOException;
}
