<%--
  Created by IntelliJ IDEA.
  User: 고물오빠
  Date: 2023-08-09
  Time: 오후 4:45
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>전과자</title>
    <%@ include file="/link.jsp" %>
</head>
<body>
<%@include file="/header.jsp" %>
<div class="modal-overlay">
    <div class="allergy-modal-box modal-box">
        <div class="mdl-text">
            <button type="button" id="modal-close" class="btn-close" aria-label="Close"></button>
            <div class="s-h-imcre24">알레르기 체크</div>
            <div class="modal-detail-content p-regular">
                <table class="custom-table">
                    <tr class="allergy-check-box">
                        <td class="allergy-check-btn">
                            <input type="checkbox" name="selectedAllergies" value="egg_allergy" id="egg_allergy">
                            <label for="egg_allergy"><img src="/resources/img/curation/egg.png" alt="egg"> 난류 알레르기 </label>
                        </td>
                        <td class="allergy-check-btn">
                            <input type="checkbox" name="selectedAllergies" value="milk_allergy" id="milk_allergy">
                            <label for="milk_allergy"><img src="/resources/img/curation/milk.png" alt="milk"> 우유 알레르기 </label>
                        </td>
                        <td class="allergy-check-btn">
                            <input type="checkbox" name="selectedAllergies" value="wheat_allergy" id="wheat_allergy">
                            <label for="wheat_allergy"><img src="/resources/img/curation/wheat.png" alt="wheat"> 밀 알레르기</label>
                        </td>
                    </tr>
                    <tr class="allergy-check-box">
                        <td class="allergy-check-btn">
                            <input type="checkbox" name="selectedAllergies" value="buckwheat_allergy"
                                   id="buckwheat_allergy">
                            <label for="buckwheat_allergy"><img src="/resources/img/curation/buckwheat.png" alt="buckwheat"> 메밀
                                알레르기</label>
                        </td>
                        <td class="allergy-check-btn">
                            <input type="checkbox" name="selectedAllergies" value="peanut_allergy" id="peanut_allergy">
                            <label for="peanut_allergy"><img src="/resources/img/curation/peanut.png" alt="peanut"> 땅콩 알레르기</label>
                        </td>
                        <td class="allergy-check-btn">
                            <input type="checkbox" name="selectedAllergies" value="soy_allergy" id="soy_allergy">
                            <label for="soy_allergy"><img src="/resources/img/curation/soy.png" alt="soy"> 대두 알레르기</label>
                        </td>
                    </tr>
                    <tr class="allergy-check-box">
                        <td class="allergy-check-btn">
                            <input type="checkbox" name="selectedAllergies" value="pine_nut_allergy"
                                   id="pine_nut_allergy">
                            <label for="pine_nut_allergy"><img src="/resources/img/curation/pine_nut.png" alt="pine_nut"> 잣 알레르기</label>
                        </td>
                        <td class="allergy-check-btn">
                            <input type="checkbox" name="selectedAllergies" value="almond_allergy" id="almond_allergy">
                            <label for="almond_allergy"><img src="/resources/img/curation/almond.png" alt="almond"> 아몬드 알레르기</label>
                        </td>
                        <td class="allergy-check-btn">
                            <input type="checkbox" name="selectedAllergies" value="walnut_allergy" id="walnut_allergy">
                            <label for="walnut_allergy"><img src="/resources/img/curation/walnut.png" alt="walnut"> 호두 알레르기</label>
                        </td>
                    </tr>
                    <tr class="allergy-check-box">
                        <td class="allergy-check-btn">
                            <input type="checkbox" name="selectedAllergies" value="crab_allergy" id="crab_allergy">
                            <label for="crab_allergy"><img src="/resources/img/curation/crab.png" alt="crab"> 게 알레르기</label>
                        </td>
                        <td class="allergy-check-btn">
                            <input type="checkbox" name="selectedAllergies" value="shrimp_allergy" id="shrimp_allergy">
                            <label for="shrimp_allergy"><img src="/resources/img/curation/shrimp.png" alt="shrimp"> 새우 알레르기</label>
                        </td>
                        <td class="allergy-check-btn">
                            <input type="checkbox" name="selectedAllergies" value="squid_allergy" id="squid_allergy">
                            <label for="squid_allergy"><img src="/resources/img/curation/squid.png" alt="squid"> 오징어 알레르기</label>
                        </td>
                    </tr>
                    <tr class="allergy-check-box">
                        <td class="allergy-check-btn">
                            <input type="checkbox" name="selectedAllergies" value="mackerel_allergy"
                                   id="mackerel_allergy">
                            <label for="mackerel_allergy"><img src="/resources/img/curation/mackerel.png" alt="mackerel"> 고등어
                                알레르기</label>
                        </td>
                        <td class="allergy-check-btn">
                            <input type="checkbox" name="selectedAllergies" value="shellfish_allergy"
                                   id="shellfish_allergy">
                            <label for="shellfish_allergy"><img src="/resources/img/curation/shellfish.png" alt="shellfish"> 조개류
                                알레르기</label>
                        </td>
                        <td class="allergy-check-btn">
                            <input type="checkbox" name="selectedAllergies" value="peach_allergy" id="peach_allergy">
                            <label for="peach_allergy"><img src="/resources/img/curation/peach.png" alt="peach"> 복숭아 알레르기</label>
                        </td>
                    </tr>
                    <tr class="allergy-check-box">
                        <td class="allergy-check-btn">
                            <input type="checkbox" name="selectedAllergies" value="tomato_allergy" id="tomato_allergy">
                            <label for="tomato_allergy"><img src="/resources/img/curation/tomato.png" alt="tomato"> 토마토 알레르기</label>
                        </td>
                        <td class="allergy-check-btn">
                            <input type="checkbox" name="selectedAllergies" value="chicken_allergy"
                                   id="chicken_allergy">
                            <label for="chicken_allergy"><img src="/resources/img/curation/chicken.png" alt="chicken"> 닭고기 알레르기</label>
                        </td>
                        <td class="allergy-check-btn">
                            <input type="checkbox" name="selectedAllergies" value="pork_allergy" id="pork_allergy">
                            <label for="pork_allergy"><img src="/resources/img/curation/pork.png" alt="pork"> 돼지고기 알레르기</label>
                        </td>
                    </tr>
                    <tr class="allergy-check-box">
                        <td class="allergy-check-btn">
                            <input type="checkbox" name="selectedAllergies" value="beef_allergy" id="beef_allergy">
                            <label for="beef_allergy"><img src="/resources/img/curation/beef.png" alt="beef"> 쇠고기 알레르기</label>
                        </td>
                    </tr>
                </table>
            </div>
        </div>
        <button type="button" id="checkedAllergiesData"> 확인</button>
    </div>
