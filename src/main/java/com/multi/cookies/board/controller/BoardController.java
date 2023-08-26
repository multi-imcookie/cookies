package com.multi.cookies.board.controller;

import com.multi.cookies.board.dto.BoardDTO;
import com.multi.cookies.board.dto.Page;
import com.multi.cookies.board.dto.ReplyDTO;
import com.multi.cookies.board.service.BoardService;
import com.multi.cookies.board.service.ReplyService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import javax.inject.Inject;
import java.util.List;


@Controller
@RequestMapping("board")
public class BoardController {

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

        model.addAttribute("list", list);
        model.addAttribute("page", page);
        model.addAttribute("select", num);



    }


    // 게시물 작성 폼
    @RequestMapping(value = "write", method = RequestMethod.GET)
    public void Write() throws Exception {

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
        List<ReplyDTO> reply = null;
        reply = replyService.list(bbs_id);
        model.addAttribute("reply", reply);

    }

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

        return "redirect:/board/view?bbs_id=" + dto.getBbs_id();
    }

    // 게시물 삭제
    @RequestMapping(value = "delete", method = RequestMethod.GET)
    public String Delete(@RequestParam("bbs_id") int bbs_id) throws Exception {

        service.delete(bbs_id);

        return "redirect:/board/list?num=1";
    }


}
