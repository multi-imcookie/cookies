package com.multi.cookies.board.service;


import com.multi.cookies.board.dto.ReviewDTO;

import javax.servlet.http.HttpSession;
import java.util.List;

public interface ReviewService {

    // 작성
    public void write(ReviewDTO reviewDTO) throws Exception;
    // 조회
    public ReviewDTO read(int review_id) throws Exception;
    //수정
    public void update(ReviewDTO reviewDTO) throws Exception;
    // 삭제
    public void delete(int review_id) throws Exception;
    // 게시물 갯수
    public int count() throws Exception;
    // 목록
    public List<ReviewDTO> list(
            int displayPost, int postNum, String searchType, String keyword) throws Exception;




}

