<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2023-08-17
  Time: 오전 9:33
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>전과자</title>
    <%@ include file="/link.jsp" %>
    <c:if test="${sessionScope.memberGrade != 99}">
        <script>
            alert("권한이 없습니다.")
            location.replace("/index.jsp");
        </script>
    </c:if>
    <script type="text/javascript">
        $(function () {
            $('#update').click(function () {
                if (!confirm("이 작업은 오래 걸릴 수 있습니다. 계속하시겠습니까?")) {
                } else {
                    $('#result').html("DB 업데이트 중... 잠시 기다려주세요<br>>API 통신 속도에 따라 1분 이상 소요될 수 있습니다.")
                    $.ajax({
                        url: "updateDB",
                        success: function (result) {
                            $('#result').html(result + "건 업데이트 완료!")
                        }
                    }) // ajax
                }
            }) // update
            $('#insert-btn').click(function () {
                if (!confirm("정말 추가하시겠습니까?")) {
                } else {
                    $.ajax({
                        type: "post",
                        url: "insertDB",
                        data: $('#insert').serialize(),
                        success: function () {
                            alert("추가 성공!")
                        }, error: function () {
                            alert("추가 실패")
                        }
                    })  // ajax
                }
            })  // insert
            $('#delete-btn').click(function () {
                if (!confirm("정말 삭제하시겠습니까?\n삭제한 항목은 되돌릴 수 없습니다.")) {
                } else {
                    $.ajax({
                        type: "get",
                        url: "deleteDB",
                        data: $('#snack_id'),
                        success: function (result) {
                            console.log(result)
                            alert("삭제 성공!")
                        }, error: function () {
                            alert("삭제 실패")
                        }
                    })  // ajax
                }
            })  // delete
            $('#search-btn').click(function () {
                $.ajax({
                    type: "get",
                    url: "searchSnackId",
                    data: $('#snack_name_search').serialize(),
                    success: function (result) {
                        $('#search-result').html(result)
                    }, error: function () {
                        alert("검색 실패")
                    }
                })  // ajax
            })  // delete
            // $('#insert').click(function () {
            //     if (!confirm("이 작업을 하기 전, 초기화를 먼저 진행해 주세요.\n이 작업은 오래 걸릴 수 있습니다. 계속하시겠습니까?")) {
            //     } else {
            //         $('#result').html("DB 생성 중... 잠시 기다려주세요<br>API 통신 속도에 따라 1분 이상 소요될 수 있습니다.")
            //         $.ajax({
            //             url: "insertDB",
            //             success: function (result) {
            //                 $('#result').html(result + "건 생성 완료!")
            //             }
            //         }) // ajax
            //     }
            // }) // insert
            // $('#initialize').click(function () {
            //     if (!confirm("주의!\n이 작업은 DB의 모든 데이터를 삭제합니다. 계속하시겠습니까?")) {
            //     } else {
            //         $.ajax({
            //             url: "initializeDB",
            //             success: function (result) {
            //                 $('#result').html(result + "건 초기화 완료!")
            //             }
            //         }) // ajax
            //     }
            // }) // initialize
        }) // $
    </script>
    <style>
        .modal-overlay {
            position: fixed;
            z-index: 100;
            display: none;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.15);
        }

        .modal-box {
            position: absolute;
            display: flex;
            width: 680px;
            padding: 48px;
            box-sizing: border-box;
            flex-direction: column;
            align-items: center;
            gap: 24px;
            border-radius: 24px;
            background-color: #ffffff;
            margin: 0 auto;
            left: 50%;
            transition: transform 0.5s cubic-bezier(0.68, -0.55, 0.27, 1.55);
        }

        .modal-box.active {
        }

        #modal-close {
            position: absolute;
            top: 24px;
            right: 24px;
        }

        .form-style {
            display: flex;
            width: 100%;
            flex-direction: column;
            gap: 8px;
            margin: 0 auto;
        }

        .form-style input[type=text], input[type=password], input[type=number] {
            display: flex;
            padding: 5px 20px;
            box-sizing: border-box;
            align-items: flex-start;
            flex: 1 0 0;
            line-height: 5px;
            color: #5C492C;
            background-color: #F9F5F2;
            border-radius: 12px;
        }

        .fill-btn, .light-fill-btn, .dark-fill-btn {
            display: flex;
            padding: 20px 20px;
            box-sizing: border-box;
            justify-content: center;
            align-items: center;
            align-self: stretch;
            border-radius: 12px;
            font-size: 16px;
            font-weight: 500;
            line-height: 15px;
            cursor: pointer;
            flex: 1 0 0;
            transition: all .3s;
            gap: 8px;
        }
    </style>
