package com.multi.cookies.snack.service;

import com.multi.cookies.snack.dto.CurationDTO;
import com.multi.cookies.snack.dto.SearchDTO;

import java.util.List;
import java.util.Map;

public interface CurationService {

    void checkedPersonality(CurationDTO curationDTO);
    int checkedHistory(int member_id);

    void updatePersonality(CurationDTO curationDTO);

    Map<String, List<SearchDTO>> curationData(int member_id);

}
