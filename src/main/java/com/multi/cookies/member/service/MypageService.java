package com.multi.cookies.member.service;

import com.multi.cookies.member.dao.MypageDAO;
import com.multi.cookies.member.dto.MypageDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class MypageService {
    @Autowired
    MypageDAO mypageDAO;

    public MypageDTO getMemberInfo(int member_id) {
        return mypageDAO.getMemberInfo(member_id);
    }

    public String replaceMemberAge(String member_age){
        member_age = member_age.replace("~", "-"); // "~"를 "-"로 변경

        String[] ageParts = member_age.split("-");
        if (ageParts.length == 2) {
            int lower = Integer.parseInt(ageParts[0]);
            int upper = Integer.parseInt(ageParts[1]);

            if (lower >= 10 && upper <= 19) {
                return "10대";
            } else if (lower >= 20 && upper <= 29) {
                return "20대";
            } else if (lower >= 30 && upper <= 39) {
                return "30대";
            } else if (lower >= 40 && upper <= 49) {
                return "40대";
            } else if (lower >= 50 && upper <= 59) {
                return "50대";
            } else if (lower >= 60) {
                return "60대 이상";
            }
        }
        return "알 수 없는 연령대";
    }
}
