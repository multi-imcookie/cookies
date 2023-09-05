package com.multi.cookies.snack.service;

import com.multi.cookies.snack.dao.CurationDAO;
import com.multi.cookies.snack.dto.CurationDTO;
import com.multi.cookies.snack.dto.SearchDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public class CurationServiceImpl implements CurationService {

    @Autowired
    CurationDAO curationDAO;

    //최초 큐레이션 시 저장하기 위한 메소드
    @Override
    public void checkedPersonality(CurationDTO curationDTO) {
        curationDAO.checkedPersonality(curationDTO);
    }

    // 큐레이션 이력 확인
    @Override
    public int checkedHistory(int member_id) {
        int result = curationDAO.checkedHistory(member_id);
        return result;
    }

    // 큐레이션 이력 있는 사람이 큐레이션을 진행했을 때 다시 업데이트하기 위함
    @Override
    public void updatePersonality(CurationDTO curationDTO) {
        curationDAO.updatePersonality(curationDTO);
    }


    // 개인의 큐레이션 저장 정보를 통해 데이터 가져오기
    @Override
    public Map<String, List<SearchDTO>> curationData(int member_id) {
        System.out.println("큐레이션 서비스!");
        System.out.println(curationDAO.curationData(member_id));
        return curationDAO.curationData(member_id);
    }

}
