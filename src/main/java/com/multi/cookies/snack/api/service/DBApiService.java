package com.multi.cookies.snack.api.service;


import org.json.simple.parser.ParseException;

import java.io.IOException;

public interface DBApiService {
    String CallHaccpAPI(int page) throws IOException;
    void Parsing() throws ParseException;
}
