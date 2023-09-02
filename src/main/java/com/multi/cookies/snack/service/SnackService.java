package com.multi.cookies.snack.service;


import com.multi.cookies.snack.dto.SearchDTO;


import java.util.List;
import java.util.Map;

public interface SnackService {

    Map<String, Object> snackSearch(String keyword, int pageSize, int page, String category, String sortName, String[] selectedAllergies);
    SearchDTO snackInfo(int snack_id);

    public void saveKeyword(String keyword);

    List<String> getPopularKeywords();


}
