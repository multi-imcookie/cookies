package com.multi.cookies.ranking.service;

import com.multi.cookies.entertainment.dto.IdealWorldCupDTO;
import com.multi.cookies.entertainment.dto.PageDTO;
import com.multi.cookies.ranking.dao.RankingDAO;
import com.multi.cookies.ranking.dto.RankingDTO;
import com.multi.cookies.ranking.dto.RankingPageDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class RankingServiceImpl implements RankingService{

    @Autowired
    private RankingDAO rankingDAO;

    @Override
    public List<RankingDTO> getRankingAll(RankingPageDTO rankingPageDTO) {
        List<RankingDTO> rankingList = rankingDAO.rankingAll(rankingPageDTO);
        return rankingList; // 반환값을 그대로 반환
    }

    @Override
    public List<RankingDTO> getRankingList(RankingPageDTO rankingPageDTO) {
        List<RankingDTO> rankingList = rankingDAO.rankingList(rankingPageDTO);
        return rankingList; // 반환값을 그대로 반환
    }
//@Override
//public List<RankingDTO> getRankingList(RankingPageDTO rankingPageDTO) {
//    return rankingDAO.all(rankingPageDTO);
//}
//
//    @Override
//    public List<RankingDTO> getRankingAll(RankingPageDTO rankingPageDTO) {
//        return rankingDAO.list2(rankingPageDTO);
//    }
}
