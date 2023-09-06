package com.multi.cookies.board.notice.service;

import com.multi.cookies.board.notice.dao.NoticeDAO;
import com.multi.cookies.board.notice.dto.NoticeDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class NoticeServiceImpl implements NoticeService {

    @Autowired
    private NoticeDAO dao;

    // 게시물 목록 + 페이징 + 검색
    @Override
    public List<NoticeDTO> list(
            int displayPost, int postNum, String searchType, String keyword) throws Exception {
        return  dao.list(displayPost, postNum, searchType, keyword);
    }

    // 게시물 작성
    @Override
    public void write(NoticeDTO dto) throws Exception {

        dao.write(dto);
    }

    // 게시물 조회
    @Override
    public NoticeDTO view(int bbs_id) throws Exception {

        return dao.view(bbs_id);
    }

    // 게시물 수정
    @Override
    public void update(NoticeDTO dto) throws Exception {

        dao.update(dto);
    }

    // 게시물 삭제
    @Override
    public void delete(int bbs_id) throws Exception {
        dao.delete(bbs_id);
    }



    // 게시물 총 갯수
    @Override
    public int count() throws Exception {
        return dao.count();
    }

    // 게시물 총 갯수
    @Override
    public int searchCount(String searchType, String keyword) throws Exception {
        return dao.searchCount(searchType, keyword);
    }

    // 조회수 업데이트
    @Override
    public void updateViews(int bbs_id) {
        try {
            dao.updateViews(bbs_id); // dao를 통해 메서드 호출
        } catch (Exception e) {
            e.printStackTrace();
            // 예외 처리
        }
    }
}
