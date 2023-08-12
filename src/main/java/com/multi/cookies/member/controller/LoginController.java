package com.multi.cookies.member.controller;


import com.multi.cookies.member.dto.LoginDTO;
import com.multi.cookies.member.service.KaKaoSocialLoginService;
import com.multi.cookies.member.service.LoginService;
import com.multi.cookies.member.service.NaverSocialLoginService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.PropertySource;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

@Controller
@PropertySource("classpath:social_login.properties")
public class LoginController {
    @Autowired
    KaKaoSocialLoginService kaKaoSocialLoginService;
    @Autowired
    NaverSocialLoginService naverSocialLoginService;
    @Autowired
    LoginService loginService;

    //  로그인 화면 controller
    @RequestMapping("/login")
    public String loginPage(Model model, HttpServletRequest request, HttpSession session) throws Exception {
        String naverApiUrl = naverSocialLoginService.naverApiURL(request, session);
        String kakakoApiUrl = kaKaoSocialLoginService.kakaoApiURL(request);
//        System.out.println("naverApiUrl = " + naverApiUrl);
//        System.out.println("naverApiUrl = " + kakakoApiUrl);
/* 네이버 요청URL
 naverApiUrl = https://nid.naver.com/oauth2.0/authorize
 ?response_type=code&client_id=aHD7wrSDGZvsxciwunHI
 &redirect_uri=http%3A231Flocalhost%3A8989%2Flogin%2312Fnaver%2Fcallback
 &state=954986350460963047069329269706370142955*/
        model.addAttribute("naverApiUrl", naverApiUrl);
        model.addAttribute("kakakoApiUrl", kakakoApiUrl);
        return "member/login";
    }
    @PostMapping("/login")
    public String login(@RequestParam("username")String id,@RequestParam("password")String password){
        //id,password유효성검사 추가
        System.out.println("id  +  password = "+ id + "  "+ password);
        //비밀번호 암호화 추가
        if(!(loginService.isValidPassWord(id,password))){
            return "redirect:/login";
        }
        return "idealReply";
    }


    //  네이버 콜백
    @RequestMapping("/login/naver/callback")
    public String naverCallBack(String code, String state, HttpSession session, Model model, HttpServletRequest request) throws Exception {
        String accessToken = naverSocialLoginService.getToken(code, state, session);
        LoginDTO loginDTO = naverSocialLoginService.getUserInfo(accessToken);
        boolean isTrue = loginService.hasRegisteredBefore(loginDTO);
        session.setAttribute("token", loginDTO.getNaver_login());
        if (!isTrue) {
            loginService.inserUserInfo(loginDTO);
            return "idealReply";
        }
//        System.out.println("access_token = " + access_token);
//        System.out.println("stringBuffer = " + userInfo);
        return "idealReply";
//        return "index";//뷰 안의index.jsp 찾아감
//        return "redirect:/index.jsp"; //리다이렉트로 유저에게 떠넘김
    }

    //  카카오 콜백
    @RequestMapping("/login/kakao/callback")
    public String kakaoCallBack(String code, String state, HttpSession session, Model model, HttpServletRequest request) throws Exception {
//        System.out.println("code" + code); //콜백 코드 출력
        String access_Token = kaKaoSocialLoginService.getToken(code);
        LoginDTO loginDTO = kaKaoSocialLoginService.getUserInfo(access_Token);
//        System.out.println("userInfo " + loginDTO);  //dto 출력
//        kaKaoSocialLoginService.insert();
        boolean isTrue = loginService.hasRegisteredBefore(loginDTO);
        session.setAttribute("token", loginDTO.getKakao_login());
        if (!isTrue) {
            loginService.inserUserInfo(loginDTO);
            return "redirect:" + "/idealReply";
        }
        return "redirect:" + "/idealReply";
        //질문 controller거친후 WEB-INF > views 안의 jsp말고 외부접근 가능한 WEB-INF의 index.jsp로 쉽게 가는법은??
        // 1?     return "index";//뷰 안의index.jsp 찾아감
        // 2?     return "redirect:/index.jsp"; //리다이렉트로 유저에게 떠넘김
        // 3?     index.jsp 로 간후 callback과 코드 state 등이남아있음 다시 리다이렉트? URL재작성?
    }
}