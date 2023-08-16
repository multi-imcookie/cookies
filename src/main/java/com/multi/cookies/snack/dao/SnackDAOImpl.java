
package com.multi.cookies.snack.dao;

import com.multi.cookies.snack.dto.SearchDTO;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class SnackDAOImpl implements SnackDAO {

    @Autowired
    SqlSessionTemplate sqlSessionTemplate;


    public List<SearchDTO> snackSearch(String keyword) {
        System.out.println("DAO까지 잘 왔어!");
        return sqlSessionTemplate.selectList("snack.search", keyword);
    }

    public SearchDTO snackInfo(int snack_id) {
        System.out.println("디테일 DAO!");
        return sqlSessionTemplate.selectOne("snack.snackInfo", snack_id);
    }
}
