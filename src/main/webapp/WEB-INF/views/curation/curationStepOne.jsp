<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head>
    <title>전과자</title>
    <%@ include file="/link.jsp" %>
</head>
<body>
<%@include file="/header.jsp" %>

<div class="sub-container p-regular">
    <h3 class="h-pre36"> 알레르기가 있으신가요? </h3>
    <form id="curation-form" action="getCurationStepOne" method="get" onsubmit="return validateCheckingAllergy()">
        <!-- <input type="hidden" name="member_id" id="member_id" value="1">-->
        <div class="allergy-check-box">
            <div class="allergy-check-btn">
                <input type="checkbox" name="egg_allergy" id="egg_allergy" value="1">
                <label for="egg_allergy"><img src="/resources/img/curation/egg.png" alt="egg"> 난류 알레르기 </label>
            </div>
            <div class="allergy-check-btn">
                <input type="checkbox" name="milk_allergy" id="milk_allergy" value="1">
                <label for="milk_allergy"><img src="/resources/img/curation/milk.png" alt="milk"> 우유 알레르기
                </label>
            </div>
            <div class="allergy-check-btn">
                <input type="checkbox" name="wheat_allergy" id="wheat_allergy" value="1">
                <label for="wheat_allergy"><img src="/resources/img/curation/wheat.png" alt="wheat"> 밀
                    알레르기</label>
            </div>
        </div>
        <div class="allergy-check-box">
            <div class="allergy-check-btn">
                <input type="checkbox" name="buckwheat_allergy" id="buckwheat_allergy" value="1">
                <label for="buckwheat_allergy"><img src="/resources/img/curation/buckwheat.png" alt="buckwheat">
                    메밀
                    알레르기</label>
            </div>
            <div class="allergy-check-btn">
                <input type="checkbox" name="peanut_allergy" id="peanut_allergy" value="1">
                <label for="peanut_allergy"><img src="/resources/img/curation/peanut.png" alt="peanut"> 땅콩 알레르기</label>
            </div>
            <div class="allergy-check-btn">
                <input type="checkbox" name="soy_allergy" id="soy_allergy" value="1">
                <label for="soy_allergy"><img src="/resources/img/curation/soy.png" alt="soy"> 대두 알레르기</label>
            </div>
        </div>
        <div class="allergy-check-box">
            <div class="allergy-check-btn">
                <input type="checkbox" name="pine_nut_allergy" id="pine_nut_allergy" value="1">
                <label for="pine_nut_allergy"><img src="/resources/img/curation/pine_nut.png" alt="pine_nut"> 잣
                    알레르기</label>
            </div>
            <div class="allergy-check-btn">
                <input type="checkbox" name="almond_allergy" id="almond_allergy" value="1">
                <label for="almond_allergy"><img src="/resources/img/curation/almond.png" alt="almond"> 아몬드 알레르기</label>
            </div>
            <div class="allergy-check-btn">
                <input type="checkbox" name="walnut_allergy" id="walnut_allergy" value="1">
                <label for="walnut_allergy"><img src="/resources/img/curation/walnut.png" alt="walnut"> 호두
                    알레르기</label>
            </div>
        </div>
        <div class="allergy-check-box">
            <div class="allergy-check-btn">
                <input type="checkbox" name="crab_allergy" id="crab_allergy" value="1">
                <label for="crab_allergy"><img src="/resources/img/curation/crab.png" alt="crab"> 게 알레르기</label>
            </div>
            <div class="allergy-check-btn">
                <input type="checkbox" name="shrimp_allergy" id="shrimp_allergy" value="1">
                <label for="shrimp_allergy"><img src="/resources/img/curation/shrimp.png" alt="shrimp"> 새우
                    알레르기</label>
            </div>
            <div class="allergy-check-btn">
                <input type="checkbox" name="squid_allergy" id="squid_allergy" value="1">
                <label for="squid_allergy"><img src="/resources/img/curation/squid.png" alt="squid"> 오징어
                    알레르기</label>
            </div>
        </div>
        <div class="allergy-check-box">
            <div class="allergy-check-btn">
                <input type="checkbox" name="mackerel_allergy" id="mackerel_allergy" value="1">
                <label for="mackerel_allergy"><img src="/resources/img/curation/mackerel.png"
                                                   alt="mackerel"> 고등어
                    알레르기</label>
            </div>
            <div class="allergy-check-btn">
                <input type="checkbox" name="shellfish_allergy" id="shellfish_allergy" value="1">
                <label for="shellfish_allergy"><img src="/resources/img/curation/shellfish.png"
                                                    alt="shellfish"> 조개류
                    알레르기</label>
            </div>
            <div class="allergy-check-btn">
                <input type="checkbox" name="peach_allergy" id="peach_allergy" value="1">
                <label for="peach_allergy"><img src="/resources/img/curation/peach.png" alt="peach"> 복숭아
                    알레르기</label>
            </div>
        </div>
        <div class="allergy-check-box">
            <div class="allergy-check-btn">
                <input type="checkbox" name="tomato_allergy" id="tomato_allergy" value="1">
                <label for="tomato_allergy"><img src="/resources/img/curation/tomato.png" alt="tomato"> 토마토
                    알레르기</label>
            </div>
            <div class="allergy-check-btn">
                <input type="checkbox" name="chicken_allergy" id="chicken_allergy" value="1">
                <label for="chicken_allergy"><img src="/resources/img/curation/chicken.png" alt="chicken">
                    닭고기 알레르기</label>
            </div>
            <div class="allergy-check-btn">
                <input type="checkbox" name="pork_allergy" id="pork_allergy" value="1">
                <label for="pork_allergy"><img src="/resources/img/curation/pork.png" alt="pork"> 돼지고기
                    알레르기</label>
            </div>
        </div>
        <div class="allergy-check-box">
            <div class="allergy-check-btn">
                <input type="checkbox" name="beef_allergy" id="beef_allergy" value="1">
                <label for="beef_allergy"><img src="/resources/img/curation/beef.png" alt="beef"> 쇠고기
                    알레르기</label>
            </div>
        </div>
        <div class="btn-wrap-row">
            <div class="btn-wrap-row p-bold">
                <button class="fill-btn" type="submit"> 체크 했어요!</button>
            </div>

            <div class="btn-wrap-row p-bold">
                <button class="fill-btn" type="button" onclick="return nothingAllergy()"> 없어요 </button>
            </div>
        </div>
    </form>
