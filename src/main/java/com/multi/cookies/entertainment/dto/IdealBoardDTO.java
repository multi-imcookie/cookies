package com.multi.cookies.entertainment.dto;

import java.util.Date;

public class IdealBoardDTO {
    private int idealBoardNum;
    private int ideal_id;
    private String ideal_nickname;
    private String ideal_pw;
    private String ideal_content;
    private Date create_dt;

    public int getIdealBoardNum() {
        return idealBoardNum;
    }

    public void setIdealBoardNum(int idealBoardNum) {
        this.idealBoardNum = idealBoardNum;
    }

    public int getIdeal_id() {
        return ideal_id;
    }

    public void setIdeal_id(int ideal_id) {
        this.ideal_id = ideal_id;
    }

    public String getIdeal_nickname() {
        return ideal_nickname;
    }

    public void setIdeal_nickname(String ideal_nickname) {
        this.ideal_nickname = ideal_nickname;
    }

    public String getIdeal_pw() {
        return ideal_pw;
    }

    public void setIdeal_pw(String ideal_pw) {
        this.ideal_pw = ideal_pw;
    }

    public String getIdeal_content() {
        return ideal_content;
    }

    public void setIdeal_content(String ideal_content) {
        this.ideal_content = ideal_content;
    }

    public Date getCreate_dt() {
        return create_dt;
    }

    public void setCreate_dt(Date create_dt) {
        this.create_dt = create_dt;
    }

    @Override
    public String toString() {
        return "IdealBoardDTO{" +
                "idealBoardNum=" + idealBoardNum +
                ", ideal_id=" + ideal_id +
                ", ideal_nickname='" + ideal_nickname + '\'' +
                ", ideal_pw='" + ideal_pw + '\'' +
                ", ideal_content='" + ideal_content + '\'' +
                ", create_dt=" + create_dt +
                '}';
    }
}