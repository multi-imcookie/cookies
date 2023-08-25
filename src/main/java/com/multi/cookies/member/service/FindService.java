package com.multi.cookies.member.service;

import com.multi.cookies.member.dao.FindDAO;
import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.env.Environment;
import org.springframework.stereotype.Service;

import javax.annotation.PostConstruct;
import javax.crypto.Mac;
import javax.crypto.spec.SecretKeySpec;
import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.net.HttpURLConnection;
import java.net.URL;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import java.util.Base64;
import java.util.Map;

@Service
public class FindService {
    @Autowired
    FindDAO findDAO;
    @Autowired
    private Environment environment;
    private String accessKey;
    private String secretKey;
    private String serviceId;
    private String from;
    @PostConstruct
    public void init(){
        accessKey = environment.getProperty("sms.accessKey"); //accesskey
        secretKey = environment.getProperty("sms.secretKey"); //secretKey
        serviceId = environment.getProperty("sms.serviceId"); //serviceId
        from = environment.getProperty("sms.from");  //발신번호 , 사전등록 필수
    }

    public String findId(Map<String,Object> map){
        String findId =  findDAO.findIdByNameAndPhoneNumber(map);
        if(findId==null){
            return "잘못된 이름 , 전화번호 입니다.";
        }
        String maskedId = maskId(findId);
//        System.out.println("maskedId = " + maskedId);
        return maskedId;
    }
    private String maskId(String id){
         int idLength = id.length();
        int visibleLength = idLength-idLength/3;
        StringBuilder maskedId = new StringBuilder();
        for (int i = 0; i < idLength; i++) {
            if(i < visibleLength)
                maskedId.append(id.charAt(i));
            else
                maskedId.append("*");
        }
        return maskedId.toString();
    }

    public String findPassWord(Map<String, Object> map) {
        String tempPassWord = getTempPassword();  //임시비밀번호 생성
        map.put("tempPassWord",tempPassWord);  //map에  임시비밀번호 추가
        int updatedRow = findDAO.findPassWordByNameAndIdAndPhoneNumber(map);   //임시비밀번호로 DB 업데이트
        if(!(updatedRow==1)){
            return "데이터베이스 오류입니다";  //영향받는 로우수가 1이 아닌경우 오류인데...이미 db는 업데이트 트랜잭션 알아볼것 ????
        }
        // updatedrow가 1인경우
        String phoneNumber = removeHyphens((String)map.get("phoneNumber"));  //폰넘버 ex) 010-1234-1234 -> 01012341234 변환
        String content = "임시번호는  :  "+tempPassWord +"   입니다.";  //문자로 보낼내용
        int responseCode = sendSMS(content,phoneNumber);
        if(responseCode!=202){
            return "문자를 보내지 못했습니다.";
        }
        return "성공입니다";
    }

