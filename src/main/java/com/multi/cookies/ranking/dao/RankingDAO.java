package com.multi.cookies.ranking.dao;

import com.multi.cookies.entertainment.dto.IdealBoardDTO;
import com.multi.cookies.entertainment.dto.PageDTO;
import com.multi.cookies.ranking.dto.RankingDTO;
import com.multi.cookies.ranking.dto.RankingPageDTO;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.List;

@Component
public class RankingDAO {

    @Autowired
    SqlSessionTemplate my;

    public List<RankingDTO> rankingList(RankingPageDTO rankingPageDTO) {
        return my.selectList("snackRanking.rankingList", rankingPageDTO);
    }
    public List<RankingDTO> rankingAll(RankingPageDTO rankingPageDTO) {
        return my.selectList("snackRanking.rankingAll", rankingPageDTO);
    }
//    public List<RankingDTO> list2(RankingPageDTO rankingPageDTO) {
//        return my.selectList("snackRanking.list2", rankingPageDTO);
//    }
//    public List<RankingDTO> all(RankingPageDTO rankingPageDTO) {
//        return my.selectList("snackRanking.all", rankingPageDTO);
//    }
    public int count() {
        return my.selectOne("snackRanking.count");
    }

    public List<RankingDTO> list() {
        return my.selectList("snackRanking.all");
    }
}
