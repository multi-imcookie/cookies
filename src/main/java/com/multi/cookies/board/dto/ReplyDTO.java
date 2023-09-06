package com.multi.cookies.board.dto;

import lombok.Data;

import java.util.Date;
@Data
public class ReplyDTO {
    private int reply_id;
    private int bbs_id;
    private int member_id;
    private String member_nickname;
    private String reply_content;
    private Date create_dt;
    private Date update_dt;

}
