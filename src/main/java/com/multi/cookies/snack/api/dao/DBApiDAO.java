package com.multi.cookies.snack.api.dao;

import com.multi.cookies.snack.api.dto.DBApiDTO;

public interface DBApiDAO {
    int InsertDB(DBApiDTO dbApiDTO);
    int DeleteDB();
    void ResetDBAI();
}
