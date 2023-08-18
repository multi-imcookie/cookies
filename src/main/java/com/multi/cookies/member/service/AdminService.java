package com.multi.cookies.member.service;

import com.multi.cookies.member.dao.AdminDAO;
import com.multi.cookies.member.dto.AdminDTO;
import com.multi.cookies.member.dto.MemberDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class AdminService {
    @Autowired
    private AdminDAO adminDao;

    // 모든 회원 정보 가져오기
    public List<AdminDTO> getAllMembers() {
        return adminDao.getAllMembers();
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

