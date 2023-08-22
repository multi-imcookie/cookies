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
    public int insertDB(DBApiDTO dbApiDTO) {    // DB 생성
        // System.out.println("DAO>> " + dbApiDTO.toString());
        int result = 0;
        result += my.insert("db.insertSnack", dbApiDTO);  // snack DB 데이터 생성
        result += my.insert("db.insertNutri", dbApiDTO);  // snack_nutritional DB 데이터 생성
        return result;
    }

    @Override
    public int updateDB() { // DB 업데이트
        int result = 0;
        result += my.update("db.updateSnack");    // snack_nutritional DB 데이터 삭제
        result += my.update("db.updateNutri");    // snack DB 데이터 삭제
        return result;
    }

    @Override
    public int deleteAllDB() { // DB 전체삭제
        int result = 0;
        result += my.delete("db.deleteNutri");    // snack_nutritional DB 데이터 삭제
        result += my.delete("db.deleteSnack");    // snack DB 데이터 삭제
        return result;
    }

    @Override
    public void resetDBAI() {   // DB 오토인크리먼트 초기화
        my.update("db.resetNutriAI");   // snack_nutritional DB Auto_Increment 초기화
        my.update("db.resetSnackAI");   // snack DB Auto_Increment 초기화
    }
}
