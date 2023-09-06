package com.multi.cookies.snack.api.dto;

import lombok.Data;

@Data
public class DBApiDTO {
    private int snack_id;   // 과자 고유번호
    private String nutri_string;    // 영양성분(문자열)
    private String snack_ingredients;   // 원재료명
    private String snack_name;  // 과자이름
    private String snack_img;   // 과자 이미지(url)
    private String company; // 제조사
    private String snack_reportNo;  // 품목보고번호
    private String allergy; // 알레르기 성분

    private double netwt;   // 총 제공량
    private double protein; // 단백질
    private double kcal;    // 열량
    private double fat; // 지방
    private double carb;    // 탄수화물
    private double sugars;  // 당류
    private double calcium; // 칼슘
    private double sodium;  // 나트륨
    private double cholesterol; // 콜레스테롤
    private double saturated_fat;   // 포화지방
    private double trans_fat;   // 트랜스지방
}
