package com.multi.cookies.member.service;

import com.multi.cookies.board.dto.BoardDTO;
import com.multi.cookies.board.dto.ReviewDTO;
import com.multi.cookies.member.dao.MypageDAO;
import com.multi.cookies.member.dto.MypageDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.ServletContext;
import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.*;

@Service
public class MypageService {
    @Autowired
    MypageDAO mypageDAO;

    @Autowired
    JasyptEncoderService jasyptEncoderService;

    @Autowired
    PasswordEncoder passwordEncoder;

    @Autowired
    ServletContext servletContext;

    // 멤버 정보 조회
    public MypageDTO getMemberInfo(int member_id) {
        return mypageDAO.getMemberInfo(member_id);
    }

    // 작성한 리뷰 조회
    public List<ReviewDTO> getMyReview(int member_id) {
        return mypageDAO.getMyReview(member_id);
    }

    // 작성한 게시글 조회
    public List<BoardDTO> getMyBoard(int member_id) {
        return mypageDAO.getMyBoard(member_id);
    }

    // 연령대 노출 형식 변형
    public String replaceMemberAge(String member_age) {
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

    // 회원 정보 업데이트 메서드
    public int updateMemberInfo(MypageDTO mypageDTO) {
        if (!mypageDTO.getMember_pw().isEmpty()) {
            String newPw = jasyptEncoderService.encrypt(mypageDTO.getMember_pw());
            mypageDTO.setMember_pw(newPw);
        } else {
            MypageDTO originPwDTO = mypageDAO.getMemberInfo(mypageDTO.getMember_id()); // 기존 정보를 가져옴
            mypageDTO.setMember_pw(originPwDTO.getMember_pw()); // 기존 비밀번호로 설정
        }
        return mypageDAO.updateMemberInfo(mypageDTO);
    }

    public boolean checkMyPw(int member_id, String chkMemberPw) {
        // db에 암호화 되어 저장된 비밀번호 가져오기
        String encPw = mypageDAO.getMemberPw(member_id);

        // 암호화 된 비밀번호 복호화
        String decPw = jasyptEncoderService.decrypt(encPw);

        System.out.println("decPw = " + decPw);
        System.out.println("chkMemberPw = " + chkMemberPw);

        System.out.println(chkMemberPw.equals(decPw));

        return chkMemberPw.equals(decPw);

//        //복호화 하지 않고 matches() 를 사용
//        System.out.println(passwordEncoder.matches(encPw, chkMemberPw));
//        return passwordEncoder.matches(encPw, chkMemberPw);
    }

    // 프로필 사진 가져오기
    public String getProfile(int member_id) {
        return mypageDAO.getProfile(member_id);
    }

    public void updateProfile(int member_id, String member_profile) {
        System.out.println("-------------000000000000000");
        Map<String, String> params = new HashMap<>();
        params.put("member_id", String.valueOf(member_id));
        params.put("member_profile", member_profile);
        mypageDAO.updateProfile(params);
    }

    public String saveProfile(MultipartFile file, int member_id) throws IOException {

        // 업로드된 파일의 확장자 추출
        String originalFilename = file.getOriginalFilename();
        String fileExtension = Objects.requireNonNull(originalFilename).substring(originalFilename.lastIndexOf("."));

        // 파일명 생성 (예: userId_20210904120000.jpg)
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMMddHHmmss");
        String timestamp = dateFormat.format(new Date());
        String newFilename = member_id + "_" + timestamp + fileExtension;

        // 절대 경로
        String absolutePath = "/resources/img/profile";

        // 파일을 저장할 디렉토리 경로 설정
        String uploadDir = servletContext.getRealPath(absolutePath); // 실제 디렉토리 경로로 변경해야 합니다

        // 저장될 파일 경로 설정
        String savePath = uploadDir + File.separator + newFilename;
        System.out.println("newFilename = " + newFilename);

        // 파일을 지정된 경로로 저장
        File dest = new File(savePath);
        System.out.println("dest = " + dest);
        file.transferTo(dest);

        // DB에 새로운 파일 경로 저장
        return absolutePath + "/" + newFilename;
    }

    // 프로필 사진 삭제
    public void deleteProfile(int member_id) {
        mypageDAO.deleteProfile(member_id);
    }

}
