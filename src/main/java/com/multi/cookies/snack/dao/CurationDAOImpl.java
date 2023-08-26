package com.multi.cookies.snack.dao;

import org.apache.ibatis.exceptions.PersistenceException;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import com.multi.cookies.snack.exception.DuplicateEntryException;

import java.util.Map;

@Repository
public class CurationDAOImpl implements CurationDAO {

    @Autowired
    SqlSessionTemplate sqlSessionTemplate;

    @Override
    public void checkedAllergy(Map<String, String> checkedAllergy) {
        try {
        sqlSessionTemplate.insert("curation.checkedAllergy", checkedAllergy);
        } catch (PersistenceException e) {
            throw new DuplicateEntryException("Duplicate entry for member_id");
        }
    }
}
