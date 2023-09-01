package com.multi.cookies.snack.service;

import com.multi.cookies.snack.dao.SnackDAO;
import com.multi.cookies.snack.dto.SearchDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class SnackServiceImpl implements SnackService {

    @Autowired
    SnackDAO snackDAO;

        public Map<String, Object> snackSearch(String keyword, int pageSize, int page, String category, String sortName) {
        // 마이바티스 매퍼를 통해 검색 결과를 가져옵니다.
        List<SearchDTO> searchResults = snackDAO.snackSearch(keyword, category, sortName);


        int totalResults = searchResults.size();
        int totalPages = (int) Math.ceil((double) totalResults / pageSize);

        // 검색된 결과에서 페이징 처리를 위한 범위를 구합니다.
        int startIndex = (page - 1) * pageSize;
        int endIndex = Math.min(startIndex + pageSize, searchResults.size());

        int startPage = (((page - 1) / 5) * 5) + 1;
        int endPage = Math.min(startPage + 4, totalPages);

        // 범위 내에 있는 검색 결과를 추출하여 리스트로 저장합니다.
        List<SearchDTO> pageResults = searchResults.subList(startIndex, endIndex);

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



    //  public List<SearchDTO> snackSearch(String keyword, int pageSize) {
    //      System.out.println("리스트 서비스 실행!");
    //      return snackDAO.snackSearch(keyword);
    //  }

}