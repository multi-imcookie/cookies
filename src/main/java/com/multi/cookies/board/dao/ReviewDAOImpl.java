package com.multi.cookies.board.dao;

import com.multi.cookies.board.dto.ReviewDTO;
import org.apache.ibatis.session.SqlSession;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import javax.inject.Inject;
import java.util.List;

@Repository
public class ReviewDAOImpl implements ReviewDAO {

    @Inject
    SqlSession sqlSession;

    @Autowired
    SqlSessionTemplate sqlSessionTemplate;



    // 05. 게시글 전체 목록
    @Override
    public List<ReviewDTO> listAll() throws Exception {
        return sqlSession.selectList("review.listAll");
    }


    // 2. 게시글 작성
    @Override
    public void create(ReviewDTO reviewDTO) throws Exception {
        System.out.println(reviewDTO.toString());
        System.out.println(reviewDTO);
        sqlSession.insert("review.insert", reviewDTO);
        // 별점에 관한 업데이트입니다!
        sqlSessionTemplate.update("snack.addSnackReviewScore", reviewDTO);

    }
    // 3. 게시글 조회
    @Override
    public ReviewDTO read(int review_id) throws Exception {
        return sqlSession.selectOne("review.view", review_id);
    }
    // 4. 게시글 수정
    @Override
    public void update(ReviewDTO reviewDTO) throws Exception {
        sqlSession.update("review.update", reviewDTO);
        //글 수정할 때 별점도 수정할 수 있으면 요걸로 별점 전체 관리가 들어가서 넣었습니다!
        //Controller의 맵핑에는 update.do로 되어있는데 view에서는 update로만 되어있는 거 같은데 확인!
        sqlSessionTemplate.update("snack.updateSnackReviewScore", reviewDTO);
 //       SqlSession.update("review.updateArticle", reviewDTO);
    }
    // 5. 게시글 삭제
    @Override
    public void delete(int review_id) throws Exception {
        //요건 글 지우면 글에 있었던 별점을 함께 반영해주는 것입니다!
        //순서상 별점을 반영하고 지워야 오류가 안 생겨서 위에 껴넣었습니다!
        sqlSessionTemplate.update("snack.subtractSnackReviewScore", review_id);
        sqlSession.delete("review.deleteArticle", review_id);
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

