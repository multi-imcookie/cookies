package com.multi.cookies.member.controller;

import com.multi.cookies.member.dto.AdminBoardDTO;
import com.multi.cookies.member.service.AdminBoardService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class AdminBoardController {

    @Autowired
    private AdminBoardService adminBoardService;

    @GetMapping("/boards")
    public String listBoards(@RequestParam(defaultValue = "1") int page, Model model) {
        Map<String, Object> boardsWithPaging = adminBoardService.getBoards(page);
        model.addAttribute("boardsWithPaging", boardsWithPaging);
        return "member/boards";
    }

    @GetMapping("/boards/search")
    public String searchBoards(@RequestParam String searchType, @RequestParam String keyword,
                               @RequestParam(defaultValue = "1") int page, Model model) {
        Map<String, Object> boardsWithPaging = adminBoardService.getBoards(searchType, keyword, page);
        model.addAttribute("boardsWithPaging", boardsWithPaging);
        return "member/boards";
    }

    @GetMapping("/boards/{id}")
    public String getBoardById(@PathVariable int id, Model model) {
        AdminBoardDTO board = adminBoardService.getBoardById(id);
        model.addAttribute("board", board);
        return "member/viewBoard";
    }

    @GetMapping("/boards/{id}/edit")
    public String updateForm(@PathVariable int id, Model model) {
        AdminBoardDTO board = adminBoardService.getBoardById(id);
        model.addAttribute("board", board);
        return "member/editBoard";
    }

    @PostMapping("/boards/{id}/update")
    public String update(@PathVariable int id, AdminBoardDTO board) {
        adminBoardService.updateBoard(id, board);
        return "redirect:/boards";
    }

    @GetMapping("/boards/{id}/delete")
    public String delete(@PathVariable int id) {
        adminBoardService.deleteBoard(id);
        return "redirect:/boards";
    }
}


