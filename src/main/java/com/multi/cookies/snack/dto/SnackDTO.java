package com.multi.cookies.snack.dto;

import lombok.Data;

@Data
public class SnackDTO {

    int snack_id;
    String snack_name;
    String company;
    String snack_img;
    String snack_ingredients;
    boolean snack_sweet;
    boolean snack_salty;
}