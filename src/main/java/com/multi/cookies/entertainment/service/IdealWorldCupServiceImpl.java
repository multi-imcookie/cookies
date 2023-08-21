package com.multi.cookies.entertainment.service;

import com.multi.cookies.entertainment.dao.IdealWorldCupDAO;
import com.multi.cookies.entertainment.dto.IdealWorldCupDTO;
import com.multi.cookies.entertainment.dto.PageDTO;
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
    public List<String> getAllSnackNames() {
        return idealWorldCupDAO.list();
    }

    @Override
    public void updateWins(String winnerName) {
        idealWorldCupDAO.updateWins(winnerName);
    }

    @Override
    public int getSnackCount() {
        return idealWorldCupDAO.count();
    }
}
