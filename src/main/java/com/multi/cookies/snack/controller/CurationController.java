package com.multi.cookies.snack.controller;

import com.multi.cookies.snack.service.CurationService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.Map;
@Controller
public class CurationController {

    @Autowired
    CurationService curationService;

    @RequestMapping("curation/curationStepOne")
    public String curationStepOne(@RequestParam Map<String, String> checkedAllergy){
        System.out.println("나 컨트롤러다!");
        curationService.checkedAllergy(checkedAllergy);
       return "curation";
    }

}
