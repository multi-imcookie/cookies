package com.multi.cookies.board.notice.controller;

import com.multi.cookies.board.notice.dto.Page;
import com.multi.cookies.board.notice.dao.NoticeDAO;
import com.multi.cookies.board.notice.dto.NoticeDTO;
import com.multi.cookies.board.notice.service.NoticeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;


@Controller
@RequestMapping("/board/notice")
public class NoticeController {

    @Autowired
    private NoticeDAO noticeDAO;
    
    @Autowired
    private NoticeService noticeService;

    // 게시물 목록 + 페이징 추가 + 검색
    @RequestMapping(value = "list", method = RequestMethod.GET)
    public void List(Model model, @RequestParam(value = "num", required = false, defaultValue = "1") int num,
                     @RequestParam(value = "searchType",required = false, defaultValue = "title") String searchType,
                     @RequestParam(value = "keyword",required = false, defaultValue = "") String keyword
    ) throws Exception {

        Page page = new Page();
        int count = noticeDAO.count();
        page.setNum(num);
        page.setCount(noticeService.searchCount(searchType, keyword));

        // 검색 타입과 검색어
        page.setSearchType(searchType);
        page.setKeyword(keyword);

        List<NoticeDTO> list = noticeService.list(page.getDisplayPost(), page.getPostNum(), searchType, keyword);
        //list = service.list(page.getDisplayPost(), page.getPostNum(), searchType, keyword);

        model.addAttribute("count", count);
        model.addAttribute("list", list);
        model.addAttribute("page", page);
        model.addAttribute("select", num);



    }
    
    // 게시물 작성 폼
    @RequestMapping(value = "write", method = RequestMethod.GET)
    public String Write()  {
        return "board/notice/write";
    }

    // 게시물 작성
    @RequestMapping(value = "write", method = RequestMethod.POST)
    public String postWrite(NoticeDTO dto) throws Exception {
        noticeService.write(dto);

        return "redirect:/board/notice/list?num=1"; //서비스에서 게시물 작성 처리후 목록 페이지로 리다이렉트
    }

    // 게시물 조회
    @RequestMapping(value = "view", method = RequestMethod.GET)
    public void View(@RequestParam("notice_id") int notice_id, Model model) throws Exception {

        NoticeDTO dto = noticeService.view(notice_id);

        model.addAttribute("view", dto);

        // 게시물 조회 시, 조회수 업데이트
        noticeService.updateViews(notice_id); // 이 부분을 추가합니다.

    }

    // 게시물 수정 폼
    @RequestMapping(value = "update", method = RequestMethod.GET)
    public void Update(@RequestParam("notice_id") int notice_id, Model model) throws Exception {

        NoticeDTO dto = noticeService.view(notice_id);

        model.addAttribute("view", dto);
    }

    // 게시물 수정
    @RequestMapping(value = "update", method = RequestMethod.POST)
    public String Update(NoticeDTO dto) throws Exception {

        noticeService.update(dto);

        return "redirect:/board/notice/view?notice_id=" + dto.getNotice_id(); //현재 bbs_id에 해당되는 조회페이지로 이동
    }

    // 게시물 삭제
    @RequestMapping(value = "delete", method = RequestMethod.GET)
    public String Delete(@RequestParam("notice_id") int notice_id) throws Exception {

        noticeService.delete(notice_id);

        return "redirect:/board/notice/list?num=1";
    }

    @RequestMapping("/updateViews")
    @ResponseBody
    public String updateViews(@RequestParam("notice_id") int notice_id) {
        try {
            // snackId를 기반으로 DB 업데이트 수행
            noticeDAO.updateViews(notice_id);
            return "Success"; // 성공 시 메시지 반환
        } catch (Exception e) {
            e.printStackTrace();
            return "Error"; // 실패 시 메시지 반환
        }
    }

}
