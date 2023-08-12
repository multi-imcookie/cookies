package com.multi.cookies.member.service;


import com.multi.cookies.member.dao.LoginDAO;
import com.multi.cookies.member.dto.LoginDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.lang.reflect.Field;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;

import static org.springframework.util.StringUtils.capitalize;

@Service
public class LoginService {
    @Autowired
    LoginDAO loginDAO;

    public boolean hasRegisteredBefore(LoginDTO loginDTO) {
        String findNullFieldInId = hasNullFields(loginDTO);
        String id;
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
    public int inserUserInfo(LoginDTO loginDTO){
        return loginDAO.insert(loginDTO);
    }
    public boolean isValidPassWord(String id, String password){
        LoginDTO userInfoDTO = loginDAO.cookieSelect(id);
        String pwdBySearched = userInfoDTO.getMember_pw();
        return pwdBySearched.equals(password);
    }

    private String hasNullFields(Object dto){
        Field[] fields = dto.getClass().getDeclaredFields();
        String id="";
        for (Field field : fields) {
            field.setAccessible(true);
            try {
                if (field.get(dto) != null) {
                    switch(field.getName()){
                        case "member_signId":
                            id="member_signId";
                            break;
                        case "naver_login":
                            id="naver_login";
                            break;
                        case "kakao_login":
                            id="kakao_login";
                            break;
                    }
                    field.getName().equals("member_signId");
                }
            } catch (IllegalAccessException e) {
                throw new RuntimeException(e);
            }
        }
        return id;
    }
}