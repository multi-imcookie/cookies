package com.multi.cookies.entertainment.dao;

import com.multi.cookies.entertainment.dto.IdealWorldCupDTO;
import com.multi.cookies.entertainment.vo.PageVO;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.List;

@Component
public class IdealWorldCupDAO {

    @Autowired
    SqlSessionTemplate my;
    public List<IdealWorldCupDTO> list2(PageVO vo) {
        return my.selectList("worldCup.list2", vo);
    }
    public List<IdealWorldCupDTO> all(PageVO vo) {
        return my.selectList("worldCup.all", vo);
    }
    public int count() {
        return my.selectOne("worldCup.count");
    }
}
