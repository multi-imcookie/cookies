package com.multi.cookies.snack.api.dao;

import com.multi.cookies.snack.api.dto.DBApiDTO;

import java.util.List;

public interface DBApiDAO {
    int insertDB(DBApiDTO dbApiDTO);
    DBApiDTO pullDB(String snack_reportNo);
    List<DBApiDTO> searchDB(String snack_name);
    int updateDB(DBApiDTO dbApiDTO);
    int deleteDB(int snack_id);

//    int deleteAllDB();

//    void resetDBAI();
}