    private int sendSMS(String content,String to) { //문자내용 , 보낼사람전화번호  ex) "안녕",010119112
        String hostNameUrl = "https://sens.apigw.ntruss.com";     		// 호스트 URL
        String requestUrl= "/sms/v2/services/";                   		// 요청 URL
        String requestUrlType = "/messages";                      		// 요청 URL
//        String accessKey = "qwedf34t624tg";                     	// 네이버 클라우드 플랫폼 회원에게 발급되는 개인 인증키			// Access Key : https://www.ncloud.com/mypage/manage/info > 인증키 관리 > Access Key ID
//        String secretKey = "asdgferer124ewf";  // 2차 인증을 위해 서비스마다 할당되는 service secret key	// Service Key : https://www.ncloud.com/mypage/manage/info > 인증키 관리 > Access Key ID
//        String serviceId = "adsfwp:sms:kr:12346231235:koiie";       // 프로젝트에 할당된 SMS 서비스 ID							// service ID : https://console.ncloud.com/sens/project > Simple & ... > Project > 서비스 ID
        String method = "POST";											// 요청 method
        String timestamp = Long.toString(System.currentTimeMillis()); 	// current timestamp (epoch)
        requestUrl += serviceId + requestUrlType;
        String apiUrl = hostNameUrl + requestUrl;//https://sens.apigw.ntruss.com/sms/v2/services/ +  service Id + requestUrlType

        // JSON 을 활용한 body data 생성
        JSONObject bodyJson = new JSONObject();
        JSONObject toJson = new JSONObject();
        JSONArray toArr = new JSONArray();

        //toJson.put("subject","");							// Optional, messages.subject	개별 메시지 제목, LMS, MMS에서만 사용 가능
        //toJson.put("content","sms test in spring 111");	// Optional, messages.content	개별 메시지 내용, SMS: 최대 80byte, LMS, MMS: 최대 2000byte
        toJson.put("to",to);						// Mandatory(필수), messages.to	수신번호, -를 제외한 숫자만 입력 가능
        toArr.put(toJson);

        bodyJson.put("type","SMS");							// Madantory, 메시지 Type (SMS | LMS | MMS), (소문자 가능)
        //bodyJson.put("contentType","");					// Optional, 메시지 내용 Type (AD | COMM) * AD: 광고용, COMM: 일반용 (default: COMM) * 광고용 메시지 발송 시 불법 스팸 방지를 위한 정보통신망법 (제 50조)가 적용됩니다.
        //bodyJson.put("countryCode","82");					// Optional, 국가 전화번호, (default: 82)
        bodyJson.put("from",from);					// Mandatory, 발신번호, 사전 등록된 발신번호만 사용 가능
        //bodyJson.put("subject","");						// Optional, 기본 메시지 제목, LMS, MMS에서만 사용 가능
        bodyJson.put("content",content);	// Mandatory(필수), 기본 메시지 내용, SMS: 최대 80byte, LMS, MMS: 최대 2000byte
        bodyJson.put("messages", toArr);					// Mandatory(필수), 아래 항목들 참조 (messages.XXX), 최대 1,000개

        //String body = bodyJson.toJSONString();
        String body = bodyJson.toString();

//        System.out.println(body);
        StringBuffer response = new StringBuffer();
        int responseCode=0;
        try {
            URL url = new URL(apiUrl);

            HttpURLConnection con = (HttpURLConnection)url.openConnection();
            con.setUseCaches(false);
            con.setDoOutput(true);
            con.setDoInput(true);
            con.setRequestProperty("content-type", "application/json");
            con.setRequestProperty("x-ncp-apigw-timestamp", timestamp);
            con.setRequestProperty("x-ncp-iam-access-key", accessKey);
            con.setRequestProperty("x-ncp-apigw-signature-v2", makeSignature(requestUrl, timestamp, method, accessKey, secretKey));
            con.setRequestMethod(method);
            con.setDoOutput(true);
            DataOutputStream wr = new DataOutputStream(con.getOutputStream());

            wr.write(body.getBytes());
            wr.flush();
            wr.close();

            responseCode = con.getResponseCode();
            BufferedReader br;
            System.out.println("responseCode" +" " + responseCode);
            if(responseCode == 202) { // 정상 호출
                br = new BufferedReader(new InputStreamReader(con.getInputStream()));
            } else { // 에러 발생
                br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
            }

            String inputLine;

            while ((inputLine = br.readLine()) != null) {
                response.append(inputLine);
            }
            br.close();

            System.out.println(response.toString());
            return responseCode;

        } catch (Exception e) {
            System.out.println(e);
        }
        return responseCode;
    }
    // https://api.ncloud-docs.com/docs/common-ncpapi
    private String makeSignature(String url, String timestamp, String method, String accessKey, String secretKey)
            throws NoSuchAlgorithmException, InvalidKeyException{
        String space = " ";                    // one space
        String newLine = "\n";                 // new line
        String message = new StringBuilder()
                .append(method)
                .append(space)
                .append(url)
                .append(newLine)
                .append(timestamp)
                .append(newLine)
                .append(accessKey)
                .toString();

        SecretKeySpec signingKey;
        String encodeBase64String;
        try {
            signingKey = new SecretKeySpec(secretKey.getBytes("UTF-8"), "HmacSHA256");
            Mac mac = Mac.getInstance("HmacSHA256");
            mac.init(signingKey);
            byte[] rawHmac = mac.doFinal(message.getBytes("UTF-8"));
            encodeBase64String = Base64.getEncoder().encodeToString(rawHmac);
        } catch (UnsupportedEncodingException e) {
            // TODO Auto-generated catch block
            encodeBase64String = e.toString();
        }
        return encodeBase64String;
    }

    public String getTempPassword(){
        char[] charSet = new char[] { '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'A', 'B', 'C', 'D', 'E', 'F',
                'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z' };

        StringBuilder str = new StringBuilder();

        // 문자 배열 길이의 값을 랜덤으로 10개를 뽑아 구문을 작성함
        int idx = 0;
        for (int i = 0; i < 10; i++) {
            idx = (int) (charSet.length * Math.random());
            str.append(charSet[idx]);
        }
        return str.toString();
    }
    public String removeHyphens(String phoneNumber) {
        // 문자열에서 하이픈 제거
        String cleanedNumber = phoneNumber.replaceAll("-", "");
        return cleanedNumber;
    }
}
