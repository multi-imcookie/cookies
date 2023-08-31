package com.multi.cookies.member.controller;

import com.multi.cookies.board.dto.BoardDTO;
import com.multi.cookies.board.dto.ReviewDTO;
import com.multi.cookies.member.dto.MypageDTO;
import com.multi.cookies.member.service.MypageService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
public class MypageController {
    @Autowired
    MypageService mypageService;

    @GetMapping("/mypage")
    public String mypage(HttpSession httpSession, Model model) {
        Integer memberId = (Integer) httpSession.getAttribute("memberId");

        if (memberId == null) {
            // 세션에 회원 번호가 없으면 로그인 페이지로 이동
            return "member/login";
        } else {
            // 세션에 회원 번호가 있으면 회원 정보를 가져와서 마이페이지로 이동
            MypageDTO memberDTO = mypageService.getMemberInfo(memberId);
            model.addAttribute("memberDTO", memberDTO);

            // 연령대 변환 로직
            String memberAge = mypageService.replaceMemberAge(memberDTO.getMember_age());
            model.addAttribute("memberAge", memberAge);

            // 작성한 리뷰 리스트 불러오기
            List<ReviewDTO> myReviews = mypageService.getMyReview(memberId);
            model.addAttribute("reviewDTO", myReviews);
            System.out.println("myReviews = " + myReviews);

            // 작성한 리뷰 리스트 불러오기
            List<BoardDTO> myBoards = mypageService.getMyBoard(memberId);
            model.addAttribute("boardDTO", myBoards);
            System.out.println("myBoards = " + myBoards);

            return "member/mypage";
        }
    }
}
