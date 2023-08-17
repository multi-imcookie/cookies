package com.multi.cookies.snack.dao;

import com.multi.cookies.snack.dto.SearchDTO;

import java.util.List;

public interface SnackDAO {

    List<SearchDTO> snackSearch(String keyword);
    SearchDTO snackInfo(int snack_id);
}