package com.multi.cookies.snack.dto;

import lombok.Data;

@Data
public class CurationDTO {

    private int member_id;
    private int egg_allergy;         // 계란 알러지
    private int milk_allergy;        // 우유 알러지
    private int wheat_allergy;       // 밀 알러지
    private int buckwheat_allergy;   // 메밀 알러지
    private int peanut_allergy;      // 땅콩 알러지
    private int soy_allergy;         // 대두 알러지
    private int pine_nut_allergy;    // 잣 알러지
    private int almond_allergy;      // 아몬드 알러지
    private int walnut_allergy;      // 호두 알러지
    private int crab_allergy;        // 게 알러지
    private int shrimp_allergy;      // 새우 알러지
    private int squid_allergy;       // 오징어 알러지
    private int mackerel_allergy;    // 고등어 알러지
    private int shellfish_allergy;   // 조개류 알러지
    private int peach_allergy;       // 복숭아 알러지
    private int tomato_allergy;      // 토마토 알러지
    private int chicken_allergy;     // 닭고기 알러지
    private int pork_allergy;        // 돼지고기 알러지
    private int beef_allergy;        // 쇠고기 알러지
    private int chocolate;           // 기호 : 초코
    private int strawberry;          // 기호 : 딸기
    private int chili;               // 기호 : 칠리
    private int honey;               // 기호 : 허니
}



