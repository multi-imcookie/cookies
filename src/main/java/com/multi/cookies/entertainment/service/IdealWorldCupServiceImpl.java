// IdealWorldCupServiceImpl.java
package com.multi.cookies.entertainment.service;

import com.multi.cookies.entertainment.dao.IdealWorldCupDAO;
import com.multi.cookies.entertainment.dto.IdealWorldCupDTO;
import com.multi.cookies.entertainment.dto.InitialSnackListDTO;
import com.multi.cookies.entertainment.dto.PageDTO;
import com.multi.cookies.entertainment.service.IdealWorldCupService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class IdealWorldCupServiceImpl implements IdealWorldCupService {

    @Autowired
    private IdealWorldCupDAO idealWorldCupDAO;

    @Override
    public List<IdealWorldCupDTO> getAllSnacks(PageDTO pageDTO) {
        return idealWorldCupDAO.all(pageDTO);
    }

    @Override
    public List<IdealWorldCupDTO> getSnacksByRanking(PageDTO pageDTO) {
        return idealWorldCupDAO.list2(pageDTO);
    }

    @Override
    public int getSnackCount() {
        return idealWorldCupDAO.count();
    }

    @Override
    public void updateWinnerWins(int snack_id) {
        try {
            idealWorldCupDAO.updateWins(snack_id);
        } catch (Exception e) {
            e.printStackTrace();
            // 예외 처리
        }
    }
    @Override
    public List<InitialSnackListDTO> getRandomSnacks(int limit) {
        return idealWorldCupDAO.getRandomSnacks(limit);
    }
}
