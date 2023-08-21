package com.multi.cookies.entertainment.dao;

import com.multi.cookies.entertainment.dto.IdealWorldCupDTO;
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
    public List<String> list() {
        return my.selectList("worldCup.list");
    }
//    public IdealWorldCupDTO one(String ideal_snack_name) {
//        return my.selectOne("worldCup.one", ideal_snack_name);
//    }
    public void updateWins(String winnerName) {
        my.update("worldCup.updateWins", winnerName);
    }

}
