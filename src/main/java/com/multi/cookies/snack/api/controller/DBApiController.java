package com.multi.cookies.snack.api.controller;

import com.multi.cookies.snack.api.dto.DBApiDTO;
import com.multi.cookies.snack.api.service.DBApiService;
import org.json.simple.parser.ParseException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.PropertySource;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@Controller
@RequestMapping("api")
@PropertySource("classpath:apikey.properties")
public class DBApiController {

    @Autowired
    DBApiService dbApiService;

    @RequestMapping("updateDB")
    public String updateDB(Model model) throws ParseException, IOException { // DB 최신화
        int result = dbApiService.updateDB();
        model.addAttribute("result", result);
        return "/api/updateDB";
    }

    @GetMapping(value = "searchSnackId", produces = "application/text; charset=utf8")
    @ResponseBody
    public String searchSnackId(@RequestParam("snack_name") String snack_name) {
        String result = dbApiService.searchDB(snack_name).toString();
        return result;
    }

    @GetMapping("deleteDB")
    @ResponseBody
    public void deleteDB(@RequestParam("snack_id") int snack_id, Model model) {   // DB 단건삭제
        System.out.println(snack_id);
        int result = dbApiService.deleteDB(snack_id);
        model.addAttribute("result", result);
    }

    @PostMapping("insertDB")
    @ResponseBody
    public void insertDB(DBApiDTO dbApiDTO, Model model) {
        System.out.println(dbApiDTO);
        int result = dbApiService.insertDB(dbApiDTO);
        model.addAttribute("result", result);
    }
}
