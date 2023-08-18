package com.multi.cookies.member.dto;

import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;

@Getter
public class AdminDTO {
    @Setter
    private Integer member_id;
    @Setter
    private String member_signId;
    @Setter
    private String member_pw;
    @Setter
    private String member_nickname;
    @Setter
    private String member_age;
    @Setter
    private String member_gender;
    @Setter
    private String member_birthday;
    @Setter
    private String member_email;
    @Setter
    private Integer member_grade;
    @Setter
    private String naver_login;
    @Setter
    private String kakao_login;
    @Setter
    private LocalDateTime create_dt;

    public AdminDTO(Integer member_id, String member_signId, String member_pw, String member_nickname, String member_age, String member_gender, String member_birthday, String member_email, Integer member_grade, String naver_login, String kakao_login, LocalDateTime create_dt) {
        this.member_id = member_id;
        this.member_signId = member_signId;
        this.member_pw = member_pw;
        this.member_nickname = member_nickname;
        this.member_age = member_age;
        this.member_gender = member_gender;
        this.member_birthday = member_birthday;
        this.member_email = member_email;
        this.member_grade = member_grade;
        this.naver_login = naver_login;
        this.kakao_login = kakao_login;
        this.create_dt = create_dt;
    }

    @Override
    public String toString() {
        return "AdminDTO{" +
                "member_id=" + member_id +
                ", member_signId='" + member_signId + '\'' +
                // 나머지 필드도 여기에 추가...
                '}';
    }
}
