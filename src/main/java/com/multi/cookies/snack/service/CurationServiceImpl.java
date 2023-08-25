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
    public Map<String, Object> checkedAllergy(Map<String, String> checkedAllergy) {
        curationDAO.checkedAllergy(checkedAllergy);
        return null;
    }
}
