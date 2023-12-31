package com.multi.cookies.snack.api.service;

import com.multi.cookies.snack.api.dto.DBApiDTO;
import com.multi.cookies.snack.api.dao.DBApiDAO;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

@Service
public class DBApiServiceImpl implements DBApiService {

    @Autowired
    DBApiDAO dbApiDAO;

    @Value("${foodinfo.key}")
    private String apiKey;

    @Override
    public String callHaccpAPI(int page, String prdkind) throws IOException {   // HACCP 식품정보 API
        StringBuilder urlBuilder = new StringBuilder("https://apis.data.go.kr/B553748/CertImgListServiceV2/getCertImgListServiceV2"); /*URL*/
        urlBuilder.append("?" + URLEncoder.encode("ServiceKey", "UTF-8") + "=" + apiKey); /*Service Key*/
        urlBuilder.append("&" + URLEncoder.encode("returnType", "UTF-8") + "=" + URLEncoder.encode("json", "UTF-8")); /*XML/JSON 여부*/
        urlBuilder.append("&" + URLEncoder.encode("prdkind", "UTF-8") + "=" + URLEncoder.encode(prdkind, "UTF-8")); /*유형*/
        // urlBuilder.append("&" + URLEncoder.encode("prdlstNm", "UTF-8") + "=" + URLEncoder.encode("새우깡", "UTF-8")); /*과자이름*/
        // urlBuilder.append("&" + URLEncoder.encode("manufacture", "UTF-8") + "=" + URLEncoder.encode("농심", "UTF-8")); /*제조원*/
        urlBuilder.append("&" + URLEncoder.encode("pageNo", "UTF-8") + "=" + URLEncoder.encode("" + page, "UTF-8")); /*페이지*/
        urlBuilder.append("&" + URLEncoder.encode("numOfRows", "UTF-8") + "=" + URLEncoder.encode("100", "UTF-8")); /*페이지당 출력 개수*/

        URL url = new URL(urlBuilder.toString());
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("GET");
        conn.setRequestProperty("Content-type", "application/json");
        System.out.println("Response code: " + conn.getResponseCode());
        BufferedReader rd;
        if (conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
            rd = new BufferedReader(new InputStreamReader(conn.getInputStream()));
        } else {
            rd = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
        }
        StringBuilder sb = new StringBuilder();

        String line;
        while ((line = rd.readLine()) != null) {
            sb.append(line);
        }
        rd.close();
        conn.disconnect();

//        System.out.println(sb.toString());
        return sb.toString();
    }

    @Override
    public int updateDB() throws ParseException, IOException {
        int result = 0;
        String[] prdkind = {"과자", "초콜릿"};
        for (int i = 0; i < prdkind.length; i++) {
            int maxPage = calculateNumOfPage(prdkind[i]); // 최대 페이지 수
            for (int page = 1; page <= maxPage; page++) {
                for (DBApiDTO dbApiDTO : parseJsonData(page, prdkind[i])) {
                    dbApiDTO = selectCompany(dbApiDTO); // 제조사 걸러내기
                    if (dbApiDTO != null
                            && dbApiDTO.getNutri_string() != null
                            && !dbApiDTO.getNutri_string().equals("알수없음")
                            && dbApiDTO.getNetwt() != 0) { // 영양성분 null, 알수없음 걸러내기
                        if (!dbApiDTO.equals(dbApiDAO.pullDB(dbApiDTO.getSnack_reportNo()))) {  // dbApiDTO가 기존의 DB 항목 정보와 일치하지 않을 때
//                        System.out.println(dbApiDTO.getSnack_name() + "\n기존>> " + dbApiDAO.pullDB(dbApiDTO.getSnack_reportNo()).getNetwt());
//                        System.out.println("변경>> " + dbApiDTO.getNetwt());
                            if (dbApiDAO.pullDB(dbApiDTO.getSnack_reportNo()) != null) {    // 동일한 snack_reportNo가 이미 존재하는 경우
                                result += dbApiDAO.updateDB(dbApiDTO);
                            } else {    // 동일한 snack_reportNo가 존재하지 않는 경우(신규값)
                                result += dbApiDAO.insertDB(dbApiDTO);
                            }
                        }
                    }
                }
                System.out.println(page + "페이지 업데이트 성공");
            }
        }
        System.out.println("총 " + result / 2 + "개 항목 업데이트 완료");
        return result / 2;
    }

