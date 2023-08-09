package com.multi.cookies.snack.dto;

public class SnackDTO {

    @Override
    public String toString() {
        return "SnackDTO{" +
                "snack_id=" + snack_id +
                ", snack_name='" + snack_name + '\'' +
                ", company='" + company + '\'' +
                ", snack_img='" + snack_img + '\'' +
                ", snack_ingredients='" + snack_ingredients + '\'' +
                ", snack_sweet=" + snack_sweet +
                ", snack_salty=" + snack_salty +
                '}';
    }

    int snack_id;
    String snack_name;
    String company;
    String snack_img;
    String snack_ingredients;
    boolean snack_sweet;
    boolean snack_salty;

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

    public String getCompany() {
        return company;
    }

    public void setCompany(String company) {
        this.company = company;
    }

    public String getSnack_img() {
        return snack_img;
    }

    public void setSnack_img(String snack_img) {
        this.snack_img = snack_img;
    }

    public String getSnack_ingredients() {
        return snack_ingredients;
    }

    public void setSnack_ingredients(String snack_ingredients) {
        this.snack_ingredients = snack_ingredients;
    }

    public boolean isSnack_sweet() {
        return snack_sweet;
    }

    public void setSnack_sweet(boolean snack_sweet) {
        this.snack_sweet = snack_sweet;
    }

    public boolean isSnack_salty() {
        return snack_salty;
    }

    public void setSnack_salty(boolean snack_salty) {
        this.snack_salty = snack_salty;
    }



}