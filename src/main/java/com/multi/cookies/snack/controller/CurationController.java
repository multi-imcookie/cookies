package com.multi.cookies.snack.controller;

import com.multi.cookies.snack.dto.CurationDTO;
import com.multi.cookies.snack.dto.SearchDTO;
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

    //views 밖 curation.jsp 에서 views 안 페이지로
    @RequestMapping("/curation/curationStepOne")
    public String curationStepOne(HttpSession httpSession) {
        // 로그인 하지 않은 상태면, 사용하지 못하게 하려고 값 저장.
        httpSession.setAttribute("checkedLogin", 0);
        return "curation/curationStepOne";
    }

    // 로그인 체크 및 중복 체크를 위한 과정.
    @RequestMapping("/curation/getCurationStepOne")
    public String getCurationStepOne(@ModelAttribute CurationDTO curationDTO, HttpSession httpSession, Model model) {
        // session이 꼬일 수 있기 때문에, 로그인 확인하는 변수는 다시 0으로 초기화.
        httpSession.setAttribute("checkedLogin", 0);
        // curation.jsp에서 로그인 체크를 안 하는 이유는, 궁금증을 유발하기 위해 알레르기까진 보여줘도 될 거 같아서!
        if (httpSession.getAttribute("memberId") == null) {
            httpSession.setAttribute("checkedLogin", 1);
            return "curation/curationStepOne";

        }
        int member_id = (int) httpSession.getAttribute("memberId");

        httpSession.setAttribute("savedCurationDTO", curationDTO);
        // 이미 큐레이션을 진행했는지, 안 했는지 여부에 대해 확인!
        if (curationService.checkedHistory(member_id) == 0) {
            return "curation/curationStepTwo";
        }
        return "curation/reCurationStepTwo";
    }

    //오버라이드 된 메소드
    //분기를 갈라서 받아옴
    @RequestMapping(value = {"/curation/curationStepTwo", "/curation/reCurationStepTwo"}, method = RequestMethod.GET)
    public String curationStepTwo(HttpServletRequest request, HttpSession httpSession, @ModelAttribute CurationDTO curationDTO, Model model) {
        try {
            CurationDTO storedCurationDTO = (CurationDTO) httpSession.getAttribute("savedCurationDTO");

            int memberId = (int) httpSession.getAttribute("memberId");

            // CurationDTO 클래스의 모든 필드 가져오기
            Field[] fields = CurationDTO.class.getDeclaredFields();
            CurationDTO combinedCurationDTO = new CurationDTO();

            // 특이하죠? 임시로 데이터를 가지고 이걸 실시간으로 합쳐서 사용하려니 제한사항이 많더라고요.
            // 가장 쉬운 건 DB까지 가서 저장해서 다시 꺼내오는 건데 말이죠.
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

            String requestURI = request.getRequestURI();

            // 알레르기 + 취향이 조합된 DTO를 이용하여 curationService 호출
            if (requestURI.equals("/curation/reCurationStepTwo")) {
                //이미 있는 큐레이션을 한 적이 있는 사람이라면 모아진 정보로 update
                curationService.updatePersonality(combinedCurationDTO);
            } else {
                //처음 큐레이션 하는 사람이라면 모아진 정보로 insert 진행
                curationService.checkedPersonality(combinedCurationDTO);
            }
            model.addAttribute("curationDTO", combinedCurationDTO);

            // 알레르기 정보를 담을 리스트 생성
            List<String> allergyList = new ArrayList<>();

            // CurationDTO의 필드 순회
            for (Field field : fields) {
                field.setAccessible(true);

                // 필드 이름이 _allergy로 끝나고 값이 1인 경우
                if (field.getName().endsWith("_allergy") && field.getType() == int.class && field.getInt(combinedCurationDTO) == 1) {
                    String allergyName = field.getName();
                    // 알러지 정보를 div 형태로 추가
                    allergyList.add(allergyName);
                }
            }

            model.addAttribute("allergyData", allergyList);
            // 여기서는 알레르기에 대한 정보 체크해서 박스 만들었어!
            return "/curation/curationCheck";

            // 예외 처리
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("errorMessage", "An error occurred while processing your request.");
            return "/error/runtimeErrorPage";  // 에러 페이지로 리다이렉트
        }
    }

    //알레르기랑 취향 저장한 거 가져다가 박스도 만들고 값도 보내고... 여기서는 뭐다?
    // 저장된 과자정보 취향에 맞게 모아서 띄워주기 위한 곳!
    @RequestMapping("/curation/getCurationData")
    public String curationData(@RequestParam("member_id") int member_id, Model model) {

        Map<String, List<SearchDTO>> curationData = curationService.curationData(member_id);

        model.addAttribute("curationData", curationData);
        return "/curation/curationResult";
    }
}


