package com.multi.cookies.member.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class MypageDTO {
    private int member_id;
    private String member_signId;
    private String member_pw;
    private String member_nickname;
    private String member_age;
    private String member_gender;
    private String member_birthday;
    private String member_email;
    private int member_grade;
    private String naver_login;
    private String kakao_login;
    private Date create_dt;
    private String member_phone;
    private String member_profile;
}
