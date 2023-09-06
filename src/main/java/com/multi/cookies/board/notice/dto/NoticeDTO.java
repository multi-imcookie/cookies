package com.multi.cookies.board.notice.dto;


import lombok.Data;

import java.util.Date;
@Data
public class NoticeDTO {
    private int notice_id;
    private int member_id;
    private String member_nickname;
    private String notice_title;
    private String notice_content;
    private int notice_views = 0;
    private Date create_dt;
    private Date update_dt;

}
