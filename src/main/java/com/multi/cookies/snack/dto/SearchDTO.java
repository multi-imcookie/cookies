package com.multi.cookies.snack.dto;

import lombok.Data;

@Data
public class SearchDTO {
    int snack_id;
    String snack_name;
    String company;
    String snack_img;
    String snack_ingredients;
    boolean snack_sweet;
    boolean snack_salty;
    String snack_reportNo;

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
    String allergy;

    float avg_score;
    int review_count;

}
