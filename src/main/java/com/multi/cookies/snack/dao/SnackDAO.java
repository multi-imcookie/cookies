
package com.multi.cookies.snack.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class SnackDAO {
    @Autowired
    private SqlSessionTemplate sqlSessionTemplate = null;
}