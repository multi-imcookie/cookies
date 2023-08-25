package com.multi.cookies.member.service;


import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.multi.cookies.member.dao.LoginDAO;
import com.multi.cookies.member.dto.LoginDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.lang.reflect.Field;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import static org.springframework.util.StringUtils.capitalize;

@Service
public class LoginService {
    @Autowired
    LoginDAO loginDAO;

    public boolean hasRegisteredBefore(LoginDTO loginDTO) {
        String findNullFieldInId = hasNullFields(loginDTO);  //네이버로그인 or 카카오 로그인 인지를 판단.
        String id; //loginDTO  naverlogin or kakaologin 값을 받음
        try {
            Method method = loginDTO.getClass().getMethod("get"+capitalize(findNullFieldInId));
            Object result = method.invoke(loginDTO);
            id = result.toString();
        } catch (NoSuchMethodException e) {
            throw new RuntimeException(e);
        } catch (InvocationTargetException e) {
            throw new RuntimeException(e);
        } catch (IllegalAccessException e) {
            throw new RuntimeException(e);
        }
        return loginDAO.findIdByUsername(id,findNullFieldInId)!=null;
    }
    public int insertUserInfo(LoginDTO loginDTO){
        return loginDAO.insert(loginDTO);
    }
    //전과자 자체 로그인 , id pwd 받은후 유효성 검사
    public boolean isValidPassWord(Map<String, String> map){
        int rowNumber = loginDAO.cookieSelect(map);
        if(rowNumber!=1) {
            return false;
        }
        return true;
    }
    public LoginDTO getUserInfo(Map<String, String> map){
        LoginDTO loginDTO = loginDAO.cookieOne(map);
        return loginDTO;
    }
    //로그인시 어떤 로그인인지를 판단.
    // LoginDTO 필드중  naver_login , kakao_login 널이 아닌경우 어떤 로그인 인가를 알아냄

    private String hasNullFields(Object dto){
        Field[] fields = dto.getClass().getDeclaredFields();
        String id="";
        for (Field field : fields) {
            field.setAccessible(true);
            try {
                if (field.get(dto) != null) {
                    switch(field.getName()){
//                        case "member_signId":
//                            id="member_signId";
//                            break;
                        case "naver_login":
                            id="naver_login";
                            break;
                        case "kakao_login":
                            id="kakao_login";
                            break;
                    }
//                    field.getName().equals("member_signId");
                }
            } catch (IllegalAccessException e) {
                throw new RuntimeException(e);
            }
        }
        return id;
    }
    //json 과 키값을 넣어주면 널인경우 "" 빈스트링넣어줌
    public String getAsStringOrNull(JsonObject jsonObject, String key) {
        if (jsonObject.has(key)) {
            JsonElement element = jsonObject.get(key);
            if (!element.isJsonNull()) {
                return element.getAsString();
            }
        }
        return "";
    }
    // json데이터가 30-39 or 30~39 or 30-   이렇게 가져오는경우가있음..앞 숫자만 추출해서 다시 나이대 작성
    public String convertAge(String input) {
        // 숫자로 시작하고 숫자와 - 또는 ~ 문자로 이루어진 패턴을 찾습니다.
        Pattern pattern = Pattern.compile("^\\d+([-~]\\d+)?");
        Matcher matcher = pattern.matcher(input);
        if(!matcher.find()){
            return "extractNumber Method Error";
        }
            String matched = matcher.group(); // 매칭된 부분을 가져옵니다.
            // - 또는 ~ 이전의 숫자만 추출합니다.
            String extractedNumber = matched.split("[-~]")[0];
            // 추출한 숫자를 정수로 변환하여 9를 더합니다.
            int originalNumber = Integer.parseInt(extractedNumber);
            int expandedNumber = originalNumber + 9;
            return originalNumber+"-"+String.valueOf(expandedNumber);
        }
    // 카카오는 female , male  , 네이버는 F , M  으로 성별을 가져옴 -> 여성 남성으로 바꾸는 함수
    public String convertGender(String gender) {
        // 입력된 문자열을 소문자로 변환하여 비교합니다.
        String lowerCaseGender = gender.toLowerCase();
        if (lowerCaseGender.equals("male") || lowerCaseGender.equals("m")) {
            return "남성";
        } else if (lowerCaseGender.equals("female") || lowerCaseGender.equals("f")) {
            return "여성";
        } else {
            // "male", "M", "female", 또는 "F"가 아닌 경우에는 원래 값을 그대로 반환합니다.
            return gender;
        }
    }
    // 0213  or 02-13  을 02월 13일로 변환
    public String convertBirthDay(String birthday) {
        // 생일 문자열을 월과 일로 분할합니다.
        String month;
        String day;
        if (birthday.contains("-")) {
            String[] parts = birthday.split("-");
            month = parts[0];
            day = parts[1];
        } else {
            month = birthday.substring(0, 2);
            day = birthday.substring(2);
        }

        // 월과 일을 "월 일" 형식으로 조합합니다.
        return month + "월 " + day + "일";
    }
    // 네이버 유저 Json 데이터중 이름이 유니코드이다. ->  String으로 변환
    public String convertString(String val) {
        StringBuffer sb = new StringBuffer();
        for (int i = 0; i < val.length(); i++) {
            if ('\\' == val.charAt(i) && 'u' == val.charAt(i + 1)) {
                // 그 뒤 네글자는 유니코드의 16진수 코드이다. int형으로 바꾸어서 다시 char 타입으로 강제 변환한다.
                Character r = (char) Integer.parseInt(val.substring(i + 2, i + 6), 16);
                // 변환된 글자를 버퍼에 넣는다.
                sb.append(r);
                // for의 증가 값 1과 5를 합해 6글자를 점프
                i += 5;
            } else {
                // ascii코드면 그대로 버퍼에 넣는다.
                sb.append(val.charAt(i));
            }
        }
        // 결과 리턴
        return sb.toString();
    }
}
