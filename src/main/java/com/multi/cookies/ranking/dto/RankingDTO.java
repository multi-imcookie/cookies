package com.multi.cookies.ranking.dto;

public class RankingDTO {
    private int rankingNumber;
    private int snack_id;
    private String snack_name;
    private String snack_img;
    private float avg_score;

    public int getRankingNumber() {
        return rankingNumber;
    }

    public void setRankingNumber(int rankingNumber) {
        this.rankingNumber = rankingNumber;
    }

    public int getSnack_id() {
        return snack_id;
    }

    public void setSnack_id(int snack_id) {
        this.snack_id = snack_id;
    }

    public String getSnack_name() {
        return snack_name;
    }

    public void setSnack_name(String snack_name) {
        this.snack_name = snack_name;
    }

    public String getSnack_img() {
        return snack_img;
    }

    public void setSnack_img(String snack_img) {
        this.snack_img = snack_img;
    }

    public float getAvg_score() {
        return avg_score;
    }

    public void setAvg_score(float avg_score) {
        this.avg_score = avg_score;
    }
    @Override
    public String toString() {
        return "RankingDTO{" +
                "rankingNumber=" + rankingNumber +
                ", snack_id=" + snack_id +
                ", snack_name='" + snack_name + '\'' +
                ", snack_img='" + snack_img + '\'' +
                ", avg_score=" + avg_score +
                '}';
    }
}