</div>
<script>
//  function nothingAllergy() {
//      // 모든 체크박스를 선택
//      const checkboxes = document.querySelectorAll('input[type="checkbox"]');

//      let hasChecked = false; // 체크된 체크박스 여부를 나타내는 변수

//      checkboxes.forEach(function(checkbox) {
//          if (checkbox.checked) {
//              hasChecked = true; // 체크된 체크박스가 하나라도 있으면 true로 설정
//          }
//      });

//      if (!hasChecked) {
//          return true; // 체크된 항목이 없으면 폼 제출을 허용 (true 반환)
//      } else {
//          alert('체크된 항목이 있습니다.\n알레르기가 있으면, 체크 후 체크 했어요! 를 눌러주세요.');
//          return false; // 체크된 항목이 있으면 폼 제출을 막음 (false 반환)
//      }
//  }

function validateCheckingAllergy() {
    let checkboxes = document.querySelectorAll('input[type="checkbox"]');

    let checked = false;
    for (let i = 0; i < checkboxes.length; i++) {
        if (checkboxes[i].checked) {
            checked = true;
            break;
        }
    }

    if (!checked) {
        alert("알레르기가 있으시면, 체크 후 확인하세요. 없으시면 [없어요] 버튼을 눌러주세요.") ;
        return false;
    }

    return true;
}

function nothingAllergy() {
    // 모든 체크박스 요소를 선택
    let checkboxes = document.querySelectorAll('input[type="checkbox"]');

    // 체크된 항목이 있는지 확인
    let checked = false;
    for(let i=0; i<checkboxes.length; i++) {
        if(checkboxes[i].checked) {
            checked=true;
            break;
        }
    }

    // 체크된 항목이 있다면 경고창 표시 후 제출 중단
    if(checked){
        alert("체크된 알레르기가 있습니다. '체크 했어요!'를 눌러주세요.");
        return false;
    } else{
        // 체크박스 모두 해제
        checkboxes.forEach(function(checkbox) {
            checkbox.checked = false;
        });

        // 폼 제출
        document.getElementById("curation-form").submit();
    }
}
</script>

<%@include file="/footer.jsp" %>
</body>
</html>
