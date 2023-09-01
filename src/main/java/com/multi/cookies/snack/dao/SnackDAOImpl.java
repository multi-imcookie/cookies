
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

    @Override
    public List<SearchDTO> snackSearch(String keyword, String category, String sortName) {
        System.out.println("DAO까지 잘 왔어!");

        List<SearchDTO> searchResults;
        if (category.equals("name")) {
            searchResults = sqlSessionTemplate.selectList("snack.searchName", keyword);
        } else if (category.equals("ingredient")) {
            searchResults = sqlSessionTemplate.selectList("snack.searchIngredient", keyword);
        } else {
            searchResults = sqlSessionTemplate.selectList("snack.searchAll", keyword);
        }

        if (sortName.equals("sortHighCalorie")) {
            //avg_score 기준으로 정렬하기 (내림차순 / 높은 것부터)
            Collections.sort(searchResults, Comparator.comparing(SearchDTO::getKcal).reversed());
        } else if (sortName.equals("sortLowCalorie")) {
            //avg_score 기준으로 정렬하기 (올림차순 / 낮은 것부터)
            Collections.sort(searchResults, Comparator.comparing(SearchDTO::getKcal));
        } else if (sortName.equals("sortHighSugar")) {
            //sugars 기준으로 정렬하기 (내림차순 / 높은 것부터)
            Collections.sort(searchResults, Comparator.comparing(SearchDTO::getSugars).reversed());
        } else if (sortName.equals("sortLowSugar")) {
            //sugars 기준으로 정렬하기 (올림차순 / 낮은 것부터)
            Collections.sort(searchResults, Comparator.comparing(SearchDTO::getSugars));
        } else if (sortName.equals("sortHighProtein")) {
            //protein 기준으로 정렬하기 (내림차순 / 높은 것부터)
            Collections.sort(searchResults, Comparator.comparing(SearchDTO::getProtein).reversed());
        } else if (sortName.equals("sortLowProtein")) {
            //protein 기준으로 정렬하기 (올림차순 / 낮은 것부터)
            Collections.sort(searchResults, Comparator.comparing(SearchDTO::getProtein));
        } else if (sortName.equals("sortHighFat")) {
            //fat 기준으로 정렬하기 (내림차순 / 높은 것부터)
            Collections.sort(searchResults, Comparator.comparing(SearchDTO::getFat).reversed());
        } else if (sortName.equals("sortLowFat")) {
            //fat 기준으로 정렬하기 (올림차순 / 낮은 것부터)
            Collections.sort(searchResults, Comparator.comparing(SearchDTO::getFat));
        } else if (sortName.equals("sortHighScore")) {
            //avg_score 기준으로 정렬하기 (내림차순 / 높은 것부터)
            Collections.sort(searchResults, Comparator.comparing(SearchDTO::getAvg_score).reversed());
        } else if (sortName.equals("sortLowAvgScore")) {
            //avg_score 기준으로 정렬하기 (올림차순 / 낮은 것부터)
            Collections.sort(searchResults, Comparator.comparing(SearchDTO::getAvg_score));
        }
        return searchResults;
    }

    @Override
    public SearchDTO snackInfo(int snack_id) {
        System.out.println("디테일 DAO!");
        return sqlSessionTemplate.selectOne("snack.snackInfo", snack_id);
    }

    ///  public int getTotalResults(String keyword) {
    ///      if (keyword == null) {
    ///          // null 키워드에 대한 처리 코드 작성
    ///          throw new IllegalArgumentException("키워드가 null입니다.");
    ///      }
    ///      System.out.println(keyword+" DAO");
    ///      return sqlSessionTemplate.selectOne("snack.getTotalResults", keyword);
    ///  }
}
