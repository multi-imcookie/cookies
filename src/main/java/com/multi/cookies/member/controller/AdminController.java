package com.multi.cookies.member.controller;

import com.multi.cookies.member.dto.AdminDTO;
import com.multi.cookies.member.service.AdminService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class AdminController {
    @Autowired
    private AdminService adminservice;

    // 회원 목록 조회
    @RequestMapping("/members")
    public String list(@RequestParam(value = "page", defaultValue = "1") int page, Model model) {
        Map<String, Object> membersWithPaging = adminservice.getMembers(page); // 페이징 처리 추가
        model.addAttribute("membersWithPaging", membersWithPaging);
        return "member/members";
    }
    // 검색 기능 추가
    @RequestMapping("/members/search")
    public String search(@RequestParam String type, @RequestParam String keyword, Model model) {
        List<AdminDTO> members = adminservice.searchMembers(type, keyword);
        Map<String, Object> membersWithPaging = new HashMap<>();
        membersWithPaging.put("members", members);
        // 필요한 경우 여기에 페이징 정보도 추가
        model.addAttribute("membersWithPaging", membersWithPaging);
        return "member/members";
    }

    // 회원 상세 조회
    @RequestMapping ("/members/{id}")
    public String view(@PathVariable int id, Model model) {
        AdminDTO member = adminservice.getMemberById(id);
        model.addAttribute("member", member);
        return "member/viewMember";
    }

    // 회원 수정 페이지로 이동
    @RequestMapping("/members/{id}/edit")
    public String edit(@PathVariable int id, Model model) {
        AdminDTO member = adminservice.getMemberById(id);
        model.addAttribute("member", member);
        return "member/editMember";
    }


    // 회원 수정 처리
    @PostMapping("/members/{id}/update")
    public String update(@PathVariable int id, AdminDTO member) {
        adminservice.updateMember(id, member);
        return "redirect:/members";
    }

    // 회원 삭제 처리
    @GetMapping("/members/{id}/delete")
    public String delete(@PathVariable int id) {
        adminservice.deleteMember(id);
        return "redirect:/members";
    }
}

