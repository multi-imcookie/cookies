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

        .modal-box {
            position: absolute;
            display: flex;
            width: 600px;
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
            transform: translate(-50%, 0);
        }

        .search-item {
            background-color: #F9F5F2;
            border-radius: 12px;
            padding: 15px;
            box-sizing: border-box;
            transition: all .3s;
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
                <div><p class="h-pre24"><span>상세정보</span><br>
                    ${searchDTO.snack_name}</p>
                </div>
                <div class="search-item"><img src="${searchDTO.snack_img}" style="width:400px"></div>
                <div class="detail-container">
                    <div class="detail-content" style="height: 40vh; overflow-y: auto;">
                        <div class="detail-row">원재료 : ${searchDTO.snack_ingredients}</div>
                        <div class="detail-row">알러지 유발 성분 : ${searchDTO.allergy}</div>
                        <table class="table" border="1">
                            <tr>
                                <td>열량</td>
                                <td>${searchDTO.kcal}kcal</td>
                            </tr>
                            <tr>
                                <td>나트륨</td>
                                <td>${searchDTO.sodium}mg</td>
                            </tr>
                            <tr>
                                <td>탄수화물</td>
                                <td>${searchDTO.carb}g</td>
                            </tr>
                            <tr>
                                <td>당류</td>
                                <td>${searchDTO.sugars}g</td>
                            </tr>
                            <tr>
                                <td>단백질</td>
                                <td>${searchDTO.protein}g</td>
                            </tr>
                            <tr>
                                <td>콜레스테롤</td>
                                <td>${searchDTO.cholesterol}mg</td>
                            </tr>
                            <tr>
                                <td>지방</td>
                                <td>${searchDTO.fat}g</td>
                            </tr>
                            <tr>
                                <td>포화지방</td>
                                <td>${searchDTO.saturated_fat}g</td>
                            </tr>
                            <tr>
                                <td>트랜스지방</td>
                                <td>${searchDTO.trans_fat}g</td>
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
                <p class="p-regular">${searchDTO.company}</p>
                <div class="detail-row">
                    <span class="h-imcre24">${searchDTO.snack_name} </span>
                    <span class="p-regular">(${searchDTO.netwt}g / ${searchDTO.kcal}kcal)</span>
                </div>
                <div class="detail-row">탄수화물 : ${searchDTO.carb}g</div>
                <div class="detail-row">당류 : ${searchDTO.sugars}g</div>
                <div class="detail-row">나트륨 : ${searchDTO.sodium}mg</div>
                <div class="detail-row">단백질 : ${searchDTO.protein}g</div>
                <div class="detail-row">알러지 : ${searchDTO.allergy}</div>
                <div class="detail-row">
                    <button class="btn" id="detailInfo">상세보기</button>
                </div>
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