</div>
<div class="sub-container">
    <div class="wiki-search">
        <img src="/resources/img/design_img/sub-search-img.png">
        <form id="snackWikiSearchForm" class="wiki-form" action="snackWikiSearch" method="get"
              onsubmit="return validateFormAndAddAllergyData()">
            <input type="hidden" name="sortName" value="sortHighCalorie">
            <div class="cookie-search main-search">
                <div class="select-wrap">
                    <label class="label-bold" for="cookie-select">Category</label>
                    <select class="p-regular" id="cookie-select" name="category">
                        <option value="">검색 항목</option>
                        <option value="all" selected>전체</option>
                        <option value="name">과자 이름</option>
                        <option value="ingredient">원재료</option>
                    </select>
                </div>
                <span class="div-line"></span>
                <div class="search-wrap">
                    <label class="label-bold" for="keyword">Search</label>
                    <input class="p-regular" type="text" name="keyword" id="keyword"
                           placeholder="검색하고 싶은 과자 정보를 입력하세요.">
                </div>
                <input type="hidden" name="sortName" value="sortHighCalorie">
                <button class="search-btn" type="submit"><img src="/resources/img/icon/search.svg" alt="돋보기 아이콘">
                </button>
            </div>
        </form>
        <span id="checkedAllergies">
        </span>
        <div class="btn-wrap-row">
            <button class="fill-btn" id="checkingAllergies">주의할 알레르기를 체크해주세요!</button>
        </div>
    </div>
</div>
<script>
    $("#checkingAllergies").click(function () {
        modalShow();
    });

    $("#modal-close").click(function () {
        // 모달 내의 모든 체크 박스를 선택하고 해제합니다.
        $(".allergy-check-btn input[type='checkbox']").prop("checked", false);

        // 선택한 알레르기 정보를 출력할 div 요소 가져오기
        let checkedAllergiesDiv = $("#checkedAllergies");

        // 기존 정보를 지우기 위해 div 내용을 비웁니다.
        checkedAllergiesDiv.empty();
        modalHide();
    });

    $("#checkedAllergiesData").click(function () {
        // 선택한 알레르기 정보를 출력할 div 요소 가져오기
        let checkedAllergiesSpan = $("#checkedAllergies");

        // 기존 정보를 지우기 위해 div 내용을 비웁니다.
        checkedAllergiesSpan.empty();

        // 체크된 모든 체크박스 값을 수집하거나 처리할 데이터를 여기에서 구성
        let selectedAllergies = [];

        // 예시: 선택된 체크박스 값을 수집
        $('input[name="selectedAllergies"]:checked').each(function () {
            let allergy = $(this).val();
            selectedAllergies.push(allergy);

            // 선택한 알레르기 정보를 개별 span으로 생성하고 출력
            let labelForAllergy = $('label[for="' + this.id + '"]').html(); // 체크박스에 연결된 라벨 내용 가져오기
            let allergySpan = $("<span>").html(labelForAllergy).addClass('checked-allergy'); // 라벨 내용을 span에 추가
            checkedAllergiesSpan.append(allergySpan);
        });

        // 모달을 숨깁니다.
        modalHide();
    });

    function validateFormAndAddAllergyData() {

        let category = document.getElementById("cookie-select").value;
        if (category === "") {
            alert("카테고리를 골라주세요");
            return false;
        }
        // 체크된 모든 체크박스 값을 수집하거나 처리할 데이터를 여기에서 구성
        let selectedAllergies = [];

        // 예시: 선택된 체크박스 값을 수집
        $('input[name="selectedAllergies"]:checked').each(function () {
            selectedAllergies.push($(this).val());
        });

        // 폼 데이터로 선택된 알레르기를 추가
        let selectedAllergiesField = document.createElement('input');
        selectedAllergiesField.setAttribute('type', 'hidden');
        selectedAllergiesField.setAttribute('name', 'selectedAllergies'); // 이름 설정
        selectedAllergiesField.setAttribute('value', selectedAllergies.join(','));

        // 폼에 폼 필드 추가
        let form = document.getElementById('snackWikiSearchForm');
        form.appendChild(selectedAllergiesField);

        // 폼 제출
        form.submit();
        return true;
    }
</script>
<%@include file="/footer.jsp" %>
</body>
</html>
