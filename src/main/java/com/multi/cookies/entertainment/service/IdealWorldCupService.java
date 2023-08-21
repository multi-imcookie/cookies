package com.multi.cookies.entertainment.service;

import com.multi.cookies.entertainment.dto.IdealWorldCupDTO;
import com.multi.cookies.entertainment.dto.PageDTO;

import java.util.List;

public interface IdealWorldCupService {
    List<IdealWorldCupDTO> getAllSnacks(PageDTO pageDTO);
    List<IdealWorldCupDTO> getSnacksByRanking(PageDTO pageDTO);
    List<String> getAllSnackNames();
    void updateWins(String winnerName);
    int getSnackCount();
}
