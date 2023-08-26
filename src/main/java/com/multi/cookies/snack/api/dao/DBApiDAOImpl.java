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
        my.insert("db.insertScoreId", dbApiDTO); // 평점 테이블 snack_id 생성 
        my.insert("db.insertIdealId", dbApiDTO); // 이상형월드컵 테이블 snack_id 생성
        return result;
    }

    @Override
    public DBApiDTO pullDB(String snack_reportNo) {    // 기존 DB 가져오기(업데이트용)
        return my.selectOne("db.pullData", snack_reportNo);
    }

    @Override
    public int updateDB(DBApiDTO dbApiDTO) { // DB 업데이트
        return my.update("db.update", dbApiDTO);    // DB 업데이트
    }

    @Override
    public int deleteAllDB() { // DB 전체삭제
        return my.delete("db.deleteSnack");   // snack DB 데이터 삭제 (Cascade설정으로 연결된 테이블 함께 삭제)
    }

    @Override
    public void resetDBAI() {   // DB 오토인크리먼트 초기화
        my.update("db.resetSnackAI");   // snack DB Auto_Increment 초기화
    }
}
