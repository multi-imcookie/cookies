<%--
  Created by IntelliJ IDEA.
  User: 고물오빠
  Date: 2023-08-16
  Time: 오전 10:48
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>전과자</title>
    <%@ include file="/link.jsp" %>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f5f5f5;
            margin: 0;
            padding: 20px;

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
            text-align: center;
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
<%@include file="/header.jsp" %>
<br>
<div class="detail-container">
    <div class="thumbnail"><img src="${searchDTO.snack_img}" alt="썸네일"></div>
    <div class="detail-content">
        <div class="detail-row">${searchDTO.snack_name}</div>
        <div class="detail-row">${searchDTO.company}</div>
        <div class="detail-row">${searchDTO.snack_ingredients}</div>
        <div class="detail-row">${searchDTO.allergy}</div>
    </div>
</div>
<br>
<%--<a href="<c:url value='snackWikiSearch.jsp?keyword=${keyword}'/>" id="goToSearchList">돌아가기</a>--%>
<a href="#" id="goToSearchList">
    <button type="button" class="btn" >돌아가기</button>
</a>
<br>
<script>
    $(document).ready(function () {
        $('#goToSearchList').click(function (event) {
            event.preventDefault(); // 기본 동작을 취소합니다.
            let pageNum = localStorage.getItem('currentPage');
            let storedKeyword = localStorage.getItem('keyword'); // 저장된 키워드 불러오기
            if(pageNum === null){
                window.location.href = 'snackWikiSearch?keyword=' + encodeURIComponent(storedKeyword);
            } else {
                window.location.href = 'snackWikiSearch?keyword=' + encodeURIComponent(storedKeyword) + '&page=' + encodeURIComponent(pageNum);
            }
        });
    });
</script>
<%@include file="/footer.jsp" %>
</body>
</html>
