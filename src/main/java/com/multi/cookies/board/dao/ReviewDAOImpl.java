package com.multi.cookies.board.dao;

import com.multi.cookies.board.dto.ReviewDTO;
import org.apache.ibatis.session.SqlSession;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import javax.inject.Inject;
import java.util.HashMap;
import java.util.List;

@Repository
public class ReviewDAOImpl implements ReviewDAO {


    @Autowired
    SqlSessionTemplate my;


    // 작성
    @Override
    public void create(ReviewDTO reviewDTO) throws Exception {
        my.insert("review.create", reviewDTO);
        my.update("snack.addSnackReviewScore", reviewDTO);
    }

    // 조회
    @Override
    public ReviewDTO read(int review_id) throws Exception {
        return my.selectOne("review.read", review_id);
    }

    // 수정
    @Override
    public void update(ReviewDTO reviewDTO) throws Exception {
        my.update("review.update", reviewDTO);
        my.update("snack.updateSnackReviewScore", reviewDTO);
    }

    public void updateAvgScore(ReviewDTO reviewDTO) {
        my.update("snack.updateAverageScore", reviewDTO);
    }

    // 삭제
    @Override
    public void delete(int review_id) throws Exception {
        my.update("snack.subtractSnackReviewScore", review_id);
        my.delete("review.delete", review_id);
    }

    //목록
    @Override
    public List<ReviewDTO> list(
            int displayPost, int postNum, String searchType, String keyword) throws Exception {
        HashMap<String, Object> data = new HashMap<String, Object>();
        data.put("displayPost", displayPost);
        data.put("postNum", postNum);
        data.put("searchType", searchType);
        data.put("keyword", keyword);
        return my.selectList("review.list", data);
    }

    // 게시물 갯수
    @Override
    public int count() throws Exception {
        int result = my.selectOne("review.count");
        System.out.println("DAO>> " + result);
        return result;
    }


}

