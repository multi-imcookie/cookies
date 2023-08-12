package com.multi.cookies.member.service;

import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.multi.cookies.member.dto.LoginDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.env.Environment;
import org.springframework.stereotype.Service;

import javax.annotation.PostConstruct;
import javax.servlet.http.HttpServletRequest;
import java.io.*;
import java.net.HttpURLConnection;
import java.net.URL;

@Service
public class KaKaoSocialLoginService {

    /* social_login.properties를 참조하여 초기화합니다.*/
    @Autowired
    private Environment env;
    private String kakaoClientId; //네이버클라이언트 ID
    private String kakaoRestAPIKey; //네이버Secretkey
    private String kakaoRedirectURI; //네이버콜백URI

    @PostConstruct
    public void init() {
        kakaoClientId = env.getProperty("kakao.clientId");
        kakaoRestAPIKey = env.getProperty("kakao.restAPIkey");
        kakaoRedirectURI = env.getProperty("kakao.RedirectURI");
    }


//    public int insert() {
//
//    }
//    public

    public String getToken(String authorize_code) {
        String access_Token = "";
        String refresh_Token = "";
        String reqURL = "https://kauth.kakao.com/oauth/token";
        try {
            URL url = new URL(reqURL);
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("POST");
            conn.setDoOutput(true);
            BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(conn.getOutputStream()));
            StringBuilder stringBuilder = new StringBuilder();
            stringBuilder.append("grant_type=authorization_code");
            stringBuilder.append("&client_id=" + kakaoRestAPIKey); //본인이 발급받은 key
            stringBuilder.append("&redirect_uri=" + "http://localhost:8989/login" + kakaoRedirectURI); // 본인이 설정한 주소
            stringBuilder.append("&code=" + authorize_code);
            bw.write(stringBuilder.toString());
            bw.flush();
            int responseCode = conn.getResponseCode();
            System.out.println("responseCode : " + responseCode);
            BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
            String line = "";
            String result = "";
            while ((line = br.readLine()) != null) {
                result += line;
            }
//            System.out.println("response body : " + result);
            JsonParser parser = new JsonParser();
            JsonElement element = parser.parse(result);
            access_Token = element.getAsJsonObject().get("access_token").getAsString();
//            refresh_Token = element.getAsJsonObject().get("refresh_token").getAsString();
//            System.out.println("access_token : " + access_Token);
//            System.out.println("refresh_token : " + refresh_Token);
            br.close();
            bw.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
        return access_Token;
    }

    public LoginDTO getUserInfo(String access_Token) throws Exception {
        BufferedReader br;
        StringBuffer stringBuffer = new StringBuffer();
        String apiUrl = "https://kapi.kakao.com/v2/user/me";
        URL url = new URL(apiUrl);
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("GET");
        conn.setRequestProperty("Authorization", "Bearer " + access_Token);
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
        System.out.println("카카오 유저 정보 = " + stringBuffer.toString());
        return parserUserInfo(stringBuffer);
    }

    private LoginDTO parserUserInfo(StringBuffer res) {
        JsonParser parser = new JsonParser();
        JsonElement element = parser.parse(res.toString());
        String id = element.getAsJsonObject().get("id").getAsString();
        JsonObject properties = element.getAsJsonObject().get("properties").getAsJsonObject();
        String nickname = properties.getAsJsonObject().get("nickname").getAsString();

        JsonObject kakao_account = element.getAsJsonObject().get("kakao_account").getAsJsonObject();
        String age = kakao_account.getAsJsonObject().get("age_range").getAsString();
        String email = kakao_account.getAsJsonObject().get("email").getAsString();
        String gender = kakao_account.getAsJsonObject().get("gender").getAsString();
        LoginDTO loginDTO = LoginDTO.builder()
                .kakao_login(id)
                .member_nickname(nickname)
                .member_age(age)
                .member_email(email)
                .member_gender(gender)
                .build();
        return loginDTO;
    }

    public String kakaoApiURL(HttpServletRequest request) {
//https://kauth.kakao.com/oauth/authorize
// ?client_id=1261702231415abdfd147a813b1623f10d
// &redirect_uri=http://localhost:8989/login/kakao/callback
// &response_type=code
        String contextPath = request.getContextPath();
        String callbackURL = request.getRequestURL().toString().replace(contextPath, "");
//        System.out.println("callbackURL = " + callbackURL);
        String apiURL = new StringBuilder("https://kauth.kakao.com/oauth/authorize?")
                .append("client_id=").append(kakaoRestAPIKey)
                .append("&redirect_uri=").append(callbackURL + kakaoRedirectURI)
                .append("&response_type=").append("code")
                .toString();
        return apiURL;
    }

}
