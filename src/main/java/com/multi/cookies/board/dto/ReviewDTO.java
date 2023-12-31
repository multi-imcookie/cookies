package com.multi.cookies.board.dto;

import lombok.Data;

import java.util.Date;

@Data
public class ReviewDTO {

    private int review_id;				//리뷰 글번호
    private int snack_id;				//과자번호
    private String snack_name;          //과자이름
    private int member_id;				//회원번호
    private String member_nickname;     //회원닉네임
    private String review_title;		//리뷰글제목
    private String review_content;		//리뷰글내용
    private int review_score;			//별점
    private String review_img;			//리뷰사진
    private int reply_count;           //댓글개수
    private Date create_dt;				//작성일시
    private Date update_dt;				//수정일시

    //GETTER, SETTER, toString이 한 번에!

}
