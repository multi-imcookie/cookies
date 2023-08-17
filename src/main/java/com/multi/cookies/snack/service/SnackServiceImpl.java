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

    public List<SearchDTO> snackSearch(String keyword) {
        System.out.println("리스트 서비스 실행!");

        return snackDAO.snackSearch(keyword);
    }

    public SearchDTO snackInfo(int snack_id) {
        System.out.println("디테일 서비스 실행!");
        return snackDAO.snackInfo(snack_id);
    }

}