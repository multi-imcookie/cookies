package com.multi.cookies.snack.service;

import com.multi.cookies.snack.dao.SnackDAO;
import com.multi.cookies.snack.dto.SearchDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class SnackServiceImpl implements SnackService {

    @Autowired
    SnackDAO snackDAO;

    public List<SearchDTO> snackSearch(String keyword, int pageSize) {
        System.out.println("리스트 서비스 실행!");

        return snackDAO.snackSearch(keyword);
    }

    public int getTotalResults(String keyword) {
        if (keyword == null) {
            // keyword가 null인 경우 처리해야 할 로직을 추가합니다.
            throw new IllegalArgumentException("키워드가 null입니다.");
        }
        System.out.println(keyword+" SERVICE");
        return snackDAO.getTotalResults(keyword);
    }

    public SearchDTO snackInfo(int snack_id) {
        System.out.println("디테일 서비스 실행!");
        return snackDAO.snackInfo(snack_id);
    }

}