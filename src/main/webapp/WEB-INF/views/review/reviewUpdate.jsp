<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>


<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>리뷰게시글 수정</title>
    <%@ include file="/link.jsp" %>
    <script type="text/javascript">
        document.addEventListener("DOMContentLoaded", function () {
            // localStorage.removeItem("selectedSnackInfo");
            $("#btn-Update").click(function () {
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

            // $("#btnSearch").click(function () {
            //     openSearchPopup();
            // });
            // updateSelectedSnackInfo();
            // window.addEventListener('storage', function (event) {
            //     if (event.key === "selectedSnackInfo") {
            //         updateSelectedSnackInfo();
            //     }
            // });
        });

        // 팝업 창에서 과자 선택 시 호출되는 함수
        // function snackSelected(snackInfo) {
        //     // 수정: 선택한 과자 정보를 로컬 스토리지에 저장하고 실시간으로 업데이트하는 함수 호출
        //     localStorage.setItem("selectedSnackInfo", JSON.stringify(snackInfo));
        //     updateSelectedSnackInfo(); // 선택한 과자 정보 업데이트
        // }
        //
        // function openSearchPopup() {
        //     window.open("/snack/snackSelectPopup", "_blank", "width=800,height=600");
        // }

        // AJAX를 통해 선택한 과자 정보 실시간 업데이트
        // function updateSelectedSnackInfo() {
        //     var selectedSnackInfo = JSON.parse(localStorage.getItem("selectedSnackInfo"));
        //     // var selectSnackResult = document.getElementById("selectSnackResult"); // div 요소 가져오기
        //     if (selectedSnackInfo) {
        //         // 선택한 과자 정보를 사용하여 업데이트
        //         $("#selectedSnackName").text(selectedSnackInfo.snackName);
        //         $("#selectedSnackCompany").text(selectedSnackInfo.company);
        //         $("#selectedSnackIngredients").text(selectedSnackInfo.snackIngredients);
        //         $("#selectedSnackImg").attr("src", selectedSnackInfo.snackImg);
        //         var getSnackId = selectedSnackInfo.snackId;
        //         console.log(getSnackId);
        //         $("#snack_id").val(getSnackId);
        //
        //         // 선택한 과자 정보가 있을 때만 div 요소 보이기
        //         // selectSnackResult.style.display = "block";
        //
        //         // ... 다른 정보들도 필요한 대로 추가
        //     } else {
        //         console.log("No selected snack information found.");
        //
        //         // 선택한 과자 정보가 없을 때는 div 요소 숨기기
        //         // selectSnackResult.style.display = "none";
        //     }
        // }

    </script>

    <style>
        .detail-container {
            display: flex;
            width: 100%;
            gap: 4%;
            justify-content: space-between;
        }

        .detail-content {
            width: 70%;
        }

        .detail-row {
            margin-bottom: 10px;
        }
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
<div class="sub-container">
    <h3 class="s-h-imcre24">리뷰게시판 수정</h3>

    <%--    <button class="fill-btn p-medium" type="button" id="btnSearch">리뷰 과자 검색</button>

        <div id="selectSnackResult" class="form-style" style="display: none;">
            <img id="selectedSnackImg" src="" alt="썸네일" value="${snackDTO.snack_img}">
            <p>선택한 과자 정보</p>
            <p>과자 이름: <span id="selectedSnackName" value="${snackDTO.snack_name}"></span></p>
            <p>회사: <span id="selectedSnackCompany" value="${snackDTO.company}"></span></p>
            <p>원재료: <span id="selectedSnackIngredients" value="${snackDTO.snack_ingredients}"></span></p>
            <!-- 추가 정보들을 필요에 따라 추가 -->
        </div>--%>
    <div class="detail-container p-regular">
        <div class="thumbnail detail-thumbnail" style="background-image: url(${snackDTO.snack_img})"></div>
        <div class="detail-content">
            <p style="color: #B48D69;">${snackDTO.company}</p>
            <div class="detail-row">
                <span class="h-imcre24">${snackDTO.snack_name} </span>
                <span style="color: #B48D69;">(${snackDTO.netwt}g / ${snackDTO.kcal}kcal)</span>
                <c:choose>
                    <c:when test="${snackDTO.avg_score >= 1 && snackDTO.avg_score < 1.5}">
                        <c:set var="scoreImg" value="<img src='/resources/img/score/score01.png' height='24'>"/>
                    </c:when>
                    <c:when test="${snackDTO.avg_score >= 1.5 && snackDTO.avg_score < 2}">
                        <c:set var="scoreImg"
                               value="<img src='/resources/img/score/score_01_half.png' height='24'>"/>
                    </c:when>
                    <c:when test="${snackDTO.avg_score >= 2 && snackDTO.avg_score < 2.5}">
                        <c:set var="scoreImg" value="<img src='/resources/img/score/score02.png' height='24'>"/>
                    </c:when>
                    <c:when test="${snackDTO.avg_score >= 2.5 && snackDTO.avg_score < 3}">
                        <c:set var="scoreImg"
                               value="<img src='/resources/img/score/score_02_half.png' height='24'>"/>
                    </c:when>
                    <c:when test="${snackDTO.avg_score >= 3 && snackDTO.avg_score < 3.5}">
                        <c:set var="scoreImg" value="<img src='/resources/img/score/score03.png' height='24'>"/>
                    </c:when>
                    <c:when test="${snackDTO.avg_score >= 3.5 && snackDTO.avg_score < 4}">
                        <c:set var="scoreImg"
                               value="<img src='/resources/img/score/score_03_half.png' height='24'>"/>
                    </c:when>
                    <c:when test="${snackDTO.avg_score >= 4 && snackDTO.avg_score < 4.5}">
                        <c:set var="scoreImg" value="<img src='/resources/img/score/score04.png' height='24'>"/>
                    </c:when>
                    <c:when test="${snackDTO.avg_score >= 4.5 && snackDTO.avg_score < 5}">
                        <c:set var="scoreImg"
                               value="<img src='/resources/img/score/score_04_half.png' height='24'>"/>
                    </c:when>
                    <c:when test="${snackDTO.avg_score == 5}">
                        <c:set var="scoreImg" value="<img src='/resources/img/score/score05.png' height='24'>"/>
                    </c:when>
                    <c:otherwise/>
                </c:choose>
                <p style="color: #B48D69; margin-top:5px">${scoreImg} 평점 (${snackDTO.avg_score}
                    / ${snackDTO.review_count}개)</p>
            </div>
            <div style="margin: 20px 0 30px 0;">
                <div class="detail-row">탄수화물 : ${snackDTO.carb}g</div>
                <div class="detail-row">당류 : ${snackDTO.sugars}g</div>
                <div class="detail-row">나트륨 : ${snackDTO.sodium}mg</div>
                <div class="detail-row">단백질 : ${snackDTO.protein}g</div>
                <div class="detail-row">알러지 : ${snackDTO.allergy}</div>
                <div class="detail-row">
                </div>
            </div>
        </div>
    </div>

    <form name="form" method="post" class="form-style">
        <div class="input-section">
            <label for="review_title" class="label-wrap">글제목</label>
            <input type="text" name="review_title" id="review_title"
                   placeholder="제목을 입력하세요" value="${read.review_title}">
        </div>

        <div class="input-section">
            <p class="label-wrap">별점</p>
            <div class="radio-wrap">
                <div class="radio-label-wrap">
                    <input id="review_score1" type="radio" name="review_score" value="1">
                    <label for="review_score1"><img class="score-img"
                                                    src="/resources/img/score/score01.png"></label>
                </div>
                <div class="radio-label-wrap">
                    <input id="review_score2" type="radio" name="review_score" value="2">
                    <label for="review_score2"><img class="score-img"
                                                    src="/resources/img/score/score02.png"></label>
                </div>
                <div class="radio-label-wrap">
                    <input id="review_score3" type="radio" name="review_score" value="3">
                    <label for="review_score3"><img class="score-img"
                                                    src="/resources/img/score/score03.png"></label>
                </div>
                <div class="radio-label-wrap">
                    <input id="review_score4" type="radio" name="review_score" value="4">
                    <label for="review_score4"><img class="score-img"
                                                    src="/resources/img/score/score04.png"></label>
                </div>
                <div class="radio-label-wrap">
                    <input id="review_score5" type="radio" name="review_score" value="5">
                    <label for="review_score5"><img class="score-img"
                                                    src="/resources/img/score/score05.png"></label>
                </div>
            </div>
        </div>

        <div class="input-section">
            <label class="label-wrap" for="review_content">내용</label>
            <textarea cols="50" rows="5" name="review_content" id="review_content"
                      placeholder="내용을 입력하세요">${read.review_content}</textarea>
        </div>

        <input type="hidden" name="snack_id" id="snack_id" value="${snackDTO.snack_id}">
        <input type="hidden" name="member_id" id="member_id" value=${sessionScope.memberId}>

        <div class="find-btn">
            <a><button type="submit" class="btn-Update fill-btn p-medium find-btn1" style="width:3cm" id="btn-Update">수정</button></a>
            <a href="/review/reviewView?review_id=${reviewDTO.review_id}"><button class="light-fill-btn find-btn1" style="width:3cm">취소</button></a>
        </div>

    </form>


</div>
<%@include file="/footer.jsp" %>

</body>
</html>