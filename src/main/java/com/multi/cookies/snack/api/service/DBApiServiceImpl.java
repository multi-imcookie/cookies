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

@Service
public class DBApiServiceImpl implements DBApiService {

    @Autowired
    DBApiDAO dbApiDAO;

    @Value("${foodinfo.key}")
    private String apiKey;

    @Override
    public String callHaccpAPI(int page) throws IOException {
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

    public void parseJsonData() throws ParseException {
        try {
            int deleteResult = dbApiDAO.deleteDB();
            dbApiDAO.resetDBAI();

            if (deleteResult > 0) {
                System.out.println("DB " + deleteResult + " 건 초기화 성공!");
            }

            String foodInfo = callHaccpAPI(1);
            foodInfo = foodInfo.replace("\n", " ");
            foodInfo = foodInfo.replace("<", "");
            foodInfo = foodInfo.replace(">", "");

            JSONParser jsonParser = new JSONParser();
            JSONObject jsonObject = (JSONObject) jsonParser.parse(foodInfo);    // 문자열 JSONObject로 변환

            JSONObject body = (JSONObject) jsonObject.get("body");  // body 가져오기
            double totalCount = Double.parseDouble((String) body.get("totalCount"));    // 목록 총 개수 (+double로 형변환)
            double numOfRows = Double.parseDouble((String) body.get("numOfRows"));   // 페이지당 행 개수 (+double로 형변환)
            // System.out.println(totalCount);
/**
 *  페이지 수만큼 반복
 */
            for (int i = 1; i <= Math.ceil(totalCount / numOfRows); i++) {
                foodInfo = callHaccpAPI(i);
                foodInfo = foodInfo.replace("\n", " ");
                foodInfo = foodInfo.replace("<", "");
                foodInfo = foodInfo.replace(">", "");

                jsonObject = (JSONObject) jsonParser.parse(foodInfo);    // 문자열 JSONObject로 변환
                body = (JSONObject) jsonObject.get("body");  // body 가져오기
                JSONArray items = (JSONArray) body.get("items");    // items 가져오기

                for (Object item : items) {
                    DBApiDTO dbApiDTO = new DBApiDTO();
                    JSONObject itemObject = (JSONObject) item;
                    JSONObject innerItem = (JSONObject) itemObject.get("item");

                    dbApiDTO.setSnack_name((String) innerItem.get("prdlstNm"));   // 과자이름
                    dbApiDTO.setNutri_string((String) innerItem.get("nutrient"));   // 영양성분
                    dbApiDTO.setSnack_ingredients((String) innerItem.get("rawmtrl"));   // 원재료명
                    dbApiDTO.setSnack_img((String) innerItem.get("imgurl1"));   // 이미지(url)
                    dbApiDTO.setCompany((String) innerItem.get("manufacture"));   // 제조사
                    dbApiDTO.setSnack_reportNo((String) innerItem.get("prdlstReportNo"));   // 품목보고번호
                    dbApiDTO.setAllergy((String) innerItem.get("allergy"));   // 알레르기 유발 성분

                    dbApiDAO.insertDB(dbApiDTO);

                    // System.out.println(prdlstNm);
                }
                System.out.println(i + "페이지 성공");
            }
            System.out.println("DB 목록 갱신 성공!");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
