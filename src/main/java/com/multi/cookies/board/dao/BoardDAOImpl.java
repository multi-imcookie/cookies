package com.multi.cookies.board.dao;

import java.util.HashMap;
import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.multi.cookies.board.dto.BoardDTO;

@Repository
public class BoardDAOImpl implements BoardDAO {

    @Inject
    private SqlSession sql;

    private static String namespace = "board";

    // 게시물 목록
    @Override
    public List<BoardDTO> list() throws Exception {

        return sql.selectList(namespace + ".list");
    }

    // 게시물 작성
    @Override
    public void write(BoardDTO dto) throws Exception {

        sql.insert(namespace + ".write", dto);
    }

    // 게시물 조회
    @Override
    public BoardDTO view(int bbs_id) throws Exception {

        return sql.selectOne(namespace + ".view", bbs_id);
    }

    // 게시물 수정
    @Override
    public void update(BoardDTO dto) throws Exception {
        sql.update(namespace + ".update", dto);
    }

    // 게시물 삭제
    @Override
    public void delete(int bbs_id) throws Exception {
        sql.delete(namespace + ".delete", bbs_id);
    }



    // 게시물 총 갯수
    @Override
    public int count() throws Exception {
        return sql.selectOne(namespace + ".count");
    }



    // 게시물 목록 + 페이징
    @Override
    public List<BoardDTO> listPage(int displayPost, int postNum) throws Exception {

        HashMap<String, Integer> data = new HashMap<String, Integer>();

        data.put("displayPost", displayPost);
        data.put("postNum", postNum);

        return sql.selectList(namespace + ".listPage", data);
    }



    // 게시물 목록 + 페이징 + 검색
    @Override
    public List<BoardDTO> listPageSearch(
            int displayPost, int postNum, String searchType, String keyword) throws Exception {

        HashMap<String, Object> data = new HashMap<String, Object>();

        data.put("displayPost", displayPost);
        data.put("postNum", postNum);

        data.put("searchType", searchType);
        data.put("keyword", keyword);

        return sql.selectList(namespace + ".listPageSearch", data);
    }

    // 게시물 총 갯수 + 검색 적용
    @Override
    public int searchCount(String searchType, String keyword) throws Exception {

        HashMap<String, Object> data = new HashMap<String, Object>();

        data.put("searchType", searchType);
        data.put("keyword", keyword);

        return sql.selectOne(namespace + ".searchCount", data);
    }



}
