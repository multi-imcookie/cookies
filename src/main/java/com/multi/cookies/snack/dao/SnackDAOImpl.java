
package com.multi.cookies.snack.dao;


import com.multi.cookies.snack.dto.SearchDTO;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.stereotype.Repository;

import java.util.*;


@Repository
public class SnackDAOImpl implements SnackDAO {

    @Autowired
    SqlSessionTemplate sqlSessionTemplate;

    // DB에서 검색을 요청하는 쿼리의 메서드
    @Override
    public List<SearchDTO> snackSearch(String keyword, String category) {
        // 검색 시, 유저가 선택한 검색 카테고리에 맞는 쿼리
        List<SearchDTO> searchResults;
        if (category.equals("name")) {
            searchResults = sqlSessionTemplate.selectList("snack.searchName", keyword);
        } else if (category.equals("ingredient")) {
            searchResults = sqlSessionTemplate.selectList("snack.searchIngredient", keyword);
        } else {
            searchResults = sqlSessionTemplate.selectList("snack.searchAll", keyword);
        }
        return searchResults;
    }

    //검색창 검색 결과 및 리뷰게시판 글 작성 시 과자 검색 결과의 세부 페이지의 정보를 요청하는 DAO 메서드
    @Override
    public SearchDTO snackInfo(int snack_id) {
        return sqlSessionTemplate.selectOne("snack.snackInfo", snack_id);
    }

    //인기 검색어 도출을 위한 DAO 메서드
    //이미 테이블에 검색 결과가 있으면 COUNT를 올리고, 없으면 INSERT
    @Override
    public void saveKeyword(String keyword) {
        int duplicateCheck = sqlSessionTemplate.selectOne("snack.duplicateCheck", keyword);
        if (duplicateCheck > 0) {
            sqlSessionTemplate.update("snack.updateKeywordCount", keyword);
        } else {
            sqlSessionTemplate.insert("snack.saveKeyword", keyword);
        }
    }
    //인기 검색어 도출을 위한 COUNT 높은 ROW 을 얻을 수 있는 쿼리를 요청하는 DAO 메소드
    @Override
    public List<String> getPopularKeywords() {
        System.out.println("DAO 요청이 되었느냐?");
        List<String> popularKeywords = sqlSessionTemplate.selectList("snack.getPopularKeywords");
        System.out.println(popularKeywords);
        return popularKeywords;
    }

}

