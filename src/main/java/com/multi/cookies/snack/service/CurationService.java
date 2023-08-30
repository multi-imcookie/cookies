package com.multi.cookies.snack.service;

import com.multi.cookies.snack.dto.CurationDTO;

import java.util.List;
import java.util.Map;

public interface CurationService {

    void checkedPersonality(CurationDTO curationDTO);
    int checkedHistory(int member_id);

    void updatePersonality(CurationDTO curationDTO);

    Map<String, List<String>> curationData(int member_id);

}
