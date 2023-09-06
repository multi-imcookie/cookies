package com.multi.cookies.member.dto;

import lombok.Data;
import java.time.LocalDateTime;

@Data
public class AdminReplyDTO {
    private Integer reply_id;
    private Integer member_id;
    private String reply_content;
    private LocalDateTime create_dt;
}
