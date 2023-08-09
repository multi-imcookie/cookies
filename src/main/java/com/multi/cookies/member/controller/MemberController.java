package com.multi.cookies.member.controller;

import com.multi.cookies.member.service.KaKaoSocialLoginService;
import com.multi.cookies.member.service.NaverSocialLoginService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.PropertySource;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.ArrayList;

@Controller
@PropertySource("classpath:social_login.properties")
public class MemberController {
    @Autowired
    KaKaoSocialLoginService kaKaoSocialLoginService;
    @Autowired
    NaverSocialLoginService naverSocialLoginService;
    @RequestMapping("/login")
    public String loginPage(Model model, HttpServletRequest request, HttpSession session) throws Exception {
        String apiURL = naverSocialLoginService.naverApiURL(request, session);
        System.out.println("apiURL = " + apiURL);
        //apiURL = https://nid.naver.com/oauth2.0/authorize?response_type=code&client_id=aHD7wrSDGZvsxciwunHI&redirect_uri=http%3A%2F%2Flocalhost%3A8989%2Flogin%2Fnaver%2Fcallback&state=954986350460963047069329269706370142955
        model.addAttribute("apiURL", apiURL);
        return "member/login";
    }

    @RequestMapping("/login/naver/callback")
    public String naverCallBack(String code, String state, HttpSession session, Model model) throws Exception {
        String access_token = naverSocialLoginService.getToken(code, state, session);
        System.out.println("access_token = " + access_token);
        StringBuffer userInfo=naverSocialLoginService.getUserInfo(access_token);
        System.out.println("stringBuffer = " + userInfo);
        model.addAttribute("userInfo",userInfo);
        return "loginSuccess";
    }
    @RequestMapping("/login/kakao/callback")
    public String kakaoCallBack(String code, String state, HttpSession session, Model model){
        System.out.println("#########" + code);
        String access_Token = kaKaoSocialLoginService.getAccessToken(code);
        ArrayList list = kaKaoSocialLoginService.getUserInfo(access_Token);
        System.out.println("###access_Token#### : " + access_Token);
    return "member/loginSuccess";
    }

}