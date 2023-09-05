package com.multi.cookies.member.dao;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.apache.ibatis.session.SqlSession;

import com.multi.cookies.member.dto.AdminBoardDTO;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Repository
public class AdminBoardDAO {

    @Autowired
    private SqlSession sqlSession;

    public List<AdminBoardDTO> getAllBoards(int start, int pageSize) {
        Map<String, Object> params = new HashMap<>();
        params.put("start", start);
        params.put("pageSize", pageSize);
        return sqlSession.selectList("adminBoard.getAllBoards", params);
    }

    public List<AdminBoardDTO> searchBoards(Map<String, String> params) {
        return sqlSession.selectList("adminBoard.searchBoards", params);
    }

    public int getTotalBoards() {
        return sqlSession.selectOne("adminBoard.getTotalBoards");
    }

    public AdminBoardDTO getBoardById(int id) {
        return sqlSession.selectOne("adminBoard.getBoardById", id);
    }

    public void updateBoard(int id, AdminBoardDTO board) {
        Map<String, Object> params = new HashMap<>();
        params.put("id", id);
        params.put("board", board);
        sqlSession.update("adminBoard.updateBoard", params);
    }

    public void createBoard(AdminBoardDTO board) {
        sqlSession.insert("adminBoard.createBoard", board);
    }

    public void deleteBoard(int id) {
        sqlSession.delete("adminBoard.deleteBoard", id);
    }
}

