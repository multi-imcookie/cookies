<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head>
    <title>전과자</title>
    <%@ include file="/link.jsp" %>
</head>
<body>
<%@include file="/header.jsp" %>

<div class="sub-container p-regular">
    <form class="curation-form" id="curation-form" action="getCurationStepOne" method="get"
          onsubmit="return validateCheckingAllergy()">
        <h3 class="h-pre36 curation-h-pre36"> 알레르기가 있으신가요? 🧐</h3>
        <div class="modal-detail-content p-regular">
            <table class="custom-table curation-table">
                <tr class="allergy-check-box">
                    <td class="allergy-check-btn">
                        <input type="checkbox" name="egg_allergy" value="1" id="egg_allergy">
                        <label for="egg_allergy"><img src="/resources/img/curation/egg.png" alt="egg"> 난류 알레르기</label>
                    </td>
                    <td class="allergy-check-btn">
                        <input type="checkbox" name="milk_allergy" value="1" id="milk_allergy">
                        <label for="milk_allergy"><img src="/resources/img/curation/milk.png" alt="milk"> 우유 알레르기</label>
                    </td>
                    <td class="allergy-check-btn">
                        <input type="checkbox" name="wheat_allergy" value="1" id="wheat_allergy">
                        <label for="wheat_allergy"><img src="/resources/img/curation/wheat.png" alt="wheat"> 밀 알레르기</label>
                    </td>
                </tr>
                <tr class="allergy-check-box">
                    <td class="allergy-check-btn">
                        <input type="checkbox" name="buckwheat_allergy" value="1" id="buckwheat_allergy">
                        <label for="buckwheat_allergy"><img src="/resources/img/curation/buckwheat.png" alt="buckwheat"> 메밀 알레르기</label>
                    </td>
                    <td class="allergy-check-btn">
                        <input type="checkbox" name="peanut_allergy" value="1" id="peanut_allergy">
                        <label for="peanut_allergy"><img src="/resources/img/curation/peanut.png" alt="peanut"> 땅콩 알레르기</label>
                    </td>
                    <td class="allergy-check-btn">
                        <input type="checkbox" name="soy_allergy" value="1" id="soy_allergy">
                        <label for="soy_allergy"><img src="/resources/img/curation/soy.png" alt="soy"> 대두 알레르기</label>
                    </td>
                </tr>
                <tr class="allergy-check-box">
                    <td class="allergy-check-btn">
                        <input type="checkbox" name="pine_nut_allergy" value="1" id="pine_nut_allergy">
                        <label for="pine_nut_allergy"><img src="/resources/img/curation/pine_nut.png" alt="pine_nut"> 잣 알레르기</label>
                    </td>
                    <td class="allergy-check-btn">
                        <input type="checkbox" name="almond_allergy" value="1" id="almond_allergy">
                        <label for="almond_allergy"><img src="/resources/img/curation/almond.png" alt="almond"> 아몬드 알레르기</label>
                    </td>
                    <td class="allergy-check-btn">
                        <input type="checkbox" name="walnut_allergy" value="1" id="walnut_allergy">
                        <label for="walnut_allergy"><img src="/resources/img/curation/walnut.png" alt="walnut"> 호두 알레르기</label>
                    </td>
                </tr>
                <tr class="allergy-check-box">
                    <td class="allergy-check-btn">
                        <input type="checkbox" name="crab_allergy" value="1" id="crab_allergy">
                        <label for="crab_allergy"><img src="/resources/img/curation/crab.png" alt="crab"> 게 알레르기</label>
                    </td>
                    <td class="allergy-check-btn">
                        <input type="checkbox" name="shrimp_allergy" value="1" id="shrimp_allergy">
                        <label for="shrimp_allergy"><img src="/resources/img/curation/shrimp.png" alt="shrimp"> 새우 알레르기</label>
                    </td>
                    <td class="allergy-check-btn">
                        <input type="checkbox" name="squid_allergy" value="1" id="squid_allergy">
                        <label for="squid_allergy"><img src="/resources/img/curation/squid.png" alt="squid"> 오징어 알레르기</label>
                    </td>
                </tr>
                <tr class="allergy-check-box">
                    <td class="allergy-check-btn">
                        <input type="checkbox" name="mackerel_allergy" value="1" id="mackerel_allergy">
                        <label for="mackerel_allergy"><img src="/resources/img/curation/mackerel.png" alt="mackerel"> 고등어 알레르기</label>
                    </td>
                    <td class="allergy-check-btn">
                        <input type="checkbox" name="shellfish_allergy" value="1" id="shellfish_allergy">
                        <label for="shellfish_allergy"><img src="/resources/img/curation/shellfish.png" alt="shellfish"> 조개류 알레르기</label>
                    </td>
                    <td class="allergy-check-btn">
                        <input type="checkbox" name="peach_allergy" value="1" id="peach_allergy">
                        <label for="peach_allergy"><img src="/resources/img/curation/peach.png" alt="peach"> 복숭아 알레르기</label>
                    </td>
                </tr>
                <tr class="allergy-check-box">
                    <td class="allergy-check-btn">
                        <input type="checkbox" name="tomato_allergy" value="1" id="tomato_allergy">
                        <label for="tomato_allergy"><img src="/resources/img/curation/tomato.png" alt="tomato"> 토마토 알레르기</label>
                    </td>
                    <td class="allergy-check-btn">
                        <input type="checkbox" name="chicken_allergy" value="1" id="chicken_allergy">
                        <label for="chicken_allergy"><img src="/resources/img/curation/chicken.png" alt="chicken"> 닭고기 알레르기</label>
                    </td>
                    <td class="allergy-check-btn">
                        <input type="checkbox" name="pork_allergy" value="1" id="pork_allergy">
                        <label for="pork_allergy"><img src="/resources/img/curation/pork.png" alt="pork"> 돼지고기 알레르기</label>
                    </td>
                </tr>
                <tr class="allergy-check-box">
                    <td class="allergy-check-btn curation-last-check-box">
                        <input type="checkbox" name="beef_allergy" value="1" id="beef_allergy">
                        <label for="beef_allergy"><img src="/resources/img/curation/beef.png" alt="beef"> 쇠고기 알레르기</label>
                    </td>
                </tr>
            </table>
        </div>
        <div class="btn-wrap-row">
            <button class="fill-btn" type="submit"> 체크 했어요!</button>
            <button class="dark-fill-btn" type="button" onclick="return nothingAllergy()"> 없어요</button>
        </div>
    </form>
</div>


<script>
    // 페이지가 로드될 때 checkedLogin 세션 값을 확인하고, 값이 1인 경우 alert 띄우기
    window.onload = function () {
        const checkedLogin = <%= session.getAttribute("checkedLogin") %>;
        if (checkedLogin === 1) {
            alert('로그인 해주세요!');
        }
    }

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
            alert("알레르기가 있으시면, 체크 후 확인하세요. 없으시면 [없어요] 버튼을 눌러주세요.");
            return false;
        }

        return true;
    }

    function nothingAllergy() {
        // 모든 체크박스 요소를 선택
        let checkboxes = document.querySelectorAll('input[type="checkbox"]');

        // 체크된 항목이 있는지 확인
        let checked = false;
        for (let i = 0; i < checkboxes.length; i++) {
            if (checkboxes[i].checked) {
                checked = true;
                break;
            }
        }

        // 체크된 항목이 있다면 경고창 표시 후 제출 중단
        if (checked) {
            alert("체크된 알레르기가 있습니다. '체크 했어요!'를 눌러주세요.");
            return false;
        } else {
            // 체크박스 모두 해제
            checkboxes.forEach(function (checkbox) {
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
