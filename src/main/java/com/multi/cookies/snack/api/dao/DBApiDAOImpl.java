package com.multi.cookies.snack.api.dao;

import com.multi.cookies.snack.api.dto.DBApiDTO;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class DBApiDAOImpl implements DBApiDAO {

    @Autowired
    private SqlSessionTemplate my;

    @Override
    public int InsertDB(DBApiDTO dbApiDTO) {
        // System.out.println("DAO>> " + dbApiDTO.toString());
        int result = 0;
        result += my.insert("db.insertSnack", dbApiDTO);  // snack DB 데이터 생성
        result += my.insert("db.insertNutri", dbApiDTO);  // snack_nutritional DB 데이터 생성
        return result;
    }

    @Override
    public int DeleteDB() {
        int result = 0;
        result += my.delete("db.deleteNutri");    // snack_nutritional DB 데이터 삭제
        result += my.delete("db.deleteSnack");    // snack DB 데이터 삭제
        return result;
    }

    @Override
    public void ResetDBAI() {
        my.update("db.resetNutriAI");   // snack_nutritional DB Auto_Increment 초기화
        my.update("db.resetSnackAI");   // snack DB Auto_Increment 초기화
    }
}
