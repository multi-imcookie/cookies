package com.multi.cookies.entertainment.dao;

import com.multi.cookies.entertainment.dto.IdealBoardDTO;
import com.multi.cookies.entertainment.dto.PageDTO;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.List;

@Component
public class IdealBoardDAO {

    @Autowired
    SqlSessionTemplate my;
    public List<IdealBoardDTO> list2(PageDTO pageDTO) {
        return my.selectList("idealBoard.list2", pageDTO);
    }
    public List<IdealBoardDTO> all(PageDTO pageDTO) {
        return my.selectList("idealBoard.all", pageDTO);
    }
    public int count() {
        return my.selectOne("idealBoard.count");
    }
    public int insert(IdealBoardDTO idealBoardDTO){
        return my.insert("idealBoard.insert", idealBoardDTO);
    }
    public int delete(IdealBoardDTO idealBoardDTO) {
        return my.delete("idealBoard.delete", idealBoardDTO);
    }
}
