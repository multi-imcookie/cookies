package com.multi.cookies.board.dao;


import com.multi.cookies.board.dto.ReviewDTO;

import java.util.List;

public interface ReviewDAO {

    //작성
    public void create(ReviewDTO reviewDTO) throws Exception;
    //조회
    public ReviewDTO read(int review_id) throws Exception;
    //수정
    public void update(ReviewDTO reviewDTO) throws Exception;

    //삭제
    public void delete(int review_id) throws Exception;

    // 목록
    public List<ReviewDTO> list(int displayPost, int postNum, String searchType, String keyword) throws Exception;

    // 게시물 총 갯수
    public int count() throws Exception;




}
