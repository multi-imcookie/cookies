// IdealWorldCupService.java
package com.multi.cookies.entertainment.service;

import com.multi.cookies.entertainment.dto.IdealWorldCupDTO;
import com.multi.cookies.entertainment.dto.InitialSnackListDTO;
import com.multi.cookies.entertainment.dto.PageDTO;

import java.util.List;

public interface IdealWorldCupService {
    List<IdealWorldCupDTO> getAllSnacks(PageDTO pageDTO);
    List<IdealWorldCupDTO> getSnacksByRanking(PageDTO pageDTO);
    int getSnackCount();
    void updateWinnerWins(int snack_id);
    public List<InitialSnackListDTO> getRandomSnacks(int limit);

}