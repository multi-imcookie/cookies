package com.multi.cookies.entertainment.service;

import com.multi.cookies.entertainment.dto.IdealBoardDTO;
import com.multi.cookies.entertainment.dto.PageDTO;

import java.util.List;

public interface IdealBoardService {
    List<IdealBoardDTO> getAllBoards(PageDTO pageDTO);
    List<IdealBoardDTO> getBoards(PageDTO pageDTO);
    int insertBoard(IdealBoardDTO idealBoardDTO);
    int deleteBoard(IdealBoardDTO idealBoardDTO);
    int getBoardCount();
}
