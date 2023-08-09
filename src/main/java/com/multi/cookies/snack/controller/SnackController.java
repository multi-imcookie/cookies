package com.multi.cookies.snack.controller;

import com.multi.cookies.snack.service.SnackService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

@Controller
public class SnackController {

    @Autowired
    SnackService snackService;


}