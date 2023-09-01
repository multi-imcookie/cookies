package com.multi.cookies.snack.service;


import com.multi.cookies.snack.dto.SearchDTO;

import java.util.Map;

public interface SnackService {

    Map<String, Object> snackSearch(String keyword, int pageSize, int page, String category, String sortName, String[] selectedAllergies);
    SearchDTO snackInfo(int snack_id);


    // List<SearchDTO> snackSearch(String keyword, int pageSize);
}
