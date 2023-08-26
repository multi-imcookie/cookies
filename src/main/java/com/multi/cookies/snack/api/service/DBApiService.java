package com.multi.cookies.snack.api.service;


import com.multi.cookies.snack.api.dto.DBApiDTO;
import org.json.simple.parser.ParseException;

import java.io.IOException;
import java.util.List;

public interface DBApiService {
    String callHaccpAPI(int page) throws IOException;
    int updateDB() throws ParseException, IOException;
    int insertDB() throws IOException, ParseException;
    int initializeDB();
    List<DBApiDTO> parseJsonData(int page) throws ParseException, IOException;
}
