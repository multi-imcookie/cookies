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
<%@include file="/filterModal.jsp"%>
<div class="visual">
    <div class="v-left">
        <div class="v-top">
            <h3 class="h-pre36">
                🔍<br>
                궁금한 과자가 있으신가요?
            </h3>
            <div class="popular-slide" id="popular-slide">
                <ul id="ticker">
                </ul>
            </div>
        </div>
        <form id="snackWikiSearchForm" action="/snack/snackWikiSearch" method="get"
              onsubmit="return validateFormAndAddAllergyData()">
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
                    <input class="p-regular" type="text" name="keyword" id="keyword" placeholder="검색하고 싶은 과자를 입력하세요.">
                </div>
                <input type="hidden" name="sortName" value="sortHighCalorie">
                <button class="search-btn"><img src="/resources/img/icon/search.svg" alt="돋보기 아이콘"></button>
            </div>
        </form>

<%@include file="/filter.jsp"%>

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
                let rank = 1;
                $.each(data, function (index, keyword) {
                    $('#ticker').append('<li><a href="#"><span>' + (rank++) + '</span> ' + keyword + '</a></li>');
                });
                ticker();
            },
            error: function () {
                // Ajax 요청이 실패했을 때 실행할 콜백 함수
                console.error('Ajax 요청 실패');
            }
        });
    });

    // 알레르기 정보 출력 후, span 클릭 시 동작
    $("#checkedAllergies").on("click", ".checked-allergy", function () {
        // 클릭한 요소가 이미지인 경우에만 실행
        if ($(event.target).is("img")) {
            // 클릭한 span 요소를 제거합니다.
            $(this).remove();

            // 해당 span 요소에 연결된 체크박스의 ID 가져오기
            let checkboxId = $(this).attr("data-checkbox-id");

            // 해당 ID를 가진 체크박스의 체크를 해제합니다.
            $("#" + checkboxId).prop("checked", false);

            // 체크박스의 변경 이벤트를 트리거하여 체크박스 상태가 변경되었음을 감지합니다.
            $("#" + checkboxId).trigger("change");
        }
    });

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
            let checkboxId = this.id; // 체크박스의 ID 가져오기
            let allergySpan = $("<span>").html(labelForAllergy).addClass('checked-allergy').attr('data-checkbox-id', checkboxId); // 라벨 내용을 span에 추가

            // 이미지 요소 생성 및 추가
            let img = $("<img>").attr('src', '/resources/img/icon/x-btn.svg').addClass('del-allergy-btn');
            allergySpan.append(img);

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
</body>
</html>