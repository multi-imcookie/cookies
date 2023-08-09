

package com.multi.cookies.snack.dao;

import com.multi.cookies.snack.api.NutritionalInterface;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class NutritionalDAO implements NutritionalInterface {

    @Autowired
    private SqlSessionTemplate sqlSessionTemplate;

}