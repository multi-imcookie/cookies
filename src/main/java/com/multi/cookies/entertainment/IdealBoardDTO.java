package com.multi.cookies.entertainment;

import java.time.LocalDateTime;

public class IdealBoardDTO {
    private String ideal_nickname;
    private String ideal_pw;
    private String ideal_content;
    private LocalDateTime create_dt;
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

    public LocalDateTime getCreate_dt() {
        return create_dt;
    }

    public void setCreate_dt(LocalDateTime create_dt) {
        this.create_dt = create_dt;
    }
    @Override
    public String toString() {
        return "IdealBoardDTO{" +
                "ideal_nickname='" + ideal_nickname + '\'' +
                ", ideal_pw='" + ideal_pw + '\'' +
                ", ideal_content='" + ideal_content + '\'' +
                ", create_dt=" + create_dt +
                '}';
    }
}
