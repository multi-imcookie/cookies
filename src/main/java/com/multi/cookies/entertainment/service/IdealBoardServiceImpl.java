package com.multi.cookies.entertainment.service;

import com.multi.cookies.entertainment.dao.IdealBoardDAO;
import com.multi.cookies.entertainment.dto.IdealBoardDTO;
import com.multi.cookies.entertainment.dto.PageDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class IdealBoardServiceImpl implements IdealBoardService {

    @Autowired
    private IdealBoardDAO idealBoardDAO;

    @Override
    public List<IdealBoardDTO> getAllBoards(PageDTO pageDTO) {
        return idealBoardDAO.all(pageDTO);
    }

    @Override
    public List<IdealBoardDTO> getBoards(PageDTO pageDTO) {
        return idealBoardDAO.list2(pageDTO);
    }

    @Override
    public int insertBoard(IdealBoardDTO idealBoardDTO) {
        return idealBoardDAO.insert(idealBoardDTO);
    }

    @Override
    public int deleteBoard(IdealBoardDTO idealBoardDTO) {
        return idealBoardDAO.delete(idealBoardDTO);
    }

    @Override
    public int getBoardCount() {
        return idealBoardDAO.count();
    }
}
