package com.multi.cookies.board.dto;


import lombok.Data;

import java.util.Date;
@Data
public class BoardDTO {
    private int bbs_id;
    private int bbs_category;
    private int member_id;
    private String member_nickname;
    private String bbs_title;
    private String bbs_content;
    private int bbs_views = 0;
    private Date create_dt;
    private Date update_dt;

}
