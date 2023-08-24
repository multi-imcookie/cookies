package com.multi.cookies.snack.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.Map;

@Repository
public class CurationDAOImpl implements CurationDAO {

    @Autowired
    SqlSessionTemplate sqlSessionTemplate;

    @Override
    public Map<String, Object> checkedAllergy(Map<String, String> checkedAllergy) {

        sqlSessionTemplate.insert("curation.checkedAllergy", checkedAllergy);

        return null;
    }
}
