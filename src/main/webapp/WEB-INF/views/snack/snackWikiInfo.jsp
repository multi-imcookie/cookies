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
            font-family: Pretendard, sans-serif;
            font-size: 16px;
            font-weight: 400; /* weight 다름 */
            line-height: 28px;
        }

        .detail-container {
            display: flex;
            align-items: center;
            max-width: 850px;
            margin: 0 auto;
            background-color: white;
            border-radius: 10px;
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
            background-color: #B48D69;
            border-radius: 10px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            padding: 10px;
            cursor: pointer;
            color: white;
        }

        .modal-box {
            position: absolute;
            display: flex;
            width: 800px;
            padding: 20px;
            box-sizing: border-box;
            flex-direction: column;
            align-items: center;
            gap: 48px;
            border-radius: 24px;
            background-color: #ffffff;
            margin: 0 auto;
            left: 50%;
            transform: translate(160%, 22%);
            transition: transform 0.5s cubic-bezier(0.68, -0.55, 0.27, 1.55);
        }

        .modal-box.active {
            transform: translate(-50%, 10%);
        }

        .search-item {
            background-color: #F9F5F2;
            border-radius: 12px;
            padding: 15px;
            box-sizing: border-box;
            transition: all .3s;
        }

        td.td-left {
            font-family: Pretendard, sans-serif;
            font-size: 16px;
            font-weight: 400;
            line-height: 28px;
            background-color: #F9F5F2;
            color: #5C492C;
            text-align: center;
            vertical-align: middle;
        }

        td.td-right {
            font-family: Pretendard, sans-serif;
            font-size: 16px;
            font-weight: 400;
            line-height: 28px;
            margin-left: 10%;
            width: 80%;
            color: #5C492C;
        }
    </style>
