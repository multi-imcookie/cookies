package com.multi.cookies.member.controller;


import com.multi.cookies.member.dto.LoginDTO;
import com.multi.cookies.member.service.KaKaoSocialLoginService;
import com.multi.cookies.member.service.LoginService;
import com.multi.cookies.member.service.NaverSocialLoginService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.PropertySource;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.Map;

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
    @GetMapping("/login")
    public String loginPage(Model model, HttpServletRequest request, HttpSession session) throws Exception {
        String naverApiUrl = naverSocialLoginService.naverApiURL(request, session);    //네이버 소셜로그인 apiURL ,social_login.properties 파일과연관
        String kakakoApiUrl = kaKaoSocialLoginService.kakaoApiURL(request);            //카카오 소셜로그인 apiURL ,social_login.properties 파일과연관
        String findUserOrPwdUrl = "/forgotUserNameOrPassWord";                         //유저 ID or 비밀번호찾기 URL
        String signUrl = "/member/sign.jsp";                                           //회원가입 URL
        String recentLogin=loginService.getCookie("login",request);
        model.addAttribute("naverApiUrl", naverApiUrl);
        model.addAttribute("kakakoApiUrl", kakakoApiUrl);
        model.addAttribute("findUserOrPwdUrl",findUserOrPwdUrl);
        model.addAttribute("signUrl",signUrl);
        model.addAttribute("recentLogin",recentLogin);
        return "member/login";
    }
    //전과자 자체 로그인 controller
    @PostMapping("/login")
    public String login(HttpServletResponse response,@RequestParam Map<String, String> map,HttpSession session) throws UnsupportedEncodingException {
        //to do 1):  id , password유효성검사 추가
        //to do 2):  비밀번호 암호화 추가
        if(!loginService.isValidPassWord(map)){                    //id ,pw 유효하지 않으면 -> 아이디 비밀번호가 일치 하지 않습니다.
            String msg = URLEncoder.encode("아이디 또는 패스워드가 일치하지 않습니다.","utf-8"); //todo :Exception처리
            return "redirect:/login?msg="+msg;
        }
        Cookie cookieId = new Cookie("id",map.get("username"));  // id , member_id 쿠키 제작
        Cookie recentLogin =loginService.recentLoginCookie("login","self","/login"); //최근로그인한 쿠키  자체로그인 or 카카오로그인 or 네이버로그인
        LoginDTO loginDTO = loginService.getMemberDTObyUserName((String)map.get("username"));
//        System.out.println("loginDTO = " + loginDTO);
        session.setAttribute("memberId", loginDTO.getMember_id());
        session.setAttribute("memberGrade", loginDTO.getMember_grade());
        session.setAttribute("memberNickName", loginDTO.getMember_nickname());
//        System.out.println("안녕");
        if(map.get("remember")==null){  //체크박스 체크 아닐시 , id저장 하지 않기
            cookieId.setMaxAge(0);
            response.addCookie(cookieId);
        }
        response.addCookie(recentLogin);
        return "redirect:/index.jsp"; //홈으로 이동
    }
    //  네이버 콜백
    @RequestMapping("/login/naver/callback")
    public String naverCallBack(String code, String state, HttpSession session,HttpServletResponse response) throws Exception {
        String accessToken = naverSocialLoginService.getToken(code, state);   //네이버 accessToken 얻기
        LoginDTO loginDTO = naverSocialLoginService.getUserInfo(accessToken); //accessToken으로 유저정보 얻기
        RegisterAndSession(loginDTO,session); //DB에 유저정보 저장 , session에 id값 저장
        Cookie recentLogin =loginService.recentLoginCookie("login","naver","/login");
        response.addCookie(recentLogin);
        return "redirect:/index.jsp";
    }
    //  카카오 콜백
    @RequestMapping("/login/kakao/callback")
    public String kakaoCallBack(String code, HttpSession session,HttpServletResponse response) throws Exception {
//        System.out.println("code" + code); //콜백 코드 출력
        String access_Token = kaKaoSocialLoginService.getToken(code);           //네이버 토큰값 얻기
        LoginDTO loginDTO = kaKaoSocialLoginService.getUserInfo(access_Token);  //토큰 값으로 유저 정보 얻기
        RegisterAndSession(loginDTO,session); //DB에 저장
        Cookie recentLogin =loginService.recentLoginCookie("login","kakao","/login");
        response.addCookie(recentLogin);
        return "redirect:/index.jsp";
    }
    // 아이디 비밀번호 찾기
    @GetMapping("/forgotUserNameOrPassWord")
    public String findIdAndPassWordPage(){
        return "member/findIdAndPassWordPage";
    }
    //로그아웃
    @RequestMapping("/logout")
    public String logOut(HttpSession session){
        session.invalidate();
        //from 네이버 개발자 센터
        //네이버 로그아웃에 대한 별도의 api가 없으며 사용자가 직접 네이버 서비스에서 로그아웃 하도록 처리하셔야 합니다.
        //이유는 이용자 보호를 위해 정책상 네이버 이외의 서비스에서 네이버 로그아웃을 수행하는 것을 허용하지 않고 있는 점 양해 부탁드립니다.
        return "redirect:/index.jsp";
    }
    private void RegisterAndSession(LoginDTO loginDTO,HttpSession session){
        boolean isTrue = loginService.hasRegisteredBefore(loginDTO);            //이전에 로그인한적이있는지 검사
        if (!isTrue) {                                                          //이전에 로그인한적없으면
            loginService.insertUserInfo(loginDTO);                              //DB에 로그인 정보 저장
        }
        LoginDTO DBloginDTO= loginService.getLoginDTOByKey(loginDTO);           //DB DTO 를 가져옴
        session.setAttribute("memberId", DBloginDTO.getMember_id());        //세션에 memberId 값 지정
        session.setAttribute("memberGrade", DBloginDTO.getMember_grade());
        session.setAttribute("memberNickName", DBloginDTO.getMember_nickname());
    }
}
