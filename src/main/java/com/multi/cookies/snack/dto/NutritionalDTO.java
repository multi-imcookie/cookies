
package com.multi.cookies.snack.dto;

import lombok.Data;

@Data
public class NutritionalDTO {

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
    String nutri_string;
    String allergy;
}