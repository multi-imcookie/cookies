package com.multi.cookies.ranking.service;

import com.multi.cookies.ranking.dto.RankingDTO;
import com.multi.cookies.ranking.dto.RankingPageDTO;

import java.util.List;

public interface RankingService {
    List<RankingDTO> getRankingList(RankingPageDTO rankingpageDTO);
    List<RankingDTO> getRankingAll(RankingPageDTO rankingpageDTO);
}
