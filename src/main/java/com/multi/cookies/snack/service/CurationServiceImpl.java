package com.multi.cookies.snack.service;

import com.multi.cookies.snack.dao.CurationDAO;
import com.multi.cookies.snack.dto.CurationDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public class CurationServiceImpl implements CurationService {

    @Autowired
    CurationDAO curationDAO;

    @Override
    public void checkedPersonality(CurationDTO curationDTO) {
        System.out.println("난 서비스!");
        curationDAO.checkedPersonality(curationDTO);
    }

    @Override
    public int checkedHistory(int member_id) {
        int result = curationDAO.checkedHistory(member_id);
        return result;
    }

    @Override
    public void updatePersonality(CurationDTO curationDTO) {
        curationDAO.updatePersonality(curationDTO);
    }

    @Override
    public Map<String, List<String>> curationData(int member_id) {
        return curationDAO.curationData(member_id);
    }

}
