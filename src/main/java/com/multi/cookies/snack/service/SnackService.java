package com.multi.cookies.snack.service;


import com.multi.cookies.snack.dto.SearchDTO;

import java.util.List;

public interface SnackService {

    List<SearchDTO> snackSearch(String keyword);
    SearchDTO snackInfo(int snack_id);


    
}
