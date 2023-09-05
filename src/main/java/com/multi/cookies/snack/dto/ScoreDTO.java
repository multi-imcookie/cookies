package com.multi.cookies.snack.dto;

import lombok.Data;

//평점을 위한 DTO
@Data
public class ScoreDTO {
    int snack_id;
    float avg_score;
    int total_score;
    int review_count;
    int preview_score;
    int new_score;
}
