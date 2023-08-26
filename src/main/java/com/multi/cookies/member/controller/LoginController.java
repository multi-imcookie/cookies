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
        model.addAttribute("naverApiUrl", naverApiUrl);
        model.addAttribute("kakakoApiUrl", kakakoApiUrl);
        model.addAttribute("findUserOrPwdUrl",findUserOrPwdUrl);
        model.addAttribute("signUrl",signUrl);
        return "member/login";
    }
    //전과자 자체 로그인 controller
    @PostMapping("/login")
    public String login(HttpServletResponse response,@RequestParam Map<String, String> map,HttpSession session) throws UnsupportedEncodingException {
        //to do 1):  id , password유효성검사 추가
        //to do 2):  비밀번호 암호화 추가
        if(!(loginService.isValidPassWord(map))){                    //id ,pw 유효하지 않으면 -> 아이디 비밀번호가 일치 하지 않습니다.
            String msg = URLEncoder.encode("아이디 또는 패스워드가 일치하지 않습니다.","utf-8"); //todo :Exception처리
            return "redirect:/login?msg="+msg;
        }
        Cookie cookieId = new Cookie("id",map.get("username"));  //id pw 일치시 쿠키 생성
        LoginDTO loginDTO = loginService.getUserInfo(map);
//        System.out.println("loginDTO = " + loginDTO);
        session.setAttribute("memberId", loginDTO.getMember_id());
        session.setAttribute("memberNickName", loginDTO.getMember_nickname());
        if(map.get("remember")==null){  //체크박스 체크 아닐시 , id저장 하지 않기
            cookieId.setMaxAge(0);
            response.addCookie(cookieId);
        }else{
            response.addCookie(cookieId);   //체크박스 체크시 id저장
        }
        return "redirect:/index.jsp"; //홈으로 이동
    }
    //  네이버 콜백
    @RequestMapping("/login/naver/callback")
    public String naverCallBack(String code, String state, HttpSession session) throws Exception {
        String accessToken = naverSocialLoginService.getToken(code, state);   //네이버 accessToken 얻기
        LoginDTO loginDTO = naverSocialLoginService.getUserInfo(accessToken); //accessToken으로 유저정보 얻기
        boolean isTrue = loginService.hasRegisteredBefore(loginDTO);          //네이버로 로그인한적이 있는지 확인
        if (!isTrue) {                                                        //행사용 네이버 최초 로그인 확인
            loginService.insertUserInfo(loginDTO);
            return "redirect:/index.jsp";
        }
//        System.out.println("access_token = " + access_token);
//        System.out.println("stringBuffer = " + userInfo);
        session.setAttribute("memberId", loginDTO.getMember_id());
        session.setAttribute("memberNickName", loginDTO.getMember_nickname());       //세션에 로그인 고유값 넣기 ?! 뭘넣지?
        return "redirect:/index.jsp";
    }
    //  카카오 콜백
    @RequestMapping("/login/kakao/callback")
    public String kakaoCallBack(String code, HttpSession session) throws Exception {
//        System.out.println("code" + code); //콜백 코드 출력
        String access_Token = kaKaoSocialLoginService.getToken(code);           //네이버 토큰값 얻기
        LoginDTO loginDTO = kaKaoSocialLoginService.getUserInfo(access_Token);  //토큰 값으로 유저 정보 얻기
//        System.out.println("userInfo " + loginDTO);  //dto 출력
        boolean isTrue = loginService.hasRegisteredBefore(loginDTO);            //이전에 카카오로 로그인했었는지 확인
        if (!isTrue) {                                                          //언젠간 사용할  - 최초로그인시...
            loginService.insertUserInfo(loginDTO);
            return "redirect:/index.jsp";
        }
        session.setAttribute("memberId", loginDTO.getMember_id());
        session.setAttribute("memberNickName", loginDTO.getMember_nickname());
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
}
