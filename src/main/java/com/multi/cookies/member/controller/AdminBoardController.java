package com.multi.cookies.member.controller;

import com.multi.cookies.member.dto.AdminBoardDTO;
import com.multi.cookies.member.service.AdminBoardService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
public class AdminBoardController {
    @Autowired
    private AdminBoardService adminBoardService;

    @GetMapping("/boards")
    public String listBoards(@RequestParam(defaultValue = "1") int page,
                             @RequestParam(required = false) String searchType,
                             @RequestParam(required = false) String keyword,
                             Model model) {
        model.addAttribute("boardsWithPaging", adminBoardService.getBoards(searchType, keyword, page));
        return "member/boards";
    }

    @GetMapping("/board/{id}")
    public String getBoardById(@PathVariable int id, Model model) {
        model.addAttribute("board", adminBoardService.getBoardById(id));
        return "member/viewboard";
    }

    @GetMapping("/update/{id}")
    public String updateForm(@PathVariable int id, Model model) {
        AdminBoardDTO board = adminBoardService.getBoardById(id);
        model.addAttribute("board", board);
        return "member/editBoard";
    }

    @GetMapping("/delete/{id}")
    public String delete(@PathVariable int id) {
        adminBoardService.deleteBoard(id);
        return "redirect:/boards";
    }

    @GetMapping("/view/{id}")
    public String view(@PathVariable int id, Model model) {
        AdminBoardDTO board = adminBoardService.getBoardById(id);
        model.addAttribute("board", board);
        return "member/viewboard";
    }
}

