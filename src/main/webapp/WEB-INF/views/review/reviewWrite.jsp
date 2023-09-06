<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>리뷰게시글 작성</title>
    <%@ include file="/link.jsp" %>
    <script type="text/javascript">
        document.addEventListener("DOMContentLoaded", function () {
            localStorage.removeItem("selectedSnackInfo");
            $("#btn-Save").click(function () {
                let review_title = $("#review_title").val();
                let snack_id = $("#snack_id").val();
                let review_content = $("#review_content").val();
                let member_id = $("#member_id").val();
                if (review_title == "") {
                    alert("제목을 입력하세요");
                    document.form.review_title.focus();
                    return;
                }
                if (snack_id == "") {
                    alert("과자명을 입력하세요");
                    document.form.snack_id.focus();
                    return;
                }
                if (review_content == "") {
                    alert("내용을 입력하세요");
                    document.form.review_content.focus();
                    return;
                }
                if (member_id == "") {
                    alert("로그인 해주세요");
                    return;
                }
                document.form.submit();
            });

            $("#btnSearch").click(function () {
                openSearchPopup();
            });
            updateSelectedSnackInfo();
            window.addEventListener('storage', function (event) {
                if (event.key === "selectedSnackInfo") {
                    updateSelectedSnackInfo();
                }
            });
        });

        // 팝업 창에서 과자 선택 시 호출되는 함수
        function snackSelected(snackInfo) {
            // 수정: 선택한 과자 정보를 로컬 스토리지에 저장하고 실시간으로 업데이트하는 함수 호출
            localStorage.setItem("selectedSnackInfo", JSON.stringify(snackInfo));
            updateSelectedSnackInfo(); // 선택한 과자 정보 업데이트
        }

        function openSearchPopup() {
            window.open("/snack/snackSelectPopup", "_blank", "width=1200,height=900");
        }

        // AJAX를 통해 선택한 과자 정보 실시간 업데이트
        function updateSelectedSnackInfo() {
            var selectedSnackInfo = JSON.parse(localStorage.getItem("selectedSnackInfo"));
            var selectSnackResult = document.getElementById("selectSnackResult"); // div 요소 가져오기
            if (selectedSnackInfo) {
                // 선택한 과자 정보를 사용하여 업데이트
                $("#selectedSnackName").text(selectedSnackInfo.snackName);
                $("#selectedSnackCompany").text(selectedSnackInfo.company);
                $("#selectedSnackIngredients").text(selectedSnackInfo.snackIngredients);
                $("#selectedSnackImg").attr("src", selectedSnackInfo.snackImg);
                var getSnackId = selectedSnackInfo.snackId;
                console.log(getSnackId);
                $("#snack_id").val(getSnackId);

                // 선택한 과자 정보가 있을 때만 div 요소 보이기
                selectSnackResult.style.display = "block";

                // ... 다른 정보들도 필요한 대로 추가
            } else {
                console.log("No selected snack information found.");

                // 선택한 과자 정보가 없을 때는 div 요소 숨기기
                selectSnackResult.style.display = "none";
            }
        }

    </script>
    <style>
        .find-btn{
            text-align: center;
        }
        .find-btn1{
            display :inline-block;
        }
    </style>
</head>
<body>
<%@include file="/header.jsp" %>
<!-- %@include file="/WEB-INF/views/snack/snackReviewSearch.jsp" %> -->
<div class="sub-container">
    <h3 class="s-h-imcre24">리뷰게시판 작성</h3>

    <button class="dark-fill-btn p-medium" type="button" id="btnSearch">리뷰할 과자 검색</button>

    <div id="selectSnackResult" class="form-style" style="display: none;">
        <img id="selectedSnackImg" src="" alt="썸네일">
        <p>선택한 과자 정보</p>
        <p>과자 이름: <span id="selectedSnackName"></span></p>
        <p>회사: <span id="selectedSnackCompany"></span></p>
        <!-- 추가 정보들을 필요에 따라 추가 -->
    </div>
    <form name="form" method="post" class="form-style">
        <div class="input-section">
            <label for="review_title" class="label-wrap">글제목</label>
            <input type="text" name="review_title" id="review_title"
                   placeholder="제목을 입력하세요">
        </div>

        <div class="input-section">
            <p class="label-wrap">별점</p>
            <div class="radio-wrap">
                <div class="radio-label-wrap">
                    <input id="review_score1" type="radio" name="review_score" value="1">
                    <label for="review_score1"><img class="score-img" src="/resources/img/score/score01.png"></label>
                </div>
                <div class="radio-label-wrap">
                    <input id="review_score2" type="radio" name="review_score" value="2">
                    <label for="review_score2"><img class="score-img" src="/resources/img/score/score02.png"></label>
                </div>
                <div class="radio-label-wrap">
                    <input id="review_score3" type="radio" name="review_score" value="3" checked>
                    <label for="review_score3"><img class="score-img" src="/resources/img/score/score03.png"></label>
                </div>
                <div class="radio-label-wrap">
                    <input id="review_score4" type="radio" name="review_score" value="4">
                    <label for="review_score4"><img class="score-img" src="/resources/img/score/score04.png"></label>
                </div>
                <div class="radio-label-wrap">
                    <input id="review_score5" type="radio" name="review_score" value="5">
                    <label for="review_score5"><img class="score-img" src="/resources/img/score/score05.png"></label>
                </div>
            </div>
        </div>

        <div class="input-section">
            <label class="label-wrap" for="review_content">내용</label>
            <textarea cols="50" rows="5" name="review_content" id="review_content"
                      placeholder="내용을 입력하세요"></textarea>
        </div>

        <input type="hidden" name="snack_id" id="snack_id">
        <input type="hidden" name="member_id" id="member_id" value=${sessionScope.memberId}>

    </form>
    <div class="find-btn">
        <a><button type="submit" class="btn-Save fill-btn p-medium find-btn1" style="width:3cm" id="btn-Save">작성</button></a>
        <a href="/review/reviewList?num=1"><button class="light-fill-btn find-btn1" style="width:3cm">취소</button></a>
    </div>

</div>
<%@include file="/footer.jsp" %>
</body>
</html>
