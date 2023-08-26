package com.multi.cookies.snack.service;

import com.multi.cookies.snack.dao.CurationDAO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Map;

@Service
public class CurationServiceImpl implements CurationService {

    @Autowired
    CurationDAO curationDAO;

    @Override
    public void checkedAllergy(Map<String, String> checkedAllergy) {
        System.out.println("난 서비스!");
        curationDAO.checkedAllergy(checkedAllergy);
    }
}
