package com.multi.cookies.entertainment.dto;

public class IdealWorldCupDTO {
    private int idealRanking;
    private int snack_id;
    private String snack_name;
    private String snack_img;
    private int wins;
    private double winRate;
    public int getIdealRanking() {
        return idealRanking;
    }

    public void setIdealRanking(int idealRanking) {
        this.idealRanking = idealRanking;
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

    public int getWins() {
        return wins;
    }

    public void setWins(int wins) {
        this.wins = wins;
    }
    public double getWinRate() {
        return winRate;
    }
    public void setWinRate(double winRate) {
        this.winRate = winRate;
    }

    @Override
    public String toString() {
        return "IdealWorldCupDTO{" +
                "idealRanking=" + idealRanking +
                ", ideal_snack_id=" + snack_id +
                ", ideal_snack_name='" + snack_name + '\'' +
                ", ideal_snack_img='" + snack_img + '\'' +
                ", ideal_snack_wins=" + wins +
                ", ideal_snack_winRate=" + winRate +
                '}';
    }
}
