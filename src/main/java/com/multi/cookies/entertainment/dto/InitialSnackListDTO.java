package com.multi.cookies.entertainment.dto;

public class InitialSnackListDTO {
    private int snack_id;
    private String snack_name;
    private String snack_img;

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

    @Override
    public String toString() {
        return "InitialSnackListDTO{" +
                "snack_id=" + snack_id +
                ", snack_name='" + snack_name + '\'' +
                ", snack_img='" + snack_img + '\'' +
                '}';
    }
}