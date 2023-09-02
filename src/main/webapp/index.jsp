<%--
  Created by IntelliJ IDEA.
  User: ohlocal
  Date: 2023-08-04
  Time: 오전 9:48
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
                                <label for="egg_allergy"><img src="/images/egg.png" alt="egg"> 난류 알레르기 </label>
                            </td>
                            <td class="allergy-check-btn">
                                <input type="checkbox" name="selectedAllergies" value="milk_allergy" id="milk_allergy">
                                <label for="milk_allergy"><img src="/images/milk.png" alt="milk"> 우유 알레르기 </label>
                            </td>
                            <td class="allergy-check-btn">
                                <input type="checkbox" name="selectedAllergies" value="wheat_allergy"
                                       id="wheat_allergy">
                                <label for="wheat_allergy"><img src="/images/wheat.png" alt="wheat"> 밀 알레르기</label>
                            </td>
                        </tr>
                        <tr class="allergy-check-box">
                            <td class="allergy-check-btn">
                                <input type="checkbox" name="selectedAllergies" value="buckwheat_allergy"
                                       id="buckwheat_allergy">
                                <label for="buckwheat_allergy"><img src="/images/buckwheat.png" alt="buckwheat"> 메밀
                                    알레르기</label>
                            </td>
                            <td class="allergy-check-btn">
                                <input type="checkbox" name="selectedAllergies" value="peanut_allergy"
                                       id="peanut_allergy">
                                <label for="peanut_allergy"><img src="/images/peanut.png" alt="peanut"> 땅콩 알레르기</label>
                            </td>
                            <td class="allergy-check-btn">
                                <input type="checkbox" name="selectedAllergies" value="soy_allergy" id="soy_allergy">
                                <label for="soy_allergy"><img src="/images/soy.png" alt="soy"> 대두 알레르기</label>
                            </td>
                        </tr>
                        <tr class="allergy-check-box">
                            <td class="allergy-check-btn">
                                <input type="checkbox" name="selectedAllergies" value="pine_nut_allergy"
                                       id="pine_nut_allergy">
                                <label for="pine_nut_allergy"><img src="/images/pine_nut.png" alt="pine_nut"> 잣
                                    알레르기</label>
                            </td>
                            <td class="allergy-check-btn">
                                <input type="checkbox" name="selectedAllergies" value="almond_allergy"
                                       id="almond_allergy">
                                <label for="almond_allergy"><img src="/images/almond.png" alt="almond"> 아몬드 알레르기</label>
                            </td>
                            <td class="allergy-check-btn">
                                <input type="checkbox" name="selectedAllergies" value="walnut_allergy"
                                       id="walnut_allergy">
                                <label for="walnut_allergy"><img src="/images/walnut.png" alt="walnut"> 호두 알레르기</label>
                            </td>
                        </tr>
                        <tr class="allergy-check-box">
                            <td class="allergy-check-btn">
                                <input type="checkbox" name="selectedAllergies" value="crab_allergy" id="crab_allergy">
                                <label for="crab_allergy"><img src="/images/crab.png" alt="crab"> 게 알레르기</label>
                            </td>
                            <td class="allergy-check-btn">
                                <input type="checkbox" name="selectedAllergies" value="shrimp_allergy"
                                       id="shrimp_allergy">
                                <label for="shrimp_allergy"><img src="/images/shrimp.png" alt="shrimp"> 새우 알레르기</label>
                            </td>
                            <td class="allergy-check-btn">
                                <input type="checkbox" name="selectedAllergies" value="squid_allergy"
                                       id="squid_allergy">
                                <label for="squid_allergy"><img src="/images/squid.png" alt="squid"> 오징어 알레르기</label>
                            </td>
                        </tr>
                        <tr class="allergy-check-box">
                            <td class="allergy-check-btn">
                                <input type="checkbox" name="selectedAllergies" value="mackerel_allergy"
                                       id="mackerel_allergy">
                                <label for="mackerel_allergy"><img src="/images/mackerel.png" alt="mackerel"> 고등어
                                    알레르기</label>
                            </td>
                            <td class="allergy-check-btn">
                                <input type="checkbox" name="selectedAllergies" value="shellfish_allergy"
                                       id="shellfish_allergy">
                                <label for="shellfish_allergy"><img src="/images/shellfish.png" alt="shellfish"> 조개류
                                    알레르기</label>
                            </td>
                            <td class="allergy-check-btn">
                                <input type="checkbox" name="selectedAllergies" value="peach_allergy"
                                       id="peach_allergy">
                                <label for="peach_allergy"><img src="/images/peach.png" alt="peach"> 복숭아 알레르기</label>
                            </td>
                        </tr>
                        <tr class="allergy-check-box">
                            <td class="allergy-check-btn">
                                <input type="checkbox" name="selectedAllergies" value="tomato_allergy"
                                       id="tomato_allergy">
                                <label for="tomato_allergy"><img src="/images/tomato.png" alt="tomato"> 토마토 알레르기</label>
                            </td>
                            <td class="allergy-check-btn">
                                <input type="checkbox" name="selectedAllergies" value="chicken_allergy"
                                       id="chicken_allergy">
                                <label for="chicken_allergy"><img src="/images/chicken.png" alt="chicken"> 닭고기
                                    알레르기</label>
                            </td>
                            <td class="allergy-check-btn">
                                <input type="checkbox" name="selectedAllergies" value="pork_allergy" id="pork_allergy">
                                <label for="pork_allergy"><img src="/images/pork.png" alt="pork"> 돼지고기 알레르기</label>
                            </td>
                        </tr>
                        <tr class="allergy-check-box">
                            <td class="allergy-check-btn">
                                <input type="checkbox" name="selectedAllergies" value="beef_allergy" id="beef_allergy">
                                <label for="beef_allergy"><img src="/images/beef.png" alt="beef"> 쇠고기 알레르기</label>
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
            <button type="button" id="checkedAllergiesData"> 확인</button>
        </div>
    </div>
    <div class="visual">
        <div class="v-left">
            <h3 class="h-pre36">
                🔍<br>
                궁금한 과자가 있으신가요?
            </h3>
            <form id="snackWikiSearchForm" action="/snack/snackWikiSearch" method="get"
                  onsubmit="return validateFormAndAddAllergyData()">
                <div class="cookie-search main-search">
                    <div class="select-wrap">
                        <label class="label-bold" for="cookie-select">Category</label>
                        <select class="p-regular" id="cookie-select" name="category">
                            <option value="">검색 항목</option>
                            <option value="all">전체</option>
                            <option value="name">과자 이름</option>
                            <option value="ingredient">원재료</option>
                        </select>
                    </div>
                    <span class="div-line"></span>
                    <div class="search-wrap">
                        <label class="label-bold" for="keyword">Search</label>
                        <input class="p-regular" type="text" name="keyword" id="keyword"
                               placeholder="검색하고 싶은 과자를 입력하세요.">
                    </div>
                    <input type="hidden" name="sortName" value="sortHighCalorie">
                    <button class="search-btn"><img src="/resources/img/icon/search.svg" alt="돋보기 아이콘"></button>
            </form>
        </div>
        <div class="btn-wrap-row">
            <button class="fill-btn" id="checkingAllergies">알러지 체크</button>
        </div>
        <div class="popular-slide" id="popular-slide">
            <ul id="ticker">

            </ul>
        </div>
    </div>
    <div class="v-right">
        <div class="v-right-view">
            <div class="v-right-warp">
                <%-- v-r-box에 링크 안 넣을거면 div 태그로 변경하세요 --%>
                <a href="#" class="v-r-box box01">
                    <div class="v-r-text">
                        <h4 class="h-pre24">
                            🍪<br>
                            오늘의 과자는?
                        </h4>
                        <p>꼬북칩!</p>
                        <span class="p-regular">
                        오늘 날씨가 어쩌고 저쩌고 그래서 꼬북칩 드셔 보시는 게 어떠실런지 어쩌고<br>
                        무난한 추천 문구 5개정도 돌려 쓰면 좋을 듯
                    </span>
                    </div>
                    <img src="resources/img/design_img/v-right-box-img01.png" alt="꼬북칩">
                </a>
                <a href="#" class="v-r-box box02">
                    <div class="v-r-text">
                        <h4 class="h-pre24">
                            🍪<br>
                            오늘의 과자는?
                        </h4>
                        <p>꼬북칩!</p>
                        <span class="p-regular">
                        오늘 날씨가 어쩌고 저쩌고 그래서 꼬북칩 드셔보시는게 어떠실런지 어쩌고<br>
                        무난한 추천문구 5개정도 돌려쓰면 좋을듯
                    </span>
                    </div>
                    <img src="resources/img/design_img/v-right-box-img01.png" alt="꼬북칩">
                </a>
                <a href="#" class="v-r-box box03">
                    <div class="v-r-text">
                        <h4 class="h-pre24">
                            🍪<br>
                            오늘의 과자는?
                        </h4>
                        <p>꼬북칩!</p>
                        <span class="p-regular">
                        오늘 날씨가 어쩌고 저쩌고 그래서 꼬북칩 드셔보시는게 어떠실런지 어쩌고<br>
                        무난한 추천문구 5개정도 돌려쓰면 좋을듯
                    </span>
                    </div>
                    <img src="resources/img/design_img/v-right-box-img01.png" alt="꼬북칩">
                </a>
            </div>
        </div>
        <div class="slide-btn prev-btn"><img src="resources/img/icon/arrow-left.svg" alt="prev"></div>
        <div class="slide-btn next-btn"><img src="resources/img/icon/arrow-right.svg" alt="next"></div>
    </div>
    </div>
    <%@include file="footer.jsp" %>
    <script>
        // 페이지가 로드될 때 실행할 함수
        $(document).ready(function () {
            let ticker = function () {
                setTimeout(function () {
                    $('#ticker li:first').animate({marginTop: '-20px'}, 400, function () {
                        $(this).detach().appendTo('ul#ticker').removeAttr('style');
                    });
                    ticker();
                }, 3000);
            };
            // Ajax 요청 실행
            $.ajax({
                url: '/popularKeyword',
                type: 'GET',
                dataType: 'json',
                success: function (data) {
                    // Ajax 요청이 성공했을 때 실행할 콜백 함수
                    // data 변수에 가져온 데이터가 들어있음
                    console.log(data);
                    var rank = 1;
                    $.each(data, function (index, item) {
                        $('#ticker').append('<li><a href="#"><span>' + (rank++) + '</span> ' + item.keyword + '</a></li>');
                    });
                    ticker();
                },
                error: function () {
                    // Ajax 요청이 실패했을 때 실행할 콜백 함수
                    console.error('Ajax 요청 실패');
                }
            });
        });


        $("#checkingAllergies").click(function () {
            modalShow();
        });

        $("#modal-close").click(function () {
            // 모달 내의 모든 체크 박스를 선택하고 해제합니다.
            $(".allergy-check-btn input[type='checkbox']").prop("checked", false);
            modalHide();
        });

        $("#checkedAllergiesData").click(function () {
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
</body>
</html>