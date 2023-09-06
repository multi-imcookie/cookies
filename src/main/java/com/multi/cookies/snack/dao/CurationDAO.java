package com.multi.cookies.snack.dao;


import com.multi.cookies.snack.dto.CurationDTO;
import com.multi.cookies.snack.dto.SearchDTO;

import java.util.List;
import java.util.Map;

public interface CurationDAO {

    void checkedPersonality(CurationDTO curationDTO);
    int checkedHistory(int member_id);

    void updatePersonality(CurationDTO curationDTO);

    Map<String, List<SearchDTO>> curationData(int member_id);

}
