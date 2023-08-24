package com.multi.cookies.entertainment.dao;

import com.multi.cookies.entertainment.dto.IdealWorldCupDTO;
import com.multi.cookies.entertainment.dto.InitialSnackListDTO;
import com.multi.cookies.entertainment.dto.PageDTO;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.List;

@Component
public class IdealWorldCupDAO {

    @Autowired
    SqlSessionTemplate my;
    public List<IdealWorldCupDTO> list2(PageDTO pageDTO) {
        return my.selectList("worldCup.list2", pageDTO);
    }
    public List<IdealWorldCupDTO> all(PageDTO pageDTO) {
        return my.selectList("worldCup.all", pageDTO);
    }
    public int count() {
        return my.selectOne("worldCup.count");
    }
    public void updateWins(int snack_id) {
        my.update("worldCup.updateWinsForSnack", snack_id);
    }
    public List<InitialSnackListDTO> getRandomSnacks(int limit) {
        return my.selectList("worldCup.getRandomSnacks", limit);
    }
}
