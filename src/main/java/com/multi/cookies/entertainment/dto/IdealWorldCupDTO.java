package com.multi.cookies.entertainment.dto;

import java.util.Date;

public class IdealWorldCupDTO {
    private int idealRanking;
    private int ideal_snack_id;
    private String ideal_snack_name;
    private String ideal_snack_img;
    private int ideal_snack_wins;
    public int getIdealRanking() {
        return idealRanking;
    }

    public void setIdealRanking(int idealRanking) {
        this.idealRanking = idealRanking;
    }

    public int getIdeal_snack_id() {
        return ideal_snack_id;
    }

    public void setIdeal_snack_id(int ideal_snack_id) {
        this.ideal_snack_id = ideal_snack_id;
    }

    public String getIdeal_snack_name() {
        return ideal_snack_name;
    }

    public void setIdeal_snack_name(String ideal_snack_name) {
        this.ideal_snack_name = ideal_snack_name;
    }

    public String getIdeal_snack_img() {
        return ideal_snack_img;
    }

    public void setIdeal_snack_img(String ideal_snack_img) {
        this.ideal_snack_img = ideal_snack_img;
    }

    public int getIdeal_snack_wins() {
        return ideal_snack_wins;
    }

    public void setIdeal_snack_wins(int ideal_snack_wins) {
        this.ideal_snack_wins = ideal_snack_wins;
    }

    @Override
    public String toString() {
        return "IdealWorldCupDTO{" +
                "idealRanking=" + idealRanking +
                ", ideal_snack_id=" + ideal_snack_id +
                ", ideal_snack_name='" + ideal_snack_name + '\'' +
                ", ideal_snack_img='" + ideal_snack_img + '\'' +
                ", ideal_snack_wins=" + ideal_snack_wins +
                '}';
    }
}
