package com.multi.cookies.snack.service;

import com.multi.cookies.snack.dao.SnackDAO;
import com.multi.cookies.snack.dto.SearchDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.*;

@Service
public class SnackServiceImpl implements SnackService {

    @Autowired
    SnackDAO snackDAO;

    public Map<String, Object> snackSearch(String keyword, int pageSize, int page, String category, String sortName, String[] selectedAllergies) {

        // 마이바티스 매퍼를 통해 검색 결과를 가져옵니다.
        List<SearchDTO> searchResults = snackDAO.snackSearch(keyword, category);

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
        List<SearchDTO> allergyConvertedResult = new ArrayList<>();
        if (selectedAllergies != null) {
            for (SearchDTO searchDTO : searchResults) {
                for (int j = 0; j < convertAllergy(selectedAllergies).size(); j++) {
                    if (!searchDTO.getAllergy().contains(convertAllergy(selectedAllergies).get(j))) {
                        allergyConvertedResult.add(searchDTO);
                    }
                }
            }
        }
        //convertAllergy

        int totalResults = allergyConvertedResult.size();
        int totalPages = (int) Math.ceil((double) totalResults / pageSize);

        // 검색된 결과에서 페이징 처리를 위한 범위를 구합니다.
        int startIndex = (page - 1) * pageSize;
        int endIndex = Math.min(startIndex + pageSize, allergyConvertedResult.size());

        int startPage = (((page - 1) / 5) * 5) + 1;
        int endPage = Math.min(startPage + 4, totalPages);

        // 범위 내에 있는 검색 결과를 추출하여 리스트로 저장합니다.
        List<SearchDTO> pageResults = allergyConvertedResult.subList(startIndex, endIndex);

        Map<String, Object> paginationResult = new HashMap<>();
        paginationResult.put("pageResults", pageResults);
        paginationResult.put("totalPages", totalPages);
        paginationResult.put("totalResults", totalResults);
        paginationResult.put("currentPage", page);
        paginationResult.put("startPage", startPage);
        paginationResult.put("endPage", endPage);

        return paginationResult;
    }

    public SearchDTO snackInfo(int snack_id) {
        System.out.println("디테일 서비스 실행!");
        return snackDAO.snackInfo(snack_id);
    }


    private List<String> convertAllergy(String[] selectedAllergies) {
        List<String> converted = new ArrayList<>();
        for (String s : selectedAllergies) {
            if (s.equals("egg_allergy")) {
                converted.add("계란");
                converted.add("달걀");
                converted.add("난황");
                converted.add("난백");
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