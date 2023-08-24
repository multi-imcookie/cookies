<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<html>
<head>
    <title>전과자</title>
    <%@ include file="/link.jsp" %>
</head>
<body>
<%@include file="/header.jsp" %>
<div class="sub-container">
    <div class="checkbox-container-left">
        <div class="checkbox-row">
            <div>
                <input type="checkbox" name="egg_allergy" value="1">
                <img src="egg_allergy.jpg" alt="egg_allergy">
            </div>
            <div>
                <input type="checkbox" name="milk_allergy" value="1">
                <img src="milk_allergy.jpg" alt="milk_allergy">
            </div>
            <div>
                <input type="checkbox" name="wheat_allergy" value="1">
                <img src="wheat_allergy.jpg" alt="wheat_allergy">
            </div>
            <div>
                <input type="checkbox" name="buckwheat_allergy" value="1">
                <img src="buckwheat_allergy.jpg" alt="buckwheat_allergy">
            </div>
            <div>
                <input type="checkbox" name="peanut_allergy" value="1">
                <img src="peanut_allergy.jpg" alt="peanut_allergy">
            </div>
            <div>
                <input type="checkbox" name="soy_allergy" value="1">
                <img src="soy_allergy.jpg" alt="soy_allergy">
            </div>
            <div>
                <input type="checkbox" name="pine_nut_allergy" value="1">
                <img src="pine_nut_allergy.jpg" alt="pine_nut_allergy">
            </div>
            <div>
                <input type="checkbox" name="almond_allergy" value="1">
                <img src="almond_allergy.jpg" alt="almond_allergy">
            </div>
            <div>
                <input type="checkbox" name="walnut_allergy" value="1">
                <img src="walnut_allergy.jpg" alt="walnut_allergy">
            </div>
            <div>
                <input type="checkbox" name="crab_allergy" value="1">
                <img src="crab_allergy.jpg" alt="crab_allergy">
            </div>
        </div>
        <div class="checkbox-container-right">
            <div class="checkbox-row">
                <div>
                    <input type="checkbox" name="shrimp_allergy" value="1">
                    <img src="shrimp_allergy.jpg" alt="shrimp_allergy">
                </div>
                <div>
                    <input type="checkbox" name="squid_allergy" value="1">
                    <img src="squid_allergy.jpg" alt="squid_allergy">
                </div>
                <div>
                    <input type="checkbox" name="mackerel_allergy" value="1">
                    <img src="mackerel_allergy.jpg" alt="mackerel_allergy">
                </div>
                <div>
                    <input type="checkbox" name="shellfish_allergy" value="1">
                    <img src="shellfish_allergy.jpg" alt="shellfish_allergy">
                </div>
                <div>
                    <input type="checkbox" name="peach_allergy" value="1">
                    <img src="peach_allergy.jpg" alt="peach_allergy">
                </div>
                <div>
                    <input type="checkbox" name="tomato_allergy" value="1">
                    <img src="tomato_allergy.jpg" alt="tomato_allergy">
                </div>
                <div>
                    <input type="checkbox" name="chicken_allergy" value="1">
                    <img src="chicken_allergy.jpg" alt="chicken_allergy">
                </div>
                <div>
                    <input type="checkbox" name="pork_allergy" value="1">
                    <img src="pork_allergy.jpg" alt="pork_allergy">
                </div>
                <div>
                    <input type="checkbox" name="beef_allergy" value="1">
                    <img src="beef_allergy.jpg" alt="beef_allergy">
                </div>
            </div>
        </div>

        <!-- 추가 줄들을 필요한 만큼 생성 -->
    </div>
</div>


<%@include file="/footer.jsp" %>
</body>
</html>
