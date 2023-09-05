package com.multi.cookies.member.service;

import com.multi.cookies.member.dao.AdminBoardDAO;
import com.multi.cookies.member.dto.AdminBoardDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class AdminBoardService {

    @Autowired
    private AdminBoardDAO adminBoardDao;

    public Map<String, Object> getBoards(String searchType, String keyword, int page) {
        int pageSize = 20;
        int start = (page - 1) * pageSize;

        List<AdminBoardDTO> boards;
        if (searchType != null && keyword != null) {
            boards = adminBoardDao.searchBoards(searchType, keyword, start, pageSize);
        } else {
            boards = adminBoardDao.getAllBoards(start, pageSize);
        }

        int totalBoards = adminBoardDao.getTotalBoards();
        int totalPages = (int) Math.ceil((double) totalBoards / pageSize);

        int startPage = ((page - 1) / 10) * 10 + 1;
        int endPage = Math.min(startPage + 9, totalPages);

        Map<String, Object> result = new HashMap<>();
        result.put("boards", boards);
        result.put("currentPage", page);
        result.put("totalPages", totalPages);
        result.put("startPage", startPage);
        result.put("endPage", endPage);

        return result;
    }

    public Map<String, Object> getBoards(int page) {
        return getBoards(null, null, page);
    }

    public AdminBoardDTO getBoardById(int id) {
        return adminBoardDao.getBoardById(id);
    }

    public void updateBoard(int id, AdminBoardDTO board) {
        adminBoardDao.updateBoard(id, board);
    }

    public void createBoard(AdminBoardDTO board) {
        adminBoardDao.createBoard(board);
    }

    public void deleteBoard(int id) {
        adminBoardDao.deleteBoard(id);
    }
}
