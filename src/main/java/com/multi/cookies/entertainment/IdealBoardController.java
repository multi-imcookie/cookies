package com.multi.cookies.entertainment;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import java.util.List;

@Controller
public class IdealBoardController {

    @Autowired
    IdealBoardDAO idealBoardDAO;

    @RequestMapping("idealReply")
    public void list(Model model) {
        List<IdealBoardDTO> list = idealBoardDAO.list();
        model.addAttribute("list",list);
    }

    @RequestMapping("idealInsert")
    public void insert(IdealBoardDTO idealBoardDTO) {
        int result = idealBoardDAO.insert(idealBoardDTO);
        System.out.println(result);
    }
}
