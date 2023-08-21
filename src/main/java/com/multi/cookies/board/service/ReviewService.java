package com.multi.cookies.board.service;


import com.multi.cookies.board.dto.ReviewDTO;

import javax.servlet.http.HttpSession;
import java.util.List;

public interface ReviewService {

    // 1. 게시글 전체 목록
    public List<ReviewDTO> listAll() throws Exception;
    // 2. 게시글 작성
    public void create(ReviewDTO reviewDTO) throws Exception;
    // 3. 게시글 조회
    public ReviewDTO read(int review_id) throws Exception;
    // 4. 게시글 수정
    public void update(ReviewDTO reviewDTO) throws Exception;
    // 5. 게시글 삭제
    public void delete(int review_id) throws Exception;

/*    // 1. 게시글 전체 목록 ==> 검색옵션, 키워드 매개변수 추가
    public List<ReviewDTO> listAll(String searchOption, String keyword) throws Exception;

    // 07. 게시글 레코드 갯수 메서드 추가
    public int countArticle(String searchOption, String keyword) throws Exception;*/


}

