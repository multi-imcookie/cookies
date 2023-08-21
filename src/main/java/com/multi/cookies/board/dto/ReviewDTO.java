package com.multi.cookies.board.dto;

import java.util.Date;

public class ReviewDTO {

    private int review_id;				//리뷰 글번호
    private int snack_id;				//과자번호
    private int member_id;				//회원번호
    private String review_title;		//리뷰글제목
    private String review_content;		//리뷰글내용
    private int review_score;			//별점
    private String review_img;			//리뷰사진
    private Date create_dt;				//작성일시
    private Date update_dt;				//수정일시


    public int getReview_id() {
        return review_id;
    }
    public void setReview_id(int review_id) {
        this.review_id = review_id;
    }
    public int getSnack_id() {
        return snack_id;
    }
    public void setSnack_id(int snack_id) {
        this.snack_id = snack_id;
    }
    public int getMember_id() {
        return member_id;
    }
    public void setMember_id(int member_id) {
        this.member_id = member_id;
    }
    public String getReview_title() {
        return review_title;
    }
    public void setReview_title(String review_title) {
        this.review_title = review_title;
    }
    public String getReview_content() {
        return review_content;
    }
    public void setReview_content(String review_content) {
        this.review_content = review_content;
    }
    public int getReview_score() {
        return review_score;
    }
    public void setReview_score(int review_score) {
        this.review_score = review_score;
    }
    public String getReview_img() {
        return review_img;
    }
    public void setReview_img(String review_img) {
        this.review_img = review_img;
    }
    public Date getCreate_dt() {
        return create_dt;
    }
    public void setCreate_dt(Date create_dt) {
        this.create_dt = create_dt;
    }
    public Date getUpdate_dt() {
        return update_dt;
    }
    public void setUpdate_dt(Date update_dt) {
        this.update_dt = update_dt;
    }



}