</head>
<body>
    <%@include file="/header.jsp" %>
    <div id="modal-overlay" class="modal-overlay">
        <div id="modal-box" class="modal-box">
            <div class="mdl-text">
                <p class="h-pre24"><span>새 DB 항목 추가하기</span></p>
                <div class="mdl-info p-regular">
                    <form onsubmit="return false;" class="form-style" id="insert">
                        <div class="input-section">
                            <label class="label-wrap" for="snack_name">과자명<span class="require-val">*</span></label>
                            <input type="text" id="snack_name" name="snack_name" required>
                        </div>
                        <div class="input-section">
                            <label class="label-wrap" for="snack_img">이미지(URL)</label>
                            <input type="text" id="snack_img" name="snack_img">
                        </div>
                        <div class="input-section">
                            <label class="label-wrap" for="company">제조사<span class="require-val">*</span></label>
                            <input type="text" id="company" name="company" required>
                        </div>
                        <div class="input-section">
                            <label class="label-wrap" for="snack_ingredients">원재료</label>
                            <input type="text" id="snack_ingredients" name="snack_ingredients">
                        </div>
                        <div class="input-section">
                            <label class="label-wrap" for="allergy">알레르기 유발 성분</label>
                            <input type="text" id="allergy" name="allergy">
                        </div>
                        <div class="input-section">
                            <label class="label-wrap" for="netwt">총 내용량</label>
                            <input type="text" id="netwt" name="netwt" value="0">
                        </div>
                        <div class="input-section">
                            <label class="label-wrap" for="kcal">열량</label>
                            <input type="text" id="kcal" name="kcal" value="0">
                        </div>
                        <div class="input-section">
                            <label class="label-wrap" for="carb">탄수화물</label>
                            <input type="text" id="carb" name="carb" value="0">
                        </div>
                        <div class="input-section">
                            <label class="label-wrap" for="protein">단백질</label>
                            <input type="text" id="protein" name="protein" value="0">
                        </div>
                        <div class="input-section">
                            <label class="label-wrap" for="fat">지방</label>
                            <input type="text" id="fat" name="fat" value="0">
                        </div>
                        <div class="input-section">
                            <label class="label-wrap" for="sugars">당류</label>
                            <input type="text" id="sugars" name="sugars" value="0">
                        </div>
                        <div class="input-section">
                            <label class="label-wrap" for="calcium">칼슘</label>
                            <input type="text" id="calcium" name="calcium" value="0">
                        </div>
                        <div class="input-section">
                            <label class="label-wrap" for="sodium">나트륨</label>
                            <input type="text" id="sodium" name="sodium" value="0">
                        </div>
                        <div class="input-section">
                            <label class="label-wrap" for="cholesterol">콜레스테롤</label>
                            <input type="text" id="cholesterol" name="cholesterol" value="0">
                        </div>
                        <div class="input-section">
                            <label class="label-wrap" for="saturated_fat">포화지방</label>
                            <input type="text" id="saturated_fat" name="saturated_fat" value="0">
                        </div>
                        <div class="input-section">
                            <label class="label-wrap" for="trans_fat">트랜스지방</label>
                            <input type="text" id="trans_fat" name="trans_fat" value="0">
                        </div>
                    </form>
                </div>
            </div>
            <div class="btn-wrap">
                <a href="#" id="clearForm" class="light-fill-btn p-medium">폼 초기화</a>
                <button id="insert-btn" form="insert" class="fill-btn">추가</button>
                <a href="#" id="modal-close" class="modal-close light-fill-btn p-medium btn-close"></a>
            </div>
        </div>
    </div>
    <div id="modal-overlay-2" class="modal-overlay">
        <div id="modal-box-2" class="modal-box">
            <div class="mdl-text">
                <p class="h-pre24"><span>삭제할 snack_id 입력</span></p>
                <div class="mdl-info p-regular form-style">
                    <div class="input-section">
                        <label class="label-wrap" for="snack_id">snack_id</label>
                        <input type="text" id="snack_id" name="snack_id">
                    </div>
                </div>
            </div>
            <div class="btn-wrap">
                <button id="delete-btn" class="fill-btn">삭제</button>
                <a href="#" id="modal-close-2" class="modal-close light-fill-btn p-medium btn-close"></a>
            </div>
            <div class="mdl-text">
                <p class="h-pre24"><span>이름으로 snack_id 검색</span></p>
                <div class="mdl-info p-regular form-style">
                    <div class="input-section">
                        <label class="label-wrap" for="snack_name">과자명</label>
                        <input type="text" id="snack_name_search" name="snack_name">
                    </div>
                    <div id="search-result" class="p-regular">
                    </div>
                </div>
            </div>
            <div class="btn-wrap">
                <button id="search-btn" class="fill-btn">검색</button>
            </div>
        </div>
    </div>
    <div class="sub-container">
        <div class="btn-wrap">
            <button id="update" class="fill-btn">DB 업데이트</button>
            <button id="modal-insert" class="fill-btn">새 DB 추가하기</button>
            <button id="modal-delete" class="light-fill-btn" style="color:red">선택 DB 삭제하기</button>
            <%--            <button id="initialize" class="light-fill-btn" style="color:red">DB 초기화 (사용 시 주의하세요!)</button>--%>
        </div>
        <div id="result" class="p-medium mt-3">
        </div>
    </div>
    <script>

        // 입력값 초기화 함수
        document.addEventListener("DOMContentLoaded", function () {
            var clearLink = document.getElementById("clearForm");
            var form = document.getElementById("insert");

            clearLink.addEventListener("click", function (event) {
                event.preventDefault(); // 기본 링크 동작 방지
                form.reset(); // 폼 내용 초기화 (모든 입력 필드 초기화)
            });
        });

        function modalShow() {
            $("#modal-overlay").fadeIn();
            $("#modal-box").addClass("active");
        }

        function modalHide() {
            $("#modal-overlay").fadeOut();
            $("#modal-box").removeClass("active");
        }

        //모달창 열기
        $("#modal-insert").click(function () {
            modalShow();
        });

        //모달창 닫기
        $("#modal-close").click(function () {
            modalHide();
        });

        function modalShow2() {
            $("#modal-overlay-2").fadeIn();
            $("#modal-box-2").addClass("active");
        }

        function modalHide2() {
            $("#modal-overlay-2").fadeOut();
            $("#modal-box-2").removeClass("active");
        }

        $("#modal-delete").click(function () {
            modalShow2();
        });

        //모달창 닫기
        $("#modal-close-2").click(function () {
            modalHide2();
        });

    </script>
    <%@include file="/footer.jsp" %>
</body>
</html>