</head>
<body>
    <%@include file="/header.jsp" %>
    <div class="modal-overlay">
        <div class="modal-box">
            <div class="mdl-text">
                <div style="float:right">
                    <button type="button" id="modal-close" class="btn-close" aria-label="Close"></button>
                </div>
                <div><p class="h-pre24"><span>상세정보</span>
                    ${searchDTO.snack_name}</p>
                </div>
                <div class="detail-container p-medium">
                    <div class="detail-content" style="height: 45vh; overflow-y: auto;">
                        <table class="table">
                            <tr>
                                <td class="td-left">원재료</td>
                                <td class="td-right">${searchDTO.snack_ingredients}</td>
                            </tr>
                            <tr>
                                <td class="td-left">열량</td>
                                <td class="td-right">${searchDTO.kcal}kcal</td>
                            </tr>
                            <tr>
                                <td class="td-left">나트륨</td>
                                <td class="td-right">${searchDTO.sodium}mg</td>
                            </tr>
                            <tr>
                                <td class="td-left">탄수화물</td>
                                <td class="td-right">${searchDTO.carb}g</td>
                            </tr>
                            <tr>
                                <td class="td-left">당류</td>
                                <td class="td-right">${searchDTO.sugars}g</td>
                            </tr>
                            <tr>
                                <td class="td-left">단백질</td>
                                <td class="td-right">${searchDTO.protein}g</td>
                            </tr>
                            <tr>
                                <td class="td-left">콜레스테롤</td>
                                <td class="td-right">${searchDTO.cholesterol}mg</td>
                            </tr>
                            <tr>
                                <td class="td-left">지방</td>
                                <td class="td-right">${searchDTO.fat}g</td>
                            </tr>
                            <tr>
                                <td class="td-left">포화지방</td>
                                <td class="td-right">${searchDTO.saturated_fat}g</td>
                            </tr>
                            <tr>
                                <td class="td-left">트랜스지방</td>
                                <td class="td-right">${searchDTO.trans_fat}g</td>
                            </tr>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="sub-container">
        <div class="detail-container">
            <div class="thumbnail search-item"><img src="${searchDTO.snack_img}" alt="썸네일"></div>
            <div class="detail-content" style="width:70%">
                <p style="color: #B48D69;">${searchDTO.company}</p>
                <div class="detail-row">
                    <span class="h-imcre24">${searchDTO.snack_name} </span>
                    <span style="color: #B48D69;">(${searchDTO.netwt}g / ${searchDTO.kcal}kcal)</span>
                    <c:choose>
                        <c:when test="${searchDTO.avg_score >= 1 && searchDTO.avg_score < 1.5}">
                            <c:set var="scoreImg" value="<img src='/resources/img/score/score01.png' height='24'>"/>
                        </c:when>
                        <c:when test="${searchDTO.avg_score >= 1.5 && searchDTO.avg_score < 2}">
                            <c:set var="scoreImg"
                                   value="<img src='/resources/img/score/score_01_half.png' height='24'>"/>
                        </c:when>
                        <c:when test="${searchDTO.avg_score >= 2 && searchDTO.avg_score < 2.5}">
                            <c:set var="scoreImg" value="<img src='/resources/img/score/score02.png' height='24'>"/>
                        </c:when>
                        <c:when test="${searchDTO.avg_score >= 2.5 && searchDTO.avg_score < 3}">
                            <c:set var="scoreImg"
                                   value="<img src='/resources/img/score/score_02_half.png' height='24'>"/>
                        </c:when>
                        <c:when test="${searchDTO.avg_score >= 3 && searchDTO.avg_score < 3.5}">
                            <c:set var="scoreImg" value="<img src='/resources/img/score/score03.png' height='24'>"/>
                        </c:when>
                        <c:when test="${searchDTO.avg_score >= 3.5 && searchDTO.avg_score < 4}">
                            <c:set var="scoreImg"
                                   value="<img src='/resources/img/score/score_03_half.png' height='24'>"/>
                        </c:when>
                        <c:when test="${searchDTO.avg_score >= 4 && searchDTO.avg_score < 4.5}">
                            <c:set var="scoreImg" value="<img src='/resources/img/score/score04.png' height='24'>"/>
                        </c:when>
                        <c:when test="${searchDTO.avg_score >= 4.5 && searchDTO.avg_score < 5}">
                            <c:set var="scoreImg"
                                   value="<img src='/resources/img/score/score_04_half.png' height='24'>"/>
                        </c:when>
                        <c:when test="${searchDTO.avg_score == 5}">
                            <c:set var="scoreImg" value="<img src='/resources/img/score/score05.png' height='24'>"/>
                        </c:when>
                        <c:otherwise/>
                    </c:choose>
                    <p style="color: #B48D69; margin-top:5px">${scoreImg} 리뷰 (${searchDTO.avg_score} / ${searchDTO.review_count}개)</p>
                </div>
                <div style="margin: 20px 0 30px 0;">
                    <div class="detail-row">탄수화물 : ${searchDTO.carb}g</div>
                    <div class="detail-row">당류 : ${searchDTO.sugars}g</div>
                    <div class="detail-row">나트륨 : ${searchDTO.sodium}mg</div>
                    <div class="detail-row">단백질 : ${searchDTO.protein}g</div>
                    <div class="detail-row">알러지 : ${searchDTO.allergy}</div>
                    <div class="detail-row">
                    </div>
                </div>
                <button class="btn" id="detailInfo" style="background-color: #CBB89B;">상세보기</button>
            </div>
        </div>
        <%--<a href="<c:url value='snackWikiSearch.jsp?keyword=${keyword}'/>" id="goToSearchList">돌아가기</a>--%>
        <a href="#" id="goToSearchList">
            <button type="button" class="btn">돌아가기</button>
        </a>
    </div>
    <script>
        $(document).ready(function () {
            $('#goToSearchList').click(function (event) {
                event.preventDefault(); // 기본 동작을 취소합니다.
                let pageNum = localStorage.getItem('currentPage');
                let storedKeyword = localStorage.getItem('keyword'); // 저장된 키워드 불러오기
                if (pageNum === null) {
                    window.location.href = 'snackWikiSearch?keyword=' + encodeURIComponent(storedKeyword);
                } else {
                    window.location.href = 'snackWikiSearch?keyword=' + encodeURIComponent(storedKeyword) + '&page=' + encodeURIComponent(pageNum);
                }
            });
        });
        $("#detailInfo").click(function () {
            modalShow();
        });
        $("#modal-close").click(function () {
            modalHide();
        })
    </script>
    <%@include file="/footer.jsp" %>
</body>
</html>
