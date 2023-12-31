package com.multi.cookies.member.controller;

import com.multi.cookies.board.dto.BoardDTO;
import com.multi.cookies.board.dto.ReviewDTO;
import com.multi.cookies.member.dto.MemberDTO;
import com.multi.cookies.member.dto.MypageDTO;
import com.multi.cookies.member.service.MypageService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.lang.reflect.Member;
import java.util.List;
import java.util.Objects;

@Controller
public class MypageController {
    @Autowired
    MypageService mypageService;

    @GetMapping("/mypage")
    public String mypage(HttpSession httpSession, Model model) {
        System.out.println("-----------4");
        Integer memberId = (Integer) httpSession.getAttribute("memberId");
        if (memberId == null) {
            // 세션에 회원 번호가 없으면 로그인 페이지로 이동
            return "member/login";
        } else {

            // 세션에 회원 번호가 있으면 회원 정보를 가져와서 마이페이지로 이동
            MypageDTO memberDTO = mypageService.getMemberInfo(memberId);
            System.out.println(memberDTO);
            model.addAttribute("memberDTO", memberDTO);

            // 연령대 변환 로직
            String memberAge = mypageService.replaceMemberAge(memberDTO.getMember_age());
            model.addAttribute("memberAge", memberAge);

            // 작성한 리뷰 리스트 불러오기
            List<ReviewDTO> myReviews = mypageService.getMyReview(memberId);
            model.addAttribute("reviewDTO", myReviews);

            // 작성한 리뷰 리스트 불러오기
            List<BoardDTO> myBoards = mypageService.getMyBoard(memberId);
            model.addAttribute("boardDTO", myBoards);

            return "member/mypage";
        }
    }

    @GetMapping("/editMyInfo")
    public String editMyInfo(HttpSession httpSession, Model model) {
        // 로그인된 회원의 정보를 가져와서 폼에 기본 값으로 설정
        Integer memberId = (Integer) httpSession.getAttribute("memberId");
        System.out.println("-----------3");
        if (memberId == null) {
            // 세션에 회원 번호가 없으면 로그인 페이지로 이동
            return "member/login";
        } else {
            MypageDTO memberDTO = mypageService.getMemberInfo(memberId);
            model.addAttribute("memberDTO", memberDTO);
            return "member/editMyInfo"; // 수정 화면으로 이동
        }
    }

    @RequestMapping("/checkMyPw")
    @ResponseBody
    public String checkPassword(int member_id, String chkMemberPw, Model model) {
        boolean result = mypageService.checkMyPw(member_id, chkMemberPw);
        if (!mypageService.checkMyPw(member_id, chkMemberPw)) {
            return "member/mypage";
        }
        model.addAttribute("result", result);
        return "member/editMyPassword";
    }

    @PostMapping("/updateMemberInfo")
    public String updateMemberInfo(MypageDTO mypageDTO, HttpSession httpSession, Model model) {

        System.out.println("--------------2");
        int result = mypageService.updateMemberInfo(mypageDTO);
        if (result > 0) {
            // 업데이트가 성공하면 세션 정보도 업데이트
            httpSession.setAttribute("memberNickName", mypageDTO.getMember_nickname());
            httpSession.setAttribute("memberEmail", mypageDTO.getMember_email());
            httpSession.setAttribute("memberPhone", mypageDTO.getMember_phone());
        } else {
            return "회원 정보 수정에 실패했습니다.";
        }


        model.addAttribute("result", result);
        return "member/editMyInfo";
    }

    @PostMapping("/uploadProfile")
    public String uploadProfileImage(@RequestParam("member_profile") MultipartFile file,
                                     HttpSession httpSession,
                                     Model model
                                     ) throws IOException {
        Integer memberId = (Integer) httpSession.getAttribute("memberId");
        System.out.println("-------------1");
        // 프로필 이미지 저장
        String profileUrl = mypageService.saveProfile(file, memberId);
        System.out.println("profileUrl = " + profileUrl);

        // 회원 프로필 업데이트
        mypageService.updateProfile(memberId, profileUrl);

        return "redirect:/mypage";
    }

    @ModelAttribute("/getProfile")
    public String getProfile(HttpSession httpSession) {
        int memberId = (int) httpSession.getAttribute("memberId");
        return mypageService.getProfile(memberId);
    }

    @RequestMapping("/deleteProfile")
    public String deleteProfile(HttpSession httpSession) {
        Integer memberId = (Integer) httpSession.getAttribute("memberId");
        mypageService.deleteProfile(memberId);
        return "redirect:/mypage";
    }

}
