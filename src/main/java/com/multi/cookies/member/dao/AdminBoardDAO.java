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
        return sqlSession.selectList("getAllBoards", params);
    }

    public List<AdminBoardDTO> searchBoards(Map<String, String> params) {
        return sqlSession.selectList("searchBoards", params);
    }

    public int getTotalBoards() {
        return sqlSession.selectOne("getTotalBoards");
    }

    public AdminBoardDTO getBoardById(int id) {
        return sqlSession.selectOne("getBoardById", id);
    }

    public void updateBoard(int id, AdminBoardDTO board) {
        Map<String, Object> params = new HashMap<>();
        params.put("id", id);
        params.put("board", board);
        sqlSession.update("updateBoard", params);
    }

    public void createBoard(AdminBoardDTO board) {
        sqlSession.insert("createBoard", board);
    }

    public void deleteBoard(int id) {
        sqlSession.delete("deleteBoard", id);
    }
}

