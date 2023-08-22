package com.multi.cookies.snack.api.dao;

import com.multi.cookies.snack.api.dto.DBApiDTO;

public interface DBApiDAO {
    int insertDB(DBApiDTO dbApiDTO);
    int updateDB();
    int deleteAllDB();
    void resetDBAI();
}
