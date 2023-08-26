package com.multi.cookies.member.dto;

import lombok.Data;
import java.time.LocalDateTime;

@Data
public class AdminDTO {
    private Integer member_id;
    private String member_signId;
    private String member_pw;
    private String member_nickname;
    private String member_age;
    private String member_gender;
    private String member_birthday;
    private String member_email;
    private String member_phone;  // 추가된 부분
    private Integer member_grade;
    private String naver_login;
    private String kakao_login;
    private LocalDateTime create_dt;

    // 생성자, toString() 등은 @Data 어노테이션으로 자동 생성됩니다.
}
