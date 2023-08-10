package com.multi.cookies.entertainment;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class IdealBoardDAO {

    @Autowired
    SqlSessionTemplate my;
    public List<IdealBoardDTO> list() {
        return my.selectList("idealBoard.all");
    }

    public int insert(IdealBoardDTO idealBoardDTO){
        return my.insert("idealBoard.insert", idealBoardDTO);
    }
}
