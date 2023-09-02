package com.multi.cookies.member.service;

import com.multi.cookies.board.dto.ReviewReplyDTO;
import com.multi.cookies.member.dao.AdminReviewReplyDAO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class AdminReviewReplyService {
    @Autowired
    private AdminReviewReplyDAO adminReviewReplyDAO;

    public List<ReviewReplyDTO> getReplyList(int reviewId) {
        return adminReviewReplyDAO.replyList(reviewId);
    }

    public void createReply(ReviewReplyDTO reply) {
        adminReviewReplyDAO.replyWrite(reply);
    }

    public void modifyReply(ReviewReplyDTO reply) {
        adminReviewReplyDAO.replyModify(reply);
    }

    public void deleteReply(ReviewReplyDTO reply) {
        adminReviewReplyDAO.replyDelete(reply);
    }
}
