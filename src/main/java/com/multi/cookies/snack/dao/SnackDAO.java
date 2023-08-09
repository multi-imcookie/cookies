
package com.multi.cookies.snack.dao;

import com.multi.cookies.snack.api.SnackInterface;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class SnackDAO implements SnackInterface {
    @Autowired
    private SqlSessionTemplate sqlSessionTemplate = null;
}