package com.multi.cookies.member.dto;

import lombok.Data;

import java.sql.Date;

@Data
public class AdminBoardDTO {
    private int bbs_id;
    private int bbs_category;
    private int member_id;
    private String bbs_title;
    private String bbs_content;
    private int bbs_views;
    private Date create_dt;
    private Date update_dt;

    // Getters, Setters, toString 등 기본 메서드들
}

