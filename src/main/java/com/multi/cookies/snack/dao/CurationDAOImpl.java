package com.multi.cookies.snack.dao;

import com.multi.cookies.snack.dto.CurationDTO;
import com.multi.cookies.snack.dto.SearchDTO;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.*;
import java.util.stream.Collectors;

@Repository
public class CurationDAOImpl implements CurationDAO {

    @Autowired
    SqlSessionTemplate sqlSessionTemplate;

    @Override
    public void checkedPersonality(CurationDTO curationDTO) {

        sqlSessionTemplate.insert("curation.checkedPersonality", curationDTO);

    }

    @Override
    public int checkedHistory(int member_id) {
        int result = sqlSessionTemplate.selectOne("curation.checkedHistory", member_id);
        return result;
    }

    @Override
    public void updatePersonality(CurationDTO curationDTO) {
        sqlSessionTemplate.update("curation.updatePersonality", curationDTO);
    }

    @Override
    public Map<String, List<String>> curationData(int member_id) {

        // 유니크한 member_id로 CURATION TABLE 조회
        CurationDTO curationDTO = sqlSessionTemplate.selectOne("curation.curationFavorite", member_id);

        if (curationDTO != null) {
            Map<String, List<String>> columnDataMap = new HashMap<>();
            List<String> favoriteList = new ArrayList<>();

            // "chocolate", "strawberry", "chili", "honey" 칼럼에 해당하는 값을 가져와서 처리
            String[] favoriteColumns = {"chocolate", "strawberry", "chili", "honey"};
            for (String columnName : favoriteColumns) {
                try {
                    // 해당 칼럼의 값을 가져와서 값이 1인 경우 해당 칼럼명을 리스트에 추가
                    int columnValue = (int) CurationDTO.class.getMethod("get" + columnName.substring(0, 1).toUpperCase() + columnName.substring(1)).invoke(curationDTO);
                    if (columnValue == 1) {
                        // 해당 칼럼명을 favoriteList에 추가
                        favoriteList.add(columnName);
                    }
                } catch (Exception e) {
                    // 예외 처리
                    e.printStackTrace();
                }
            }

            // favoriteList에 저장된 칼럼명으로 다시 조회해서 데이터 가져오기
            for (String favoriteColumn : favoriteList) {
                List<SearchDTO> totalSearchData = new ArrayList<>();

                // 특정 칼럼에 대한 키워드 목록 가져오기
                List<String> keywords = getKeywordsForColumn(favoriteColumn);

                // 각 키워드 별로 쿼리 실행하여 검색 결과 가져오기
                for (String keyword : keywords) {
                    Map<String, Object> paramsMap = new HashMap<>();
                    paramsMap.put("keyword", keyword);
                    List<SearchDTO> searchData = sqlSessionTemplate.selectList("curation.search", paramsMap);
                    totalSearchData.addAll(searchData);
                }
                // totalSearchData를 avg_score 기준으로 정렬하기 (내림차순)
                Collections.sort(totalSearchData, Comparator.comparing(SearchDTO::getAvg_score).reversed());

                // 상위 5개만 선택하기
                List<String> top5Data = totalSearchData.stream()
                        .limit(5)
                        .map(SearchDTO::toString)
                        .collect(Collectors.toList());

                columnDataMap.put(favoriteColumn, top5Data);
            }

            return columnDataMap;
        }

        return null;
    }

    //카테고리 별로 키워드 목록을 반환하는 메소드입니다.
    private List<String> getKeywordsForColumn(String columnName) {
        List<String> keywords = new ArrayList<>();
        if (columnName.equals("chocolate")) {
            keywords.add("초코");
            keywords.add("초콜렛");
            keywords.add("초콜릿");
            keywords.add("코코아");
        } else if (columnName.equals("strawberry")) {
            keywords.add("딸기");
            keywords.add("스트로베리");
        } else if (columnName.equals("chili")) {
            keywords.add("칠리");
            keywords.add("핫");
            keywords.add("매운");
            keywords.add("고추");
            keywords.add("캡사이신");
            keywords.add("매콤");
        } else if (columnName.equals("honey")) {
            keywords.add("허니");
            keywords.add("꿀");
        }
        return keywords;
    }
}
