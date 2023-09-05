package com.multi.cookies.member.dto;

import lombok.Data;
import java.time.LocalDateTime;
import java.util.Date;

@Data
public class AdminReviewReplyDTO {
    private int reply_id;
    private int review_id;
    private int member_id;
    private String member_nickname;
    private String reply_content;
    private Date create_dt;
    private Date update_dt;

}
