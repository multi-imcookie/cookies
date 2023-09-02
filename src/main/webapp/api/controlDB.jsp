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
            $('#initialize').click(function () {
                if (!confirm("주의!\n이 작업은 DB의 모든 데이터를 삭제합니다. 계속하시겠습니까?")) {
                } else {
                    $.ajax({
                        url: "initializeDB",
                        success: function (result) {
                            $('#result').html(result + "건 초기화 완료!")
                        }
                    }) // ajax
                }
            }) // initialize
        }) // $
    </script>
</head>
<body>
    <%@include file="/header.jsp" %>
    <div class="sub-container">
        <div class="btn-wrap">
            <button id="update" class="fill-btn">DB 업데이트</button>
            <%--            <button id="insert" class="light-fill-btn" style="color:red">DB 생성(초기화 후 1회만 사용하세요!)</button>--%>
            <button id="initialize" class="light-fill-btn" style="color:red">DB 초기화 (사용 시 주의하세요!)</button>
        </div>
        <div id="result" class="p-medium mt-3">
        </div>
    </div>
    <%@include file="/footer.jsp" %>
</body>
</html>
