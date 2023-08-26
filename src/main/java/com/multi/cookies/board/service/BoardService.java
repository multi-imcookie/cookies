package com.multi.cookies.board.service;

import com.multi.cookies.board.dto.BoardDTO;

import java.util.List;

public interface BoardService {

    // 게시물 목록 + 페이징 + 검색
    public List<BoardDTO> list(
            int displayPost, int postNum, String searchType, String keyword) throws Exception;

    // 게시물 작성
    public void write(BoardDTO dto) throws Exception;

    // 게시물 조회
    public BoardDTO view(int bbs_id) throws Exception;

    // 게시물 수정
    public void update(BoardDTO dto) throws Exception;

    // 게시물 삭제
    public void delete(int bbs_id) throws Exception;



    // 게시물 총 갯수
    public int count() throws Exception;

    // 게시물 총 갯수 + 검색 적용
    public int searchCount(String searchType, String keyword) throws Exception;
}
