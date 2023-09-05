package com.multi.cookies.board.controller;

import com.multi.cookies.board.dao.BoardDAO;
import com.multi.cookies.board.dto.BoardDTO;
import com.multi.cookies.board.dto.Page;
import com.multi.cookies.board.dto.ReplyDTO;
import com.multi.cookies.board.service.BoardService;
import com.multi.cookies.board.service.ReplyService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.inject.Inject;
import java.util.List;


@Controller
@RequestMapping("board")
public class BoardController {

    @Autowired
    private BoardDAO boardDAO;
    @Inject
    private BoardService service;

    @Inject
    private ReplyService replyService;

    // 게시물 목록 + 페이징 추가 + 검색
    @RequestMapping(value = "list", method = RequestMethod.GET)
    public void List(Model model, @RequestParam(value = "num", required = false, defaultValue = "1") int num,
                     @RequestParam(value = "searchType",required = false, defaultValue = "title") String searchType,
                     @RequestParam(value = "keyword",required = false, defaultValue = "") String keyword
    ) throws Exception {

        Page page = new Page();

        page.setNum(num);
        page.setCount(service.searchCount(searchType, keyword));

        // 검색 타입과 검색어
        page.setSearchType(searchType);
        page.setKeyword(keyword);

        List<BoardDTO> list = service.list(page.getDisplayPost(), page.getPostNum(), searchType, keyword);
        //list = service.list(page.getDisplayPost(), page.getPostNum(), searchType, keyword);

        model.addAttribute("listSize", list.size());
        model.addAttribute("list", list);
        model.addAttribute("page", page);
        model.addAttribute("select", num);



    }


//    //작성화면
//    @RequestMapping(value = "revWrite", method = RequestMethod.GET)
//    public String write() {
//        return "board/write";
//    }
    // 게시물 작성 폼
    @RequestMapping(value = "write", method = RequestMethod.GET)
    public String Write()  {
        return "board/write";
    }

    // 게시물 작성
    @RequestMapping(value = "write", method = RequestMethod.POST)
    public String postWrite(BoardDTO dto) throws Exception {
        service.write(dto);

        return "redirect:/board/list?num=1"; //서비스에서 게시물 작성 처리후 목록 페이지로 리다이렉트
    }

    // 게시물 조회
    @RequestMapping(value = "view", method = RequestMethod.GET)
    public void View(@RequestParam("bbs_id") int bbs_id, Model model) throws Exception {

        BoardDTO dto = service.view(bbs_id);

        model.addAttribute("view", dto);

        // 댓글 조회
        List<ReplyDTO> reply = replyService.list(bbs_id);
        model.addAttribute("reply", reply);

        // 게시물 조회 시, 조회수 업데이트
        service.updateViews(bbs_id); // 이 부분을 추가합니다.

    }
//    // 게시물 조회
//    @RequestMapping(value = "view", method = RequestMethod.GET)
//    public void View(@RequestParam("bbs_id") int bbs_id, HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
//
//        BoardDTO dto = service.view(bbs_id);
//
//        model.addAttribute("view", dto);
//
//        // 댓글 조회
//        List<ReplyDTO> reply = replyService.list(bbs_id);
//        model.addAttribute("reply", reply);
//
//        // 쿠키 관련 코드 추가
//        viewCountUp(bbs_id, request, response);
//
//    }
//
//    // 조회수 중복 방지를 위한 쿠키 로직
//    private void viewCountUp(int bbs_id, HttpServletRequest request, HttpServletResponse response) {
//        Cookie oldCookie = null;
//        Cookie[] cookies = request.getCookies();
//        if (cookies != null) {
//            for (Cookie cookie : cookies) {
//                if (cookie.getName().equals("postView")) {
//                    oldCookie = cookie;
//                }
//            }
//        }
//
//        if (oldCookie != null) {
//            if (!oldCookie.getValue().contains("[" + bbs_id + "]")) {
//                service.updateViews(bbs_id); // 조회수 증가
//                oldCookie.setValue(oldCookie.getValue() + "_[" + bbs_id + "]");
//                oldCookie.setPath("/");
//                oldCookie.setMaxAge(60 * 60 * 24); // 쿠키 유효 기간 설정 (예: 1일)
//                response.addCookie(oldCookie);
//            }
//        } else {
//            service.updateViews(bbs_id); // 조회수 증가
//            Cookie newCookie = new Cookie("postView", "[" + bbs_id + "]");
//            newCookie.setPath("/");
//            newCookie.setMaxAge(60 * 60 * 24); // 쿠키 유효 기간 설정 (예: 1일)
//            response.addCookie(newCookie);
//        }
//    }

    // 게시물 수정 폼
    @RequestMapping(value = "update", method = RequestMethod.GET)
    public void Update(@RequestParam("bbs_id") int bbs_id, Model model) throws Exception {

        BoardDTO dto = service.view(bbs_id);

        model.addAttribute("view", dto);
    }

    // 게시물 수정
    @RequestMapping(value = "update", method = RequestMethod.POST)
    public String Update(BoardDTO dto) throws Exception {

        service.update(dto);

        return "redirect:/board/view?bbs_id=" + dto.getBbs_id(); //현재 bbs_id에 해당되는 조회페이지로 이동
    }

    // 게시물 삭제
    @RequestMapping(value = "delete", method = RequestMethod.GET)
    public String Delete(@RequestParam("bbs_id") int bbs_id) throws Exception {

        service.delete(bbs_id);

        return "redirect:/board/list?num=1";
    }

    @RequestMapping("/updateViews")
    @ResponseBody
    public String updateViews(@RequestParam("bbs_id") int bbs_id) {
        try {
            // snackId를 기반으로 DB 업데이트 수행
            boardDAO.updateViews(bbs_id);
            return "Success"; // 성공 시 메시지 반환
        } catch (Exception e) {
            e.printStackTrace();
            return "Error"; // 실패 시 메시지 반환
        }
    }

}