    @Override
    public int insertDB(DBApiDTO dbApiDTO) {
        dbApiDTO.setSnack_reportNo("0");    // 임의추가한 항목은 품목보고번호 0으로 세팅
        return dbApiDAO.insertDB(dbApiDTO);
    }

    @Override
    public int deleteDB(int snack_id) {
        return dbApiDAO.deleteDB(snack_id);
    }

    @Override
    public List<String> searchDB(String snack_name) {
        List<DBApiDTO> list = dbApiDAO.searchDB(snack_name);

        List<String> result = new ArrayList<>();
        for (DBApiDTO dbApiDTO : list) {
            result.add(dbApiDTO.getSnack_id() + ": " +dbApiDTO.getSnack_name());
        }
        return result;
    }

//    @Override
//    public int initializeDB() {
//        int deleteResult = dbApiDAO.deleteAllDB();
//        dbApiDAO.resetDBAI();
//        System.out.println("DB " + deleteResult + " 건 초기화 성공!");
//        return deleteResult;
//    }


    @Override
    public List<DBApiDTO> parseJsonData(int page, String prdkind) throws ParseException, IOException {
        String foodInfo = callHaccpAPI(page, prdkind);
        foodInfo = replaceJson(foodInfo);

        JSONObject jsonObject = parseJsonObject(foodInfo);    // 문자열 JSONObject로 변환
        JSONArray items = getJsonItems(jsonObject);    // items 가져오기

        //System.out.println(items.toJSONString());

        List<DBApiDTO> dbApiDTOList = new ArrayList<>();

        for (Object item : items) {
            JSONObject itemObject = (JSONObject) item;
            JSONObject innerItem = (JSONObject) itemObject.get("item");

            DBApiDTO dbApiDTO = new DBApiDTO();
            dbApiDTO.setSnack_name((String) innerItem.get("prdlstNm"));   // 과자이름
            dbApiDTO.setNutri_string((String) innerItem.get("nutrient"));   // 영양성분
            dbApiDTO.setSnack_ingredients((String) innerItem.get("rawmtrl"));   // 원재료명
            dbApiDTO.setSnack_img((String) innerItem.get("imgurl1"));   // 이미지(url)
            dbApiDTO.setCompany((String) innerItem.get("manufacture"));   // 제조사
            if (dbApiDTO.getCompany() == null || dbApiDTO.getCompany().equals("알수없음")) {    // manufacture에서 정보가 없는 경우
                dbApiDTO.setCompany((String) innerItem.get("seller"));
            }
            dbApiDTO.setSnack_reportNo((String) innerItem.get("prdlstReportNo"));   // 품목보고번호
            dbApiDTO.setAllergy((String) innerItem.get("allergy"));   // 알레르기 유발 성분
            if (innerItem.get("capacity") != null && !innerItem.get("capacity").equals("알수없음")) {    // 총 내용량
                dbApiDTO.setNetwt(extractNetwt((String) innerItem.get("capacity")));
            }

            if (dbApiDTO.getNutri_string() != null && !dbApiDTO.getNutri_string().equals("알수없음")) {
                dbApiDTO.setProtein(extractNutri(dbApiDTO.getNutri_string()).getProtein()); // 단백질
                dbApiDTO.setKcal(extractNutri(dbApiDTO.getNutri_string()).getKcal());   // 열량
                if (dbApiDTO.getKcal() == 0) {
                    dbApiDTO.setKcal(extractKcal(dbApiDTO.getNutri_string()));
                    if (dbApiDTO.getKcal() == 0) {
                        dbApiDTO.setKcal(extractKcal2(dbApiDTO.getNutri_string()));
                    }
                }
                dbApiDTO.setFat(extractNutri(dbApiDTO.getNutri_string()).getFat()); // 지방
                dbApiDTO.setCarb(extractNutri(dbApiDTO.getNutri_string()).getCarb());   // 탄수화물
                dbApiDTO.setSugars(extractNutri(dbApiDTO.getNutri_string()).getSugars());   // 당류
                dbApiDTO.setCalcium(extractNutri(dbApiDTO.getNutri_string()).getCalcium()); // 칼슘
                dbApiDTO.setSodium(extractNutri(dbApiDTO.getNutri_string()).getSodium());   // 나트륨
                dbApiDTO.setCholesterol(extractNutri(dbApiDTO.getNutri_string()).getCholesterol()); // 콜레스테롤
                dbApiDTO.setSaturated_fat(extractNutri(dbApiDTO.getNutri_string()).getSaturated_fat()); // 포화지방
                dbApiDTO.setTrans_fat(extractNutri(dbApiDTO.getNutri_string()).getTrans_fat()); // 트랜스지방
            }
            // System.out.println(dbApiDTO);
            dbApiDTOList.add(dbApiDTO);
        }
        // System.out.println(dbApiDTOList);
        return dbApiDTOList;
    }

