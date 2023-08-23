package com.multi.cookies.snack.dto;

import lombok.Data;

@Data
public class ScoreDTO {
    int snack_id;
    float avg_score;
    int total_score;
    int review_count;
    int preview_score;
    int new_score;
}
