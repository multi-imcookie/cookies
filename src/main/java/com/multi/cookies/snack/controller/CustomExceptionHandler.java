package com.multi.cookies.snack.controller;

import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.method.annotation.ResponseEntityExceptionHandler;

@ControllerAdvice
public class CustomExceptionHandler extends ResponseEntityExceptionHandler {

    @ExceptionHandler(RuntimeException.class)
    public ModelAndView handleRuntimeException(RuntimeException e) {
        ModelAndView modelAndView = new ModelAndView("/error/runtimeErrorPage");
        modelAndView.addObject("errorMessage", e.getMessage());
        return modelAndView;
    }

    // 다른 예외 처리 메서드도 추가 가능
}