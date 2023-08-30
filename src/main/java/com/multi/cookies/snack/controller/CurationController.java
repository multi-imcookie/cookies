package com.multi.cookies.snack.controller;

import com.multi.cookies.snack.dto.CurationDTO;
import com.multi.cookies.snack.service.CurationService;
import com.multi.cookies.snack.service.SnackService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.lang.reflect.Field;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@Controller
public class CurationController {

    @Autowired
    CurationService curationService;

    @Autowired
    SnackService snackService;

    @RequestMapping("/curation/curationStepOne")
    public String curationStepOne() {
        System.out.println("나는 스텝완!");
        return "curation/curationStepOne";
    }

    @RequestMapping("/curation/getCurationStepOne")
    public String getCurationStepOne(@ModelAttribute CurationDTO curationDTO, HttpSession httpSession) {
        int member_id = (int) httpSession.getAttribute("memberId");
        httpSession.setAttribute("savedCurationDTO", curationDTO);
        if (curationService.checkedHistory(member_id) == 0) {
            return "curation/curationStepTwo";
        } else {
            System.out.println("curationDTO = " + curationDTO);
            System.out.println("나는 스텝원페이지!");
        }
        return "curation/reCurationStepTwo";
    }

    @RequestMapping(value = {"/curation/curationStepTwo", "/curation/reCurationStepTwo"}, method = RequestMethod.GET)
    public String curationStepTwo(HttpServletRequest request, HttpSession httpSession,@ModelAttribute CurationDTO curationDTO, Model model) {
        try {
            //System.out.println(httpSession.getAttribute("savedCurationDTO"));

            CurationDTO storedCurationDTO = (CurationDTO) httpSession.getAttribute("savedCurationDTO");

            //System.out.println("storedCurationDTO = " + storedCurationDTO);

            System.out.println(httpSession.getAttribute("memberId"));

            // curationDTO.setMember_id((int) httpSession.getAttribute("memberId"));

            int memberId = (int) httpSession.getAttribute("memberId");

            // CurationDTO 클래스의 모든 필드 가져오기
            Field[] fields = CurationDTO.class.getDeclaredFields();
            CurationDTO combinedCurationDTO = new CurationDTO();

            for (Field field : fields) {
                field.setAccessible(true);

                // 필드가 정수형이고 curationDTO의 값이 1인 경우
                if (field.getType() == int.class && field.getInt(curationDTO) == 1) {
                    // 값이 1이면 curationDTO에서 가져오고, 아니면 storedCurationDTO에서 가져와서 조합
                    field.set(combinedCurationDTO, field.getInt(curationDTO));
                } else {
                    field.set(combinedCurationDTO, field.get(storedCurationDTO));
                }
            }
            combinedCurationDTO.setMember_id(memberId);

            System.out.println("combinedCurationDTO = " + combinedCurationDTO);
            String requestURI = request.getRequestURI();
            System.out.println(requestURI);
            // 조합된 DTO를 이용하여 curationService 호출
            if (requestURI.equals("/curation/reCurationStepTwo")) {
                curationService.updatePersonality(combinedCurationDTO);
            } else {
                curationService.checkedPersonality(combinedCurationDTO);
            }
            model.addAttribute("curationDTO", combinedCurationDTO);

            // 알러지 정보를 담을 리스트 생성
            List<String> allergyDivContents = new ArrayList<>();

            // CurationDTO의 필드 순회
            for (Field field : fields) {
                field.setAccessible(true);

                // 필드 이름이 _allergy로 끝나고 값이 1인 경우
                if (field.getName().endsWith("_allergy") && field.getType() == int.class && field.getInt(curationDTO) == 1) {
                    // _allergy를 제외한 필드 이름 추출
                    String allergyName = field.getName().replace("_allergy", "");
                    // 알러지 정보를 div 형태로 추가
                    allergyDivContents.add("<div class=\"personal-allergy\">" + allergyName + "</div>");
                }
            }

            // 알러지 정보를 String으로 변환하여 모델에 추가
            String allergyDivContent = String.join("", allergyDivContents);
            model.addAttribute("allergyDivContent", allergyDivContent);

            return "curation/curationResult";
            // 예외 처리
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("errorMessage", "An error occurred while processing your request.");
            return "/error/runtimeErrorPage";  // 에러 페이지로 리다이렉트
        }
    }

    @RequestMapping("/curation/getCurationData/")
   public Map<String, List<String>> curationData(int member_id) {
        System.out.println(member_id);
        Map<String, List<String>> curationData = curationService.curationData(member_id);
        System.out.println(curationData.toString());
        return curationData;
    }
}


