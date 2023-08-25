package com.multi.cookies.member.service;

import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.multi.cookies.member.dto.LoginDTO;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.env.Environment;
import org.springframework.stereotype.Service;

import javax.annotation.PostConstruct;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.math.BigInteger;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.security.SecureRandom;

@Service
public class NaverSocialLoginService {
    /* social_login.properties를 참조하여 초기화*/
    @Autowired
    private LoginService loginService;
    @Autowired
    private Environment env;
    private String naverClientId; //네이버클라이언트 ID
    private String naverClientSecret; //네이버Secretkey
    private String naverCallBackURL; //네이버콜백URI
    @PostConstruct
    public void init() {
        naverClientId = env.getProperty("naver.clientId");
        naverClientSecret = env.getProperty("naver.clientSecret");
        naverCallBackURL = env.getProperty("naver.callBackURL");
    }
    //네이버 로그인 토큰 얻기
    public String getToken(String code, String state)throws Exception{
        String redirectURI = URLEncoder.encode("http://localhost:8989/member/callback.jsp","UTF-8");
        StringBuffer apiURL = new StringBuffer();
        apiURL.append("https://nid.naver.com/oauth2.0/token?grant_type=authorization_code&");
        apiURL.append("client_id=" + naverClientId);
        apiURL.append("&client_secret=" + naverClientSecret);
        apiURL.append("&redirect_uri=" + redirectURI);
        apiURL.append("&code=" + code);
        apiURL.append("&state=" + state);
        String access_token = "";
        String refresh_token = ""; //나중에 이용합시다
        try {
            URL url = new URL(apiURL.toString());
            HttpURLConnection con = (HttpURLConnection)url.openConnection();
            con.setRequestMethod("GET");
            int responseCode = con.getResponseCode();
            BufferedReader br;
//            System.out.println("responseCode="+responseCode);

            if(!(responseCode==200)) { // 에러
                br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
            }

            br = new BufferedReader(new InputStreamReader(con.getInputStream()));
            String inputLine="";
            StringBuffer res = new StringBuffer();
            while ((inputLine = br.readLine()) != null) {
                res.append(inputLine);
            }
            br.close();
            if(responseCode==200) {
                JSONParser parsing = new JSONParser();
                Object obj = parsing.parse(res.toString());
                JSONObject jsonObj = (JSONObject) obj;

                access_token = (String) jsonObj.get("access_token");
                refresh_token = (String) jsonObj.get("refresh_token");
                String header = "Bearer " + access_token;
            }
        } catch (Exception e) {
            System.out.println(e);
        }
        return access_token;
    }
    // 얻은 토큰으로 네이버 유저정보 얻고 -> DTO로 변환
    public LoginDTO getUserInfo(String access_token) throws Exception{
        BufferedReader br;
        StringBuffer stringBuffer = new StringBuffer();
        String apiurl = "https://openapi.naver.com/v1/nid/me";
        URL url = new URL(apiurl);
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("GET");
        conn.setRequestProperty("Authorization", "Bearer " + access_token);
        int responseCode = conn.getResponseCode();

        if (!(responseCode == 200)) { //에러 발생
            br = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
            return null;
        }
        br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
        String inputLine = "";
        while ((inputLine = br.readLine()) != null) {
            stringBuffer.append(inputLine);
        }
        br.close();
//        System.out.println("네이버 유저 정보 = " + stringBuffer);
        return parserUserInfo(stringBuffer.toString());
    }
    //   /login 요청시  네이버 api URL 반환
    public String naverApiURL(HttpServletRequest request,HttpSession session)throws Exception{
        String state = naverApiState(session);
        String contextPath = request.getContextPath();
        String callbackURL = request.getRequestURL().toString().replace(contextPath, "");
//        System.out.println("callbackURL = " + callbackURL); //callbackURL = http://localhost:8989/login
        String redirectURI = URLEncoder.encode(callbackURL+naverCallBackURL, "UTF-8"); //callbackURL = http://localhost:8989/login/naver.callBackURL

        String apiURL = new StringBuilder("https://nid.naver.com/oauth2.0/authorize?response_type=code")
                .append("&client_id=").append(naverClientId)
                .append("&redirect_uri=").append(redirectURI)
                .append("&state=").append(state)
                .toString();
        return apiURL;
    }
    //csrf 방지를 위한 랜덤난수 생성
    private String naverApiState(HttpSession session){
        SecureRandom random = new SecureRandom();
        String state = new BigInteger(130, random).toString();
        session.setAttribute("state",state);
        return state;
    }

//    {
//    "resultcode":"00",
//    "message":"success",
//    "response":{"id":"65x6qehmhosf_l-3IPgH12315123OE8HrE",
//                  "nickname":"pap",
//                  "profile_image":"https:\/\/ssl.pstatic.net\/static\/pwe\/address\/img_profile.png",
//                  "age":"20-30",
//                  "gender":"M",
//                  "email":"abc@hotmail.com",
//                  "mobile":"010-119-112",
//                  "mobile_e164":"+821039205090",
//                  "name":"\uc784\uc644\ud0dc",
//                  "birthday":"02-13","birthyear":"2002"}
//     }
    private LoginDTO parserUserInfo(String res) {
        JsonParser parser = new JsonParser();
        JsonElement element = parser.parse(res.toString());
        JsonObject response = element.getAsJsonObject().get("response").getAsJsonObject();
        String id = loginService.getAsStringOrNull(response, "id");
//        String nickname = loginService.getAsStringOrNull(response, "nickname");
//        String profile_image = loginService.getAsStringOrNull(response, "profile_image");
        String age = loginService.getAsStringOrNull(response, "age");
        String gender = loginService.getAsStringOrNull(response, "gender");
        String email = loginService.getAsStringOrNull(response, "email");
//        String mobile = loginService.getAsStringOrNull(response, "mobile");
        String name = loginService.convertString(loginService.getAsStringOrNull(response, "name"));  //유니코드로 출력되기떄문에 스트링으로 변환  ex)"name":"\uc784\uc644\ud0dc"
        String birthday = loginService.getAsStringOrNull(response, "birthday");
//        String birthyear = loginService.getAsStringOrNull(response, "birthyear");

        //유저 정보 DTO로 변환
        LoginDTO loginDTO = LoginDTO.builder()
                .naver_login(id)
                .member_nickname(name)
                .member_age(loginService.convertAge(age))
                .member_gender(loginService.convertGender(gender))
                .member_birthday(loginService.convertBirthDay(birthday))
                .member_email(email)
                .build();
//        System.out.println("loginDTO = " + loginDTO);
        return loginDTO;
    }
}