    /**
     * 여기부터 private
     */
    private double extractNetwt(String netwt) {
        double extracted = 0;
        netwt = replaceNutrient(netwt);

        Pattern pattern = Pattern.compile("(\\d+)g");
        Matcher matcher = pattern.matcher(netwt);

        if (matcher.find()) {
            extracted = Double.parseDouble(matcher.group(1));
        }
        // System.out.println(extracted);
        return extracted;
    }

    private DBApiDTO selectCompany(DBApiDTO dbApiDTO) { // 제조사 걸러내기
        String company = dbApiDTO.getCompany();

        Map<String, String> companyMap = new HashMap<>();
        companyMap.put("농심", "농심");
        companyMap.put("해태제과", "해태제과");
        companyMap.put("해태가루비", "해태가루비");
        companyMap.put("롯데", "롯데");
        companyMap.put("오리온", "오리온");
        companyMap.put("크라운", "크라운제과");
        companyMap.put("청우", "청우식품");
        companyMap.put("빙그레", "빙그레");
        companyMap.put("삼양", "삼양식품");
        companyMap.put("미가방", "미가방");
        companyMap.put("오뚜기", "오뚜기");
        companyMap.put("코스모스", "코스모스제과");
        companyMap.put("삼진", "삼진식품");
        companyMap.put("상일", "상일식품");
        companyMap.put("동아", "동아제과");
        companyMap.put("제이앤비", "j&b");
        companyMap.put("훼미리", "훼미리식품");

        String convertedCompany = null;

        for (Map.Entry<String, String> entry : companyMap.entrySet()) {
            if (company.contains(entry.getKey())) {
                convertedCompany = entry.getValue();
                break;
            }
        }

        if (convertedCompany != null) {
            dbApiDTO.setCompany(convertedCompany);
        } else {
            dbApiDTO = null;
        }

        return dbApiDTO;
    }
    private double extractKcal(String nutrient) {   // 열량 분리
        nutrient = replaceNutrient(nutrient);

        Pattern pattern = Pattern.compile("\\b(kcal)\\s*(\\d+[\\d,]*)\\b|\\b(\\d+[\\d,]*)\\s*(kcal)\\b");
        Matcher matcher = pattern.matcher(nutrient);
        double value = 0;
        while (matcher.find()) {
            String valueString = matcher.group(2) != null ? matcher.group(2) : matcher.group(3);
            valueString = valueString.replaceAll(",", "");
            value = Double.parseDouble(valueString);
        }
        return value;
    }

    private double extractKcal2(String nutrient) {   // 열량 분리
        nutrient = replaceNutrient(nutrient);

        Pattern pattern = Pattern.compile("([\\d.]+)\\s*?\\(?kcal\\)?");
        Matcher matcher = pattern.matcher(nutrient);
        double value = 0;
        while (matcher.find()) {
            String valueString = matcher.group(1);
            value = Double.parseDouble(valueString);
        }
        return value;
    }

