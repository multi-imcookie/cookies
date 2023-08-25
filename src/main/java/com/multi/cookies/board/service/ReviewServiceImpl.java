package com.multi.cookies.board.service;

import com.multi.cookies.board.dao.ReviewDAO;
import com.multi.cookies.board.dto.ReviewDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;
import java.util.List;

@Service
public class ReviewServiceImpl implements ReviewService {


    @Autowired
    ReviewDAO reviewDAO;


    //작성
    @Override
    public void write(ReviewDTO reviewDTO) throws Exception {
        reviewDAO.create(reviewDTO);
    }
    //조회
    @Override
    public ReviewDTO read(int review_id) throws Exception {
        return reviewDAO.read(review_id);
    }
    //수정
    @Override
    public void update(ReviewDTO reviewDTO) throws Exception {
        reviewDAO.update(reviewDTO);
    }
    //삭제
    @Override
    public void delete(int review_id) throws Exception {
        reviewDAO.delete(review_id);
    }


    //목록
    @Override
    public List<ReviewDTO> list(
            int displayPost, int postNum, String searchType, String keyword) throws Exception {
        return  reviewDAO.list(displayPost, postNum, searchType, keyword);
    }


    // 게시물 갯수
    @Override
    public int count() throws Exception {
        int result = reviewDAO.count();
        System.out.println("service>> " + result);
        return result;
    }





}

