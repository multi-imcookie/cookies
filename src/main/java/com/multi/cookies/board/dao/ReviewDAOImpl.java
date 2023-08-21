package com.multi.cookies.board.dao;

import com.multi.cookies.board.dto.ReviewDTO;
import org.apache.ibatis.session.SqlSession;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import javax.inject.Inject;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Repository
public class ReviewDAOImpl implements ReviewDAO {

    @Inject
    SqlSession SqlSession;



    // 05. 게시글 전체 목록
    @Override
    public List<ReviewDTO> listAll() throws Exception {
        return SqlSession.selectList("review.listAll");
    }


    // 2. 게시글 작성
    @Override
    public void create(ReviewDTO reviewDTO) throws Exception {
        SqlSession.insert("review.insert", reviewDTO);
    }
    // 3. 게시글 조회
    @Override
    public ReviewDTO read(int review_id) throws Exception {
        return SqlSession.selectOne("review.view", review_id);
    }
    // 4. 게시글 수정
    @Override
    public void update(ReviewDTO reviewDTO) throws Exception {
        SqlSession.update("review.update", reviewDTO);
 //       SqlSession.update("review.updateArticle", reviewDTO);
    }
    // 5. 게시글 삭제
    @Override
    public void delete(int review_id) throws Exception {
        SqlSession.delete("review.deleteArticle", review_id);
    }


/*    // 1. 게시글 전체 목록
    @Override
    public List<ReviewDTO> listAll(String searchOption, String keyword) throws Exception {
        // 검색옵션, 키워드 맵에 저장
        Map<String, String> map = new HashMap<String, String>();
        map.put("searchOption", searchOption);
        map.put("keyword", keyword);
        return SqlSession.selectList("review.listAll", map);
    }

    // 07. 게시글 레코드 갯수
    @Override
    public int countArticle(String searchOption, String keyword) throws Exception {
        // 검색옵션, 키워드 맵에 저장
        Map<String, String> map = new HashMap<String, String>();
        map.put("searchOption", searchOption);
        map.put("keyword", keyword);
        return SqlSession.selectOne("board.countArticle", map);
    }*/






}

