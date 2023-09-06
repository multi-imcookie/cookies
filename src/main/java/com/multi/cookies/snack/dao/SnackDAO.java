package com.multi.cookies.snack.dao;

import com.multi.cookies.snack.dto.SearchDTO;


import java.util.List;
import java.util.Map;

public interface SnackDAO {

    List<SearchDTO> snackSearch(String keyword, String category);

    SearchDTO snackInfo(int snack_id);

    public void saveKeyword(String keyword);

    List<String> getPopularKeywords();


}