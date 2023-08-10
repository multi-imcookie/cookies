package com.multi.cookies.member.service;

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

    public String getToken(String code, String state, HttpSession session)throws Exception{
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
            System.out.print("responseCode="+responseCode);
            if(responseCode==200) { // 정상 호출
                br = new BufferedReader(new InputStreamReader(con.getInputStream()));
            } else {  // 에러 발생
                br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
            }
            String inputLine;
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
    public StringBuffer getUserInfo(String access_token) throws Exception{
        String header = "Bearer " + access_token;
        String apiurl = "https://openapi.naver.com/v1/nid/me";
        URL url = new URL(apiurl);
        HttpURLConnection con = (HttpURLConnection) url.openConnection();
        con.setRequestMethod("GET");
        con.setRequestProperty("Authorization", header);
        int responseCode = con.getResponseCode();
        BufferedReader br;

        if (responseCode == 200) { // 정상 호출
            br = new BufferedReader(new InputStreamReader(con.getInputStream()));
        } else {  // 에러 발생
            br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
        }

        String inputLine;
        StringBuffer res = new StringBuffer();
        while ((inputLine = br.readLine()) != null) {
            res.append(inputLine);
        }
        br.close();
        return res;
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
    private String naverApiState(HttpSession session){
        SecureRandom random = new SecureRandom();
        String state = new BigInteger(130, random).toString();
        session.setAttribute("state",state);
        return state;
    }
}
