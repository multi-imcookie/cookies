package com.multi.cookies.board.notice.dao;

import com.multi.cookies.board.notice.dto.NoticeDTO;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.HashMap;
import java.util.List;

@Repository
public class NoticeDAOImpl implements NoticeDAO {

    @Autowired
    private SqlSession sql;

    private static String namespace = "notice";

    // 게시물 목록 + 페이징 + 검색
    @Override
    public List<NoticeDTO> list(
            int displayPost, int postNum, String searchType, String keyword) throws Exception {

        HashMap<String, Object> data = new HashMap<String, Object>();

        data.put("displayPost", displayPost);
        data.put("postNum", postNum);

        data.put("searchType", searchType);
        data.put("keyword", keyword);

        return sql.selectList(namespace + ".list", data);
    }

    // 게시물 작성
    @Override
    public void write(NoticeDTO dto) throws Exception {

        sql.insert(namespace + ".write", dto);
    }

    // 게시물 조회
    @Override
    public NoticeDTO view(int bbs_id) throws Exception {

        return sql.selectOne(namespace + ".view", bbs_id);
    }

    // 게시물 수정
    @Override
    public void update(NoticeDTO dto) throws Exception {
        sql.update(namespace + ".update", dto);
    }

    // 게시물 삭제
    @Override
    public void delete(int bbs_id) throws Exception {
        sql.delete(namespace + ".delete", bbs_id);
    }



    // 게시물 총 갯수
    @Override
    public int count() throws Exception {
        return sql.selectOne(namespace + ".count");
    }


    // 게시물 총 갯수 + 검색 적용
    @Override
    public int searchCount(String searchType, String keyword) throws Exception {

        HashMap<String, Object> data = new HashMap<String, Object>();

        data.put("searchType", searchType);
        data.put("keyword", keyword);

        return sql.selectOne(namespace + ".searchCount", data);
    }

    // 게시물 조회수 업데이트
    @Override
    public void updateViews(int bbs_id) throws Exception {
        sql.update(namespace + ".updateViews", bbs_id);
    }

}
