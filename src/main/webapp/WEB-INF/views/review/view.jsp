<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<html>
<head>
    <title>리뷰게시판 보기</title>
    <%@ include file="/link.jsp" %>
    <script>
        $(document).ready(function () {
            $("#btnDelete").click(function () {
                if (confirm("삭제하시겠습니까?")) {
                    document.form1.action = "${path}/review/delete.do";
                    document.form1.submit();
                }
            });

            $("#btnUpdete").click(function () {
                var review_title = $("#review_title").val();
                var review_content = $("#review_content").val();
                var member_id = $("#member_id").val();
                if (review_title == "") {
                    alert("제목을 입력하세요");
                    document.form1.title.focus();
                    return;
                }
                if (review_content == "") {
                    alert("내용을 입력하세요");
                    document.form1.content.focus();
                    return;
                }
                if (member_id == "") {
                    alert("이름을 입력하세요");
                    document.form1.writer.focus();
                    return;
                }
                document.form1.action = "${path}/review/update.do"
                // 폼에 입력한 데이터를 서버로 전송
                document.form1.submit();
            });
        });
    </script>
    <style>
        .detail-container {
            display: flex;
            align-items: center;
            max-width: 800px;
            margin: 0 auto;
            background-color: white;
            border-radius: 10px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            padding: 20px;
        }

        .thumbnail img {
            max-width: 100%;
            border-radius: 5px;
        }

        .detail-content {
            margin-left: 20px;
        }

        .detail-row {
            margin-bottom: 10px;
        }
    </style>
</head>
<body>
<%@ include file="/header.jsp" %>
<div class="sub-container">
    <h2 class="s-h-imcre24">리뷰게시글 보기</h2>

    <form name="form1" method="post">

        <label>글제목: </label>
        ${dto.review_title}

        <div id="reviewSnack">
            <div class="detail-container">
                <div class="thumbnail"><img src="${snack.snack_img}" alt="썸네일"></div>
                <div class="detail-content">
                    <div class="detail-row">이름 : ${snack.snack_name}</div>
                    <br>
                    <div class="detail-row">제조회사 : ${snack.company}</div>
                    <br>
                    <div class="detail-row">원재료 : ${snack.snack_ingredients}</div>
                    <br>
                    <div class="detail-row">알러지 : ${snack.allergy}</div>
                </div>
            </div>
            <div>
                <label>내가 준 별점: </label>
                <div class="rating" id="rating"></div>
                <script>
                    var rating = ${dto.review_score};
                    var fullStars = Math.floor(rating);
                    var hasHalfStar = rating - fullStars >= 0.5;

                    for (var i = 0; i < fullStars; i++) {

                        document.getElementById("rating").innerHTML += "&#9733;";
                    }
                    if (hasHalfStar) {
                        document.getElementById("rating").innerHTML += "&#9733;";
                    }
                </script>
            </div>
        </div>


        <label>작성자: </label>
        ${dto.member_id}

        <label>작성일자: </label>
        <fmt:formatDate value="${dto.create_dt}" pattern="yyyy-MM-dd a HH:mm:ss"/> <br>

        <%--  <label>내용: </label>
          ${dto.review_content} <br>--%>

        <div>
            내용:
            <input name="review_content" id="review_content" value="${dto.review_content}" placeholder="내용을 입력해주세요">
            <%--    <textarea name="review_content" id="review_content" rows="4" cols="80" placeholder="내용을 입력해주세요">${dto.review_content}</textarea>--%>
        </div>

        <label>사진: </label>
        ${dto.review_img}


        <div style="width:650px; text-align: center;">
            <p><a href="/review/update?review_id=${dto.review_id}">수정하기</a></p>
            <!-- 게시물번호를 hidden으로 처리 -->
            <input type="hidden" name="review_id" value="${dto.review_id}">
            <%--    <td><a href="${path}/review/update.do?review_id=${dto.review_id}"><button type="button" id="btnUpdete" >수정</button></a></td>--%>
            <button type="button" id="btnUpdate">수정</button>
            <button type="button" id="btnDelete">삭제</button>
        </div>
    </form>
</div>
<%@include file="/footer.jsp" %>
</body>
</html>
