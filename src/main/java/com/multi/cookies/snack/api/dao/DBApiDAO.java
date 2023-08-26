package com.multi.cookies.snack.api.dao;

import com.multi.cookies.snack.api.dto.DBApiDTO;

public interface DBApiDAO {
    int insertDB(DBApiDTO dbApiDTO);

    DBApiDTO pullDB(String snack_reportNo);

    int updateDB(DBApiDTO dbApiDTO);

    int deleteAllDB();

    void resetDBAI();
}
