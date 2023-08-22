package com.multi.cookies.snack.api.dto;

import lombok.Data;

@Data
public class DBUpdateDTO {
    int snack_id;   // 과자 고유번호
    String nutri_string;    // 영양성분(문자열)
    String snack_ingredients;   // 원재료명
    String snack_name;  // 과자이름
    String snack_img;   // 과자 이미지(url)
    String company; // 제조사
    String snack_reportNo;  // 품목보고번호
    String allergy; // 알레르기 성분
}