    private DBApiDTO extractNutri(String nutrient) {    // 영양성분 분리
        DBApiDTO dbApiDTO = new DBApiDTO();
        nutrient = replaceNutrient(nutrient);
        // System.out.println("nutrient>> " + nutrient);
        Pattern pattern = Pattern.compile("(단백질|열량|지방|탄수화물|당류|칼슘|나트륨|콜레스테롤|포화지방|트랜스지방)\\s*(\\(?kcal\\)?|\\(?mg\\)?|\\(?g\\)?)?\\s*([\\d]+(?:\\.[\\d]+)?)\\s*(kcal|mg|g)?");
        Matcher matcher = pattern.matcher(nutrient);

        while (matcher.find()) {
            String nutri = matcher.group(1);
            String facts1 = matcher.group(2);
            Double value = Double.parseDouble(matcher.group(3));
            String facts2 = matcher.group(4);

//            if (facts1 != null && facts1.equals("kcal")) {
//                System.out.println(facts1);
//            }
//            if (facts2 != null && facts2.equals("kcal")) {
//                System.out.println(facts2);
//            }
            // System.out.println("nutri>> " + nutri);
            // System.out.println("value>> " + value);
            if (nutri.contains("단백질")) {
                dbApiDTO.setProtein(value);
            }
            if (nutri.contains("열량") || (facts1 != null && facts1.contains("kcal")) || (facts2 != null && facts2.contains("kcal"))) {
                dbApiDTO.setKcal(value);
            }
            if (nutri.equals("지방")) {   // 포화지방, 트랜스지방 중복 피하기 위해 equals
                dbApiDTO.setFat(value);
            }
            if (nutri.contains("탄수화물")) {
                dbApiDTO.setCarb(value);
            }
            if (nutri.contains("당류")) {
                dbApiDTO.setSugars(value);
            }
            if (nutri.contains("칼슘")) {
                dbApiDTO.setCalcium(value);
            }
            if (nutri.contains("나트륨")) {
                dbApiDTO.setSodium(value);
            }
            if (nutri.contains("콜레스테롤")) {
                dbApiDTO.setCholesterol(value);
            }
            if (nutri.contains("포화지방")) {
                dbApiDTO.setSaturated_fat(value);
            }
            if (nutri.contains("트랜스지방")) {
                dbApiDTO.setTrans_fat(value);
            }
        }
        return dbApiDTO;
    }

    private int calculateNumOfPage(String prdkind) throws IOException, ParseException {    // 총 페이지 개수 계산
        String foodInfo = callHaccpAPI(1, prdkind);
        foodInfo = replaceJson(foodInfo);

        JSONParser jsonParser = new JSONParser();
        JSONObject jsonObject = (JSONObject) jsonParser.parse(foodInfo);    // 문자열 JSONObject로 변환

        JSONObject body = (JSONObject) jsonObject.get("body");  // body 가져오기

        double totalCount = Double.parseDouble((String) body.get("totalCount"));    // 목록 총 개수 (+double로 형변환)
        double numOfRows = Double.parseDouble((String) body.get("numOfRows"));   // 페이지당 행 개수 (+double로 형변환)
        int totalPage = (int) Math.ceil(totalCount / numOfRows);

        return totalPage;
    }

    private String replaceJson(String json) {   // 파싱 중 오류 나는 문자열 처리
        json = json.replaceAll("\\n|\\r|\\r\\n|\\t|\\f", " ");

        return json;
    }

    private String replaceNutrient(String nutrient) {
        nutrient = nutrient.replaceAll("kcal기준", "기준");
        nutrient = nutrient.replaceAll("kcal 기준", "기준");
        nutrient = nutrient.replaceAll("kal", "kcal");
        nutrient = nutrient.replaceAll(",", "");
        return nutrient;
    }

    private JSONObject parseJsonObject(String json) throws ParseException {
        JSONParser jsonParser = new JSONParser();

        return (JSONObject) jsonParser.parse(json);
    }

    private JSONArray getJsonItems(JSONObject jsonObject) { // body 가져오기
        JSONObject body = (JSONObject) jsonObject.get("body");

        return (JSONArray) body.get("items");
    }
}
