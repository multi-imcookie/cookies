package com.multi.cookies.board.service;

import com.multi.cookies.board.dao.ReviewDAO;
import com.multi.cookies.board.dto.ReviewDTO;
import org.springframework.stereotype.Service;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;
import java.util.List;

@Service
public class ReviewServiceImpl implements ReviewService {


    @Inject
    ReviewDAO reviewDAO;

    // 1. 게시글 전체 목록

    @Override
    public List<ReviewDTO> listAll() throws Exception {
        return reviewDAO.listAll();
    }



    // 2. 게시글쓰기
    @Override
    public void create(ReviewDTO reviewDTO) throws Exception {
        String review_title = reviewDTO.getReview_title();
        int review_score = reviewDTO.getReview_score();
        String review_content = reviewDTO.getReview_content();
        String review_img = reviewDTO.getReview_img();

/*        // *태그문자 처리 (< ==> &lt; > ==> &gt;)
        // replace(A, B) A를 B로 변경
        review_title = review_title.replace("<", "&lt;");
        review_title = review_title.replace("<", "&gt;");
        review_content = review_content.replace("<", "&lt;");
        review_content = review_content.replace("<", "&gt;");
        // *공백문자 처리
        review_title = review_title.replace("  ",    "&nbsp;&nbsp;");
        review_content = review_content.replace("  ",    "&nbsp;&nbsp;");
        // *줄바꿈 문자처리
        review_content = review_content.replace("\n", "<br>");
        reviewDTO.setReview_title(review_title);
        reviewDTO.setReview_content(review_content);
        reviewDTO.setReview_img(review_img);*/
        reviewDAO.create(reviewDTO);
    }
    // 3. 게시글 조회
    @Override
    public ReviewDTO read(int review_id) throws Exception {
        return reviewDAO.read(review_id);
    }
    // 4. 게시글 수정
    @Override
    public void update(ReviewDTO reviewDTO) throws Exception {
        reviewDAO.update(reviewDTO);
    }
    // 5. 게시글 삭제
    @Override
    public void delete(int review_id) throws Exception {
        reviewDAO.delete(review_id);
    }



/*    // 1. 게시글 전체 목록
    @Override
    public List<ReviewDTO> listAll(String searchOption, String keyword) throws Exception {
        return reviewDAO.listAll(searchOption, keyword);
    }


    // 07. 게시글 레코드 갯수 boardDao.countArticle메서드
    @Override
    public int countArticle(String searchOption, String keyword) throws Exception {
        return reviewDAO.countArticle(searchOption, keyword);
    }*/





}

