package com.multi.cookies.member.dto;

import lombok.Data;
import java.time.LocalDateTime;

@Data
public class AdminReviewReplyDTO {
    private Long reply_id;
    private Long review_id;
    private String user_id;
    private String reply_content;
    private LocalDateTime create_dt;
    private LocalDateTime update_dt;
}
