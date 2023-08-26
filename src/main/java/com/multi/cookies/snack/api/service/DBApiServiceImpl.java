package com.multi.cookies.snack.api.service;

import com.multi.cookies.snack.api.dto.DBApiDTO;
import com.multi.cookies.snack.api.dao.DBApiDAO;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

@Service
public class DBApiServiceImpl implements DBApiService {

    @Autowired
    DBApiDAO dbApiDAO;

    @Value("${foodinfo.key}")
    private String apiKey;

    @Override
    public String callHaccpAPI(int page) throws IOException {   // HACCP 식품정보 API
        StringBuilder urlBuilder = new StringBuilder("https://apis.data.go.kr/B553748/CertImgListServiceV2/getCertImgListServiceV2"); /*URL*/
        urlBuilder.append("?" + URLEncoder.encode("ServiceKey", "UTF-8") + "=" + apiKey); /*Service Key*/
        urlBuilder.append("&" + URLEncoder.encode("returnType", "UTF-8") + "=" + URLEncoder.encode("json", "UTF-8")); /*XML/JSON 여부*/
        urlBuilder.append("&" + URLEncoder.encode("prdkind", "UTF-8") + "=" + URLEncoder.encode("과자", "UTF-8")); /*유형*/
        // urlBuilder.append("&" + URLEncoder.encode("prdlstNm", "UTF-8") + "=" + URLEncoder.encode("새우깡", "UTF-8")); /*과자이름*/
        // urlBuilder.append("&" + URLEncoder.encode("manufacture", "UTF-8") + "=" + URLEncoder.encode("해태", "UTF-8")); /*제조원*/
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
    @Scheduled(cron = "0 43 14 * * * *")    // cron: 초 분 시 일 월 요일 연도
    public int updateDB() throws ParseException, IOException {
        int result = 0;
        int maxPage = calculateNumOfPage(); // 최대 페이지 수
        for (int i = 1; i <= maxPage; i++) {
            for (DBApiDTO dbApiDTO : parseJsonData(i)) {
                if (!dbApiDTO.equals(dbApiDAO.pullDB(dbApiDTO.getSnack_reportNo()))) {
                    if (dbApiDAO.pullDB(dbApiDTO.getSnack_reportNo()) != null) {    // snack_reportNo가 이미 존재하는 경우
                        result += dbApiDAO.updateDB(dbApiDTO);
                    } else {    // snack_reportNo가 존재하지 않는 경우(신규값)
                        result += dbApiDAO.insertDB(dbApiDTO);
                    }
                }
            }
            System.out.println(i + "페이지 업데이트 성공");
        }
        System.out.println("총 " + result + "개 항목 업데이트 완료");
        return result;
    }

    @Override
    public int insertDB() throws IOException, ParseException {
        int result = 0;
        int maxPage = calculateNumOfPage(); // 최대 페이지 수
        for (int i = 1; i <= maxPage; i++) {
            for (DBApiDTO dbApiDTO : parseJsonData(i)) {
                result += dbApiDAO.insertDB(dbApiDTO);
            }
            System.out.println(i + "페이지 성공");
        }
        System.out.println("DB 목록 생성 성공!");
        return result / 2;  // snack 테이블, snack_nutritional 총 2개 테이블
    }

    @Override
    public int initializeDB() {
        int deleteResult = dbApiDAO.deleteAllDB();
        dbApiDAO.resetDBAI();
        System.out.println("DB " + deleteResult + " 건 초기화 성공!");
        return deleteResult;
    }


    @Override
    public List<DBApiDTO> parseJsonData(int page) throws ParseException, IOException {
        String foodInfo = callHaccpAPI(page);
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
            dbApiDTO.setSnack_reportNo((String) innerItem.get("prdlstReportNo"));   // 품목보고번호
            dbApiDTO.setAllergy((String) innerItem.get("allergy"));   // 알레르기 유발 성분

            if (dbApiDTO.getNutri_string() != null && dbApiDTO.getNutri_string() != "알수없음") {
                dbApiDTO.setProtein(extractNutri(dbApiDTO.getNutri_string()).getProtein()); // 단백질
                dbApiDTO.setKcal(extractNutri(dbApiDTO.getNutri_string()).getKcal());   // 열량
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

    private DBApiDTO extractNutri(String nutrient) {
        DBApiDTO dbApiDTO = new DBApiDTO();
        // System.out.println("nutrient>> " + nutrient);
        Pattern pattern = Pattern.compile("(단백질|열량|지방|탄수화물|당류|칼슘|나트륨|콜레스테롤|포화지방|트랜스지방)\\s*(?:\\((kcal|mg|g)\\))?\\s*([\\d]+(?:\\.[\\d]+)?)\\s*(?:kcal|mg|g)?");
        Matcher matcher = pattern.matcher(nutrient);

        while (matcher.find()) {
            String nutri = matcher.group(1);
            Double value = Double.parseDouble(matcher.group(3));

            // System.out.println("nutri>> " + nutri);
            // System.out.println("value>> " + value);
            if (nutri.contains("단백질")) {
                dbApiDTO.setProtein(value);
            }
            if (nutri.contains("열량")) {
                dbApiDTO.setKcal(value);
            }
            if (nutri.contains("지방")) {
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

    /**
     * 여기부터 private
     */
    private int calculateNumOfPage() throws IOException, ParseException {    // 총 페이지 개수 계산
        String foodInfo = callHaccpAPI(1);
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

    private JSONObject parseJsonObject(String json) throws ParseException {
        JSONParser jsonParser = new JSONParser();

        return (JSONObject) jsonParser.parse(json);
    }

    private JSONArray getJsonItems(JSONObject jsonObject) { // body 가져오기
        JSONObject body = (JSONObject) jsonObject.get("body");

        return (JSONArray) body.get("items");
    }
}
