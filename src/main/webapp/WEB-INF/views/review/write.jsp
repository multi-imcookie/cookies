<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>


<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>리뷰게시글 작성</title>
    <%@ include file="/link.jsp" %>
    <script>
        <!--$(document).ready(function(){-->
        document.addEventListener("DOMContentLoaded", function () {
            // 페이지 로드될 때 초기화 코드 실행
            localStorage.removeItem("selectedSnackInfo");

            $("#btnSave").click(function () {
                var review_title = $("#review_title").val();
                var review_content = $("#review_content").val();
                if (review_title == "") {
                    alert("제목을 입력하세요");
                    document.form1.review_title.focus();
                    return;
                }
                if (review_content == "") {
                    alert("내용을 입력하세요");
                    document.form1.review_content.focus();
                    return;
                }
                document.form1.submit();
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
            var popup = window.open("/snack/snackSelectPopup", "_blank", "width=800,height=600");
        }

        // AJAX를 통해 선택한 과자 정보 실시간 업데이트
        function updateSelectedSnackInfo() {
            var selectedSnackInfo = JSON.parse(localStorage.getItem("selectedSnackInfo"));
            var selectSnackResult = document.getElementById("selectSnackResult"); // div 요소 가져오기
            if (selectedSnackInfo) {
                // 선택한 과자 정보를 사용하여 업데이트
                $("#selectedSnackId").text(selectedSnackInfo.snackId);
                $("#selectedSnackName").text(selectedSnackInfo.snackName);
                $("#selectedSnackCompany").text(selectedSnackInfo.company);
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


        // function selectSnack(snackId, snackName) {
        //     // 선택된 과자 정보를 selectSnack DIV에 넣기
        //     $("#selectSnackResult").html("선택한 과자: " + snackName);

        //     // 선택한 과자 정보를 hidden input에 넣기 (전송을 위해)
        //     $("#selectedSnackId").val(snackId);
        // }
    </script>

</head>
<body>
<%@include file="/header.jsp" %>
<!-- %@include file="/WEB-INF/views/snack/snackReviewSearch.jsp" %> -->
<div class="sub-container">
    <h3 class="s-h-imcre24">리뷰게시판 작성</h3>
    <div id="selectSnack">
        <button type="button" id="btnSearch">검색</button>
        <div id="selectSnackResult" style="display: none;">
            <p>선택한 과자 정보:</p>
            <p>과자 ID: <span id="selectedSnackId"></span></p>
            <p>과자 이름: <span id="selectedSnackName"></span></p>
            <p>회사: <span id="selectedSnackCompany"></span></p>
            <!-- 추가 정보들을 필요에 따라 추가 -->
        </div>
    </div>
    <form class="form-style" name="form1" method="post" action="${path}/review/insert.do">

        <label>글제목</label>
        <input type="text" name="review_title" id="review_title" placeholder="제목을 입력하세요">


        <td>별점</td>
        <td>
            <input type="radio" name="review_score" value="1">1점</input>
            <input type="radio" name="review_score" value="2">2점</input>
            <input type="radio" name="review_score" value="3">3점</input>
            <input type="radio" name="review_score" value="4">4점</input>
            <input type="radio" name="review_score" value="5">5점</input>
        </td>
        <br>

        <label>내용</label><br>
        <textarea cols="50" rows="5" name="review_content" id="review_content" placeholder="내용을 입력하세요"></textarea><br>

        <%--    <label>사진파일 선택:</label>
            <input type="file" id="review_img" name="review_img"><br>--%>
        <!-- 선택한 과자 정보를 저장하는 hidden input -->
        <input type="hidden" name="snack_id" id="snack_id">
        <input type="hidden" name="member_id" id="member_id" value="1">

        <div style="width:650px; text-align: center;">
            <button type="button" id="btnSave">확인</button>
            <button type="reset">취소</button>
        </div>

    </form>

</div>
<%@include file="/footer.jsp" %>
<!--<script>
    $(document).ready(function () {
        // 페이지가 로드될 때 실행되는 부분

        // 선택한 과자 정보를 로컬 스토리지에서 가져오기
        var selectedSnackInfo = JSON.parse(localStorage.getItem("selectedSnackInfo"));

        // 함수를 정의하여 선택한 과자 정보를 업데이트하는 동작을 수행
        function updateSelectedSnackInfo() {
            if (selectedSnackInfo) {
                // 가져온 정보를 해당 요소에 표시
                console.log("정보 잘 가져왔어!");
                console.log("selectedSnackInfo: " + JSON.stringify(selectedSnackInfo)); // 객체를 JSON 문자열로 변환하여 출력
                $("#selectedSnackId").text(selectedSnackInfo.snackId);
                $("#selectedSnackName").text(selectedSnackInfo.snackName);
                $("#selectedSnackCompany").text(selectedSnackInfo.company);
                // ... 다른 정보들도 필요한 대로 추가
            } else {
                console.log("No selected snack information found.");
            }
        }

        // 페이지 로드 후 처음 실행
        updateSelectedSnackInfo();

    });
</script>-->
</body>
</html>