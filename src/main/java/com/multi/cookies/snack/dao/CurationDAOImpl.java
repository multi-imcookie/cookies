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


    // 처음 큐레이션한 사람이라면 체크한 DATA 저장!
    @Override
    public void checkedPersonality(CurationDTO curationDTO) {

        sqlSessionTemplate.insert("curation.checkedPersonality", curationDTO);

    }

    // 이미 큐레이션을 진행한 적이 있었는지 파악하기 위함
    @Override
    public int checkedHistory(int member_id) {
        int result = sqlSessionTemplate.selectOne("curation.checkedHistory", member_id);
        System.out.println(result);
        return result;
    }

    // 이미 큐레이션 진행한 사람이면 재진행 했을 때 업데이트
    @Override
    public void updatePersonality(CurationDTO curationDTO) {
        sqlSessionTemplate.update("curation.updatePersonality", curationDTO);
    }

    // 큐레이션 결과를 통한 과자 정보를 출력하기 위함. 체크한 알레르기에 대한 과자 제외, 취향에 색인되는 과자 포함
    @Override
    public Map<String, List<SearchDTO>> curationData(int member_id) {

        // 유니크한 member_id로 CURATION TABLE 조회
        CurationDTO curationDTO = sqlSessionTemplate.selectOne("curation.curationFavorite", member_id);

        if (curationDTO != null) {
            Map<String, List<SearchDTO>> columnDataMap = new HashMap<>();
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

                // totalSearchData를 hashset으로 중복값 삭제 => filteredSearchData
                // 왜냐하면 키워드에 걸려서 비슷한 게 또 저장될 수 있는데, 필터링하는 과정
                Set<SearchDTO> filteredSearchData = new HashSet<>(totalSearchData);

                // filteredSearchData를 다시 List 화 => uniqueSearchData
                List<SearchDTO> uniqueSearchData = new ArrayList<>(filteredSearchData);

                // uniqueSearchData를 avg_score 기준으로 정렬하기 (내림차순)
                // 추천이기 때문에 그래도 별점이 가장 높은 순으로 정렬하기 위한 작업.
                Collections.sort(uniqueSearchData, Comparator.comparing(SearchDTO::getAvg_score).reversed());


                //그리고 여기서 필터링으로 알러지 거르기.
                List<String> allergyColumns = sqlSessionTemplate.selectList("curation.getAllergyColumnNames");

                List<String> getSelectedAllergies = new ArrayList<>();
                for (String columnName : allergyColumns) {
                    // 각각의 컬럼 값이 1인지 확인
                    Map<String, Object> parameterMap = new HashMap<>();
                    parameterMap.put("columnName", columnName);
                    Integer value = sqlSessionTemplate.selectOne("curation.checkAllergyValue", parameterMap);

                    // 만약 해당 컬럼의 값이 1이면 결과 리스트에 추가
                    if (value != null && value == 1) {
                        getSelectedAllergies.add(columnName);
                    }
                }

                String[] selectedAllergies = getSelectedAllergies.toArray(new String[0]);

                List<SearchDTO> allergyConvertedResult = new ArrayList<>();

                for (SearchDTO searchDTO : uniqueSearchData) {
                    if (selectedAllergies != null) {    // selectedAllergies가 null이 아닐 경우에는
                        int match = 0;  // 매치하는 알러지 개수를 담을 변수
                        for (String convertedAllergy : convertAllergy(selectedAllergies)) {    // convertAllergy(selectedAllergies)의 개수만큼 반복
                            if (searchDTO.getAllergy() != null && searchDTO.getAllergy().contains(convertedAllergy)) {   // searchDTO.getAllergy()가 convertedAllergy를 포함할 경우
                                match++;   // match 값 증가
                            }
                            if (searchDTO.getSnack_ingredients() != null && searchDTO.getSnack_ingredients().contains(convertedAllergy)) {
                                match++;
                            }
                        }
                        if (match == 0) {    // match값이 없을 경우에만 searchDTO를 추가
                            allergyConvertedResult.add(searchDTO);
                        }
                    } else {    // selectedAllergies가 null일 경우에는 그냥 추가한다
                        allergyConvertedResult.add(searchDTO);
                    }
                }

                // 상위 5개만 선택하기
                List<SearchDTO> top5Data = allergyConvertedResult.stream()
                        .limit(5)
                        .collect(Collectors.toList());

                columnDataMap.put(favoriteColumn, top5Data);
            }

            if (columnDataMap.isEmpty()) {
                String noPreference = "noPreference";
                List<SearchDTO> recommendList = sqlSessionTemplate.selectList("curation.bestScoreRecommend");

                //그리고 여기서 필터링으로 알러지 거르기.
                List<String> allergyColumns = sqlSessionTemplate.selectList("curation.getAllergyColumnNames");

                List<String> getSelectedAllergies = new ArrayList<>();
                for (String columnName : allergyColumns) {
                    // 각각의 컬럼 값이 1인지 확인
                    Map<String, Object> parameterMap = new HashMap<>();
                    parameterMap.put("columnName", columnName);
                    Integer value = sqlSessionTemplate.selectOne("curation.checkAllergyValue", parameterMap);

                    // 만약 해당 컬럼의 값이 1이면 결과 리스트에 추가
                    if (value != null && value == 1) {
                        getSelectedAllergies.add(columnName);
                    }
                }

                String[] selectedAllergies = getSelectedAllergies.toArray(new String[0]);
                List<SearchDTO> allergyConvertedResult = new ArrayList<>();

                for (SearchDTO searchDTO : recommendList) {
                    if (selectedAllergies != null) {    // selectedAllergies가 null이 아닐 경우에는
                        int match = 0;  // 매치하는 알러지 개수를 담을 변수
                        for (String convertedAllergy : convertAllergy(selectedAllergies)) {    // convertAllergy(selectedAllergies)의 개수만큼 반복
                            if (searchDTO.getAllergy() != null && searchDTO.getAllergy().contains(convertedAllergy)) {   // searchDTO.getAllergy()가 convertedAllergy를 포함할 경우
                                match++;   // match 값 증가
                            }
                            if (searchDTO.getSnack_ingredients() != null && searchDTO.getSnack_ingredients().contains(convertedAllergy)) {
                                match++;
                            }
                        }
                        if (match == 0) {    // match값이 없을 경우에만 searchDTO를 추가
                            allergyConvertedResult.add(searchDTO);
                        }
                    } else {    // selectedAllergies가 null일 경우에는 그냥 추가한다
                        allergyConvertedResult.add(searchDTO);
                    }
                }
                // 상위 5개만 선택하기
                List<SearchDTO> top5Data = allergyConvertedResult.stream()
                        .limit(5)
                        .collect(Collectors.toList());

                columnDataMap.put(noPreference, top5Data);

                System.out.println(columnDataMap);

                return columnDataMap;
            }


            return columnDataMap;
        }

        return null;
    }

    //취향 별로 키워드 목록을 반환하는 메소드입니다.
    //취향에 부합한 과자들을 찾기 위해 재료적인 부분으로 키워드 제작 후 검색 실행 진행
    private List<String> getKeywordsForColumn(String columnName) {
        List<String> keywords = new ArrayList<>();
        if (columnName.equals("chocolate")) {
            keywords.add("초코");
            keywords.add("초콜렛");
            keywords.add("초콜릿");
            keywords.add("쵸코");
            keywords.add("카카오");
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
            keywords.add("달달");
        }
        return keywords;
    }

    private List<String> convertAllergy(String[] selectedAllergies) {
        List<String> converted = new ArrayList<>();
        for (String s : selectedAllergies) {
            if (s.equals("egg_allergy")) {
                converted.add("계란");
                converted.add("달걀");
                converted.add("난황");
                converted.add("난백");
                converted.add("전란액");
            }
            if (s.equals("milk_allergy")) {
                converted.add("우유");
                converted.add("분유");
                converted.add("유지");
                converted.add("카제인");
                converted.add("유청단백");
                converted.add("분말유");
                converted.add("유크림");
                converted.add("유당");
                converted.add("유청분말");
                converted.add("원유");
                converted.add("환원유");
                converted.add("연유");
                converted.add("가공유");
            }
            if (s.equals("wheat_allergy")) {
                converted.add("밀");
                converted.add("호밀");
                converted.add("밀가루");
                converted.add("된장");
                converted.add("고추장");
                converted.add("간장");
            }
            if (s.equals("buckwheat_allergy")) {
                converted.add("메밀");
            }
            if (s.equals("peanut_allergy")) {
                converted.add("땅콩");
                converted.add("피넛");
            }
            if (s.equals("soy_allergy")) {
                converted.add("콩");
                converted.add("대두");
                converted.add("쇼트닝");
                converted.add("레시틴");
            }
            if (s.equals("pine_nut_allergy")) {
                converted.add("잣");
            }
            if (s.equals("almond_allergy")) {
                converted.add("아몬드");
            }
            if (s.equals("walnut_allergy")) {
                converted.add("호두");
                converted.add("월넛");
                converted.add("호도");
            }
            if (s.equals("crab_allergy")) {
                converted.add("게");
                converted.add("크랩");
            }
            if (s.equals("shrimp_allergy")) {
                converted.add("새우");
                converted.add("쉬림프");
                converted.add("슈림프");
            }
            if (s.equals("squid_allergy")) {
                converted.add("오징어");
            }
            if (s.equals("mackerel_allergy")) {
                converted.add("고등어");
            }
            if (s.equals("shellfish_allergy")) {
                converted.add("전복");
                converted.add("홍합");
                converted.add("조개");
                converted.add("굴");
            }
            if (s.equals("peach_allergy")) {
                converted.add("복숭아");
            }
            if (s.equals("tomato_allergy")) {
                converted.add("토마토");
            }
            if (s.equals("chicken_allergy")) {
                converted.add("닭");
                converted.add("치킨");
                converted.add("계육");
            }
            if (s.equals("pork_allergy")) {
                converted.add("돈육");
                converted.add("돈지");
                converted.add("돈골");
                converted.add("돼지고기");
                converted.add("젤라틴");
            }
            if (s.equals("beef_allergy")) {
                converted.add("우육");
                converted.add("쇠고기");
                converted.add("우지");
                converted.add("사골");
                converted.add("우골");
                converted.add("소고기");
            }
        }
        return converted;
    }
}
