package com.multi.cookies.board.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.multi.cookies.board.dao.BoardDAO;
import com.multi.cookies.board.dto.BoardDTO;

@Service
public class BoardServiceImpl implements BoardService {

    @Inject
    private BoardDAO dao;

    // 게시물 목록
    @Override
    public List<BoardDTO> list() throws Exception {

        return dao.list();
    }

    // 게시물 작성
    @Override
    public void write(BoardDTO dto) throws Exception {

        dao.write(dto);
    }

    // 게시물 조회
    @Override
    public BoardDTO view(int bbs_id) throws Exception {

        return dao.view(bbs_id);
    }

    // 게시물 수정
    @Override
    public void update(BoardDTO dto) throws Exception {

        dao.update(dto);
    }

    // 게시물 삭제
    @Override
    public void delete(int bbs_id) throws Exception {
        dao.delete(bbs_id);
    }



    // 게시물 총 갯수
    @Override
    public int count() throws Exception {
        return dao.count();
    }



    // 게시물 목록 + 페이징
    @Override
    public List<BoardDTO> listPage(int displayPost, int postNum) throws Exception {
        return dao.listPage(displayPost, postNum);
    }



    // 게시물 목록 + 페이징 + 검색
    @Override
    public List<BoardDTO> listPageSearch(
            int displayPost, int postNum, String searchType, String keyword) throws Exception {
        return  dao.listPageSearch(displayPost, postNum, searchType, keyword);
    }

    // 게시물 총 갯수
    @Override
    public int searchCount(String searchType, String keyword) throws Exception {
        return dao.searchCount(searchType, keyword);
    }
}
