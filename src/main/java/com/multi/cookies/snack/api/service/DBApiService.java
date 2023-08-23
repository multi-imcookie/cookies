package com.multi.cookies.snack.api.service;


import com.multi.cookies.snack.api.dto.DBApiDTO;
import org.json.simple.parser.ParseException;

import java.io.IOException;
import java.util.List;

public interface DBApiService {
    String callHaccpAPI(int page) throws IOException;
    void updateDB() throws ParseException, IOException;
    void insertDB() throws IOException, ParseException;
    void initializeDB();
    List<DBApiDTO> parseJsonData(int page) throws ParseException, IOException;
}
