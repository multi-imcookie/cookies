<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>전과자</title>
    <%@ include file="/link.jsp" %>
    <style>
        body {
            font-family: Pretendard, sans-serif;
            font-size: 16px;
            font-weight: 400; /* weight 다름 */
            line-height: 28px;
        }

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

        .btn {
            font-weight: bold;
            display: flex;
            justify-content: center;
            align-items: center;
            width: 200px;
            height: 50px;
            margin: 0 auto;
            background-color: #CBB89B;
            border-radius: 10px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            padding: 10px;
            cursor: pointer;
        }


    </style>
</head>
<body>
<br>
<div class="sub-container">
    <div class="detail-container">
        <div class="thumbnail"><img src="${searchDTO.snack_img}" alt="썸네일"></div>
        <div class="detail-content">
            <div class="detail-row">과자 이름 : ${searchDTO.snack_name}</div>
            <div class="detail-row">회사 : ${searchDTO.company}</div>
            <div class="detail-row">원재료 : ${searchDTO.snack_ingredients}</div>
            <div class="detail-row">알러지 : ${searchDTO.allergy}</div>
        </div>
    </div>
    <div class="btn-wrap-row">
        <%--<a href="<c:url value='snackWikiSearch.jsp?keyword=${keyword}'/>" id="goToSearchList">돌아가기</a>--%>
        <a href="#" id="goToSearchList">
            <button type="button" class="btn">돌아가기</button>
        </a>
        <script>
            $(document).ready(function () {
                $('#goToSearchList').click(function (event) {
                    event.preventDefault(); // 기본 동작을 취소합니다.
                    let pageNum = localStorage.getItem('currentPage');
                    let storedKeyword = localStorage.getItem('keyword'); // 저장된 키워드 불러오기
                    if (pageNum === null) {
                        window.location.href = 'snackReviewSearch?keyword=' + encodeURIComponent(storedKeyword);
                    } else {
                        window.location.href = 'snackReviewSearch?keyword=' + encodeURIComponent(storedKeyword) + '&page=' + encodeURIComponent(pageNum);
                    }
                });
            });
        </script>
        <button type="button" class="btn" id="selectSnackBtn">선택하기</button>
        <script>
            $('#selectSnackBtn').click(function () {
                let selectedSnackInfo = {
                    snackId : "${searchDTO.snack_id}",
                    snackIngredients: "${searchDTO.snack_ingredients}",
                    snackName: "${searchDTO.snack_name}",
                    company: "${searchDTO.company}",
                    snackImg: "${searchDTO.snack_img}"
                    // ... 다른 정보들도 필요한 대로 추가
                };

                localStorage.setItem("selectedSnackInfo", JSON.stringify(selectedSnackInfo)); // 변경: sessionStorage -> localStorage

                // 팝업 창 닫기
                window.close();
            });

        </script>
    </div>
</div>
</body>
</html>
