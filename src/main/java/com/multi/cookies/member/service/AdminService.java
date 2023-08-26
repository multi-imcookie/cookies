package com.multi.cookies.member.service;

import com.multi.cookies.member.dao.AdminDAO;
import com.multi.cookies.member.dto.AdminDTO;
import com.multi.cookies.member.dto.MemberDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class AdminService {
    @Autowired
    private AdminDAO adminDao;

    public Map<String, Object> getMembers(int page) {
        int pageSize = 20; // 페이지당 표시될 회원 수
        int start = (page - 1) * pageSize;
        List<AdminDTO> members = adminDao.getAllMembers(start, pageSize);

        int totalMembers = adminDao.getTotalMembers();
        int totalPages = (int) Math.ceil((double) totalMembers / pageSize);

        int startPage = ((page - 1) / 10) * 10 + 1; // 시작 페이지 계산
        int endPage = Math.min(startPage + 9, totalPages); // 끝 페이지 계산

        Map<String, Object> result = new HashMap<>();
        result.put("members", members);
        result.put("currentPage", page);
        result.put("totalPages", totalPages);
        result.put("startPage", startPage); // startPage를 Map에 추가
        result.put("endPage", endPage); // endPage를 Map에 추가

        return result;
    }
    // 검색 기능 추가
    public List<AdminDTO> searchMembers(String type, String keyword) {
        Map<String, String> params = new HashMap<>();
        params.put("type", type);
        params.put("keyword", keyword);
        return adminDao.searchMembers(params);
    }


    // 특정 회원 정보 가져오기
    public AdminDTO getMemberById(int id) {
        return adminDao.getMemberById(id);
    }

    // 회원 정보 수정
    public void updateMember(int id, AdminDTO member) {
        adminDao.updateMember(id, member);
    }

    // 회원 생성
    public void createMember(MemberDTO member) {
        adminDao.createMember(member);
    }

    // 회원 삭제
    public void deleteMember(int id) {
        adminDao.deleteMember(id);
    }
}
