<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<div class="modal-overlay">
    <div class="allergy-modal-box modal-box p-bold">
        <div class="mdl-text">
            <button type="button" id="modal-close" class="modal-close btn-close" aria-label="Close"></button>
            <div class="s-h-imcre24">알레르기 체크</div>
            <div class="modal-detail-content p-regular">
                <table class="custom-table">
                    <tr class="allergy-check-box">
                        <td class="allergy-check-btn">
                            <input type="checkbox" name="selectedAllergies" value="egg_allergy" id="egg_allergy">
                            <label for="egg_allergy"><img src="/resources/img/curation/egg.png" alt="egg"> 난류 알레르기
                            </label>
                        </td>
                        <td class="allergy-check-btn">
                            <input type="checkbox" name="selectedAllergies" value="milk_allergy" id="milk_allergy">
                            <label for="milk_allergy"><img src="/resources/img/curation/milk.png" alt="milk"> 우유 알레르기
                            </label>
                        </td>
                        <td class="allergy-check-btn">
                            <input type="checkbox" name="selectedAllergies" value="wheat_allergy" id="wheat_allergy">
                            <label for="wheat_allergy"><img src="/resources/img/curation/wheat.png" alt="wheat"> 밀 알레르기</label>
                        </td>
                    </tr>
                    <tr class="allergy-check-box">
                        <td class="allergy-check-btn">
                            <input type="checkbox" name="selectedAllergies" value="buckwheat_allergy"
                                   id="buckwheat_allergy">
                            <label for="buckwheat_allergy"><img src="/resources/img/curation/buckwheat.png"
                                                                alt="buckwheat"> 메밀
                                알레르기</label>
                        </td>
                        <td class="allergy-check-btn">
                            <input type="checkbox" name="selectedAllergies" value="peanut_allergy" id="peanut_allergy">
                            <label for="peanut_allergy"><img src="/resources/img/curation/peanut.png" alt="peanut"> 땅콩
                                알레르기</label>
                        </td>
                        <td class="allergy-check-btn">
                            <input type="checkbox" name="selectedAllergies" value="soy_allergy" id="soy_allergy">
                            <label for="soy_allergy"><img src="/resources/img/curation/soy.png" alt="soy"> 대두
                                알레르기</label>
                        </td>
                    </tr>
                    <tr class="allergy-check-box">
                        <td class="allergy-check-btn">
                            <input type="checkbox" name="selectedAllergies" value="pine_nut_allergy"
                                   id="pine_nut_allergy">
                            <label for="pine_nut_allergy"><img src="/resources/img/curation/pine_nut.png"
                                                               alt="pine_nut"> 잣 알레르기</label>
                        </td>
                        <td class="allergy-check-btn">
                            <input type="checkbox" name="selectedAllergies" value="almond_allergy" id="almond_allergy">
                            <label for="almond_allergy"><img src="/resources/img/curation/almond.png" alt="almond"> 아몬드
                                알레르기</label>
                        </td>
                        <td class="allergy-check-btn">
                            <input type="checkbox" name="selectedAllergies" value="walnut_allergy" id="walnut_allergy">
                            <label for="walnut_allergy"><img src="/resources/img/curation/walnut.png" alt="walnut"> 호두
                                알레르기</label>
                        </td>
                    </tr>
                    <tr class="allergy-check-box">
                        <td class="allergy-check-btn">
                            <input type="checkbox" name="selectedAllergies" value="crab_allergy" id="crab_allergy">
                            <label for="crab_allergy"><img src="/resources/img/curation/crab.png" alt="crab"> 게
                                알레르기</label>
                        </td>
                        <td class="allergy-check-btn">
                            <input type="checkbox" name="selectedAllergies" value="shrimp_allergy" id="shrimp_allergy">
                            <label for="shrimp_allergy"><img src="/resources/img/curation/shrimp.png" alt="shrimp"> 새우
                                알레르기</label>
                        </td>
                        <td class="allergy-check-btn">
                            <input type="checkbox" name="selectedAllergies" value="squid_allergy" id="squid_allergy">
                            <label for="squid_allergy"><img src="/resources/img/curation/squid.png" alt="squid"> 오징어
                                알레르기</label>
                        </td>
                    </tr>
                    <tr class="allergy-check-box">
                        <td class="allergy-check-btn">
                            <input type="checkbox" name="selectedAllergies" value="mackerel_allergy"
                                   id="mackerel_allergy">
                            <label for="mackerel_allergy"><img src="/resources/img/curation/mackerel.png"
                                                               alt="mackerel"> 고등어
                                알레르기</label>
                        </td>
                        <td class="allergy-check-btn">
                            <input type="checkbox" name="selectedAllergies" value="shellfish_allergy"
                                   id="shellfish_allergy">
                            <label for="shellfish_allergy"><img src="/resources/img/curation/shellfish.png"
                                                                alt="shellfish"> 조개류
                                알레르기</label>
                        </td>
                        <td class="allergy-check-btn">
                            <input type="checkbox" name="selectedAllergies" value="peach_allergy" id="peach_allergy">
                            <label for="peach_allergy"><img src="/resources/img/curation/peach.png" alt="peach"> 복숭아
                                알레르기</label>
                        </td>
                    </tr>
                    <tr class="allergy-check-box">
                        <td class="allergy-check-btn">
                            <input type="checkbox" name="selectedAllergies" value="tomato_allergy" id="tomato_allergy">
                            <label for="tomato_allergy"><img src="/resources/img/curation/tomato.png" alt="tomato"> 토마토
                                알레르기</label>
                        </td>
                        <td class="allergy-check-btn">
                            <input type="checkbox" name="selectedAllergies" value="chicken_allergy"
                                   id="chicken_allergy">
                            <label for="chicken_allergy"><img src="/resources/img/curation/chicken.png" alt="chicken">
                                닭고기 알레르기</label>
                        </td>
                        <td class="allergy-check-btn">
                            <input type="checkbox" name="selectedAllergies" value="pork_allergy" id="pork_allergy">
                            <label for="pork_allergy"><img src="/resources/img/curation/pork.png" alt="pork"> 돼지고기 알레르기</label>
                        </td>
                    </tr>
                    <tr class="allergy-check-box">
                        <td class="allergy-check-btn">
                            <input type="checkbox" name="selectedAllergies" value="beef_allergy" id="beef_allergy">
                            <label for="beef_allergy"><img src="/resources/img/curation/beef.png" alt="beef"> 쇠고기
                                알레르기</label>
                        </td>
                    </tr>
                </table>
            </div>
        </div>
        <button class="fill-btn p-medium" type="button" id="checkedAllergiesData">체크 완료</button>
    </div>
</div>
