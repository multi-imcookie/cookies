package com.multi.cookies.snack.api.service;


import org.json.simple.parser.ParseException;

import java.io.IOException;

public interface DBApiService {
    String callHaccpAPI(int page) throws IOException;
    void parseJsonData() throws ParseException;
}
