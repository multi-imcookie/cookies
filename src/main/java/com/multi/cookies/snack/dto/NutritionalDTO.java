
package com.multi.cookies.snack.dto;

public class NutritionalDTO {

    @Override
    public String toString() {
        return "NutritionalDTO{" +
                "snack_id=" + snack_id +
                ", netwt=" + netwt +
                ", serving=" + serving +
                ", protein=" + protein +
                ", kcal=" + kcal +
                ", fat=" + fat +
                ", carb=" + carb +
                ", sugars=" + sugars +
                ", calcium=" + calcium +
                ", sodium=" + sodium +
                ", cholesterol=" + cholesterol +
                ", saturated_fat=" + saturated_fat +
                ", trans_fat=" + trans_fat +
                '}';
    }

    int snack_id;
    float netwt;
    float serving;
    float protein;
    float kcal;
    float fat;
    float carb;
    float sugars;
    float calcium;
    float sodium;
    float cholesterol;
    float saturated_fat;
    float trans_fat;


    public int getSnack_id() {
        return snack_id;
    }

    public void setSnack_id(int snack_id) {
        this.snack_id = snack_id;
    }

    public float getNetwt() {
        return netwt;
    }

    public void setNetwt(float netwt) {
        this.netwt = netwt;
    }

    public float getServing() {
        return serving;
    }

    public void setServing(float serving) {
        this.serving = serving;
    }

    public float getProtein() {
        return protein;
    }

    public void setProtein(float protein) {
        this.protein = protein;
    }

    public float getKcal() {
        return kcal;
    }

    public void setKcal(float kcal) {
        this.kcal = kcal;
    }

    public float getFat() {
        return fat;
    }

    public void setFat(float fat) {
        this.fat = fat;
    }

    public float getCarb() {
        return carb;
    }

    public void setCarb(float carb) {
        this.carb = carb;
    }

    public float getSugars() {
        return sugars;
    }

    public void setSugars(float sugars) {
        this.sugars = sugars;
    }

    public float getCalcium() {
        return calcium;
    }

    public void setCalcium(float calcium) {
        this.calcium = calcium;
    }

    public float getSodium() {
        return sodium;
    }

    public void setSodium(float sodium) {
        this.sodium = sodium;
    }

    public float getCholesterol() {
        return cholesterol;
    }

    public void setCholesterol(float cholesterol) {
        this.cholesterol = cholesterol;
    }

    public float getSaturated_fat() {
        return saturated_fat;
    }

    public void setSaturated_fat(float saturated_fat) {
        this.saturated_fat = saturated_fat;
    }

    public float getTrans_fat() {
        return trans_fat;
    }

    public void setTrans_fat(float trans_fat) {
        this.trans_fat = trans_fat;
    }




}