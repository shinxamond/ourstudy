package kr.spring.member.kakao;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.HashMap;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;

@Service
public class KakaoService {
	
	//토큰 받아서 사용자 정보 입력하기
	public String getAccessToken (String authorize_code) {
        String access_Token = "";
        String refresh_Token = "";
        String reqURL = "https://kauth.kakao.com/oauth/token";
        
        try {
            URL url = new URL(reqURL);
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            
            //POST 요청을 위해 기본값이 false인 setDoOutput을 true로
            conn.setRequestMethod("POST");
            conn.setDoOutput(true);
            
            //POST 요청에 필요로 요구하는 파라미터 스트림을 통해 전송
            BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(conn.getOutputStream()));
            StringBuilder sb = new StringBuilder();
            sb.append("grant_type=authorization_code");
            sb.append("&client_id=0ed971182cc827fbd73de790073ac06a");
            sb.append("&redirect_uri=http://localhost:8001/member/kakaoLogin");
            sb.append("&code=" + authorize_code);
            bw.write(sb.toString());
            bw.flush();
            
            //결과 코드가 200이 나와야 성공
            int responseCode = conn.getResponseCode();
            System.out.println("responseCode : " + responseCode);
 
            //요청을 통해 얻은 JSON타입의 Response 메세지 읽어오기
            BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
            String line = "";
            String result = "";
            
            while ((line = br.readLine()) != null) {
                result += line;
            }
            System.out.println("response body : " + result);
            
            //jackson objectmapper 객체 생성
			ObjectMapper objectMapper = new ObjectMapper();
			// JSON String -> Map
			Map<String, Object> jsonMap = objectMapper.readValue(result, new TypeReference<Map<String, Object>>() {
			});
  
			access_Token = jsonMap.get("access_token").toString();
			refresh_Token = jsonMap.get("refresh_token").toString();
            
            System.out.println("access_token : " + access_Token);
            System.out.println("refresh_token : " + refresh_Token);
            
            br.close();
            bw.close();
        } catch (IOException e) {
            e.printStackTrace();
        } 
        
        return access_Token;
    }
	
	
	
	//카카오톡으로 로그인 한 사용자 정보 controller에 보내는 메서드
	public HashMap<String, Object> getUserInfo (String access_Token) {
	    
	    //요청하는 클라이언트마다 가진 정보가 다를 수 있어서 HashMap타입으로 선언
	    HashMap<String, Object> userInfo = new HashMap<>();
	    String reqURL = "https://kapi.kakao.com/v2/user/me";
	    try {
	        URL url = new URL(reqURL);
	        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
	        conn.setRequestMethod("POST");
	        
	        //요청에 필요한 Header에 포함될 내용
	        conn.setRequestProperty("Authorization", "Bearer " + access_Token);
	        
	        int responseCode = conn.getResponseCode();
	        System.out.println("responseCode : " + responseCode);
	        
	        BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
	        
	        String line = "";
	        String result = "";
	        
	        while ((line = br.readLine()) != null) {
	            result += line;
	        }
	        System.out.println("response body : " + result);
	        
	        // jackson objectmapper 객체 생성
			ObjectMapper objectMapper = new ObjectMapper();
			// JSON String -> Map
			Map<String, Object> jsonMap = objectMapper.readValue(result, new TypeReference<Map<String, Object>>() {
			});

			System.out.println(jsonMap.get("properties"));

			Map<String, Object> properties = (Map<String, Object>) jsonMap.get("properties");
			Map<String, Object> kakao_account = (Map<String, Object>) jsonMap.get("kakao_account");
			
			System.out.println(properties.get("nickname"));
			System.out.println(kakao_account.get("email"));
			System.out.println(properties.get("profile_image"));

			String kakao_name = properties.get("nickname").toString();
			String kakao_email = kakao_account.get("email").toString();
			String kakao_image = properties.get("profile_image").toString();
			
			userInfo.put("kakao_name", kakao_name);
			userInfo.put("kakao_email", kakao_email);
			userInfo.put("kakao_image", kakao_image);
	        
	    } catch (IOException e) {
	        e.printStackTrace();
	    }
	    
	    return userInfo;
	}
	
	
	//카카오톡 로그아웃
	public void kakaoLogout(String access_Token) {
	    String reqURL = "https://kapi.kakao.com/v1/user/logout";
	    try {
	        URL url = new URL(reqURL);
	        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
	        conn.setRequestMethod("POST");
	        conn.setRequestProperty("Authorization", "Bearer " + access_Token);
	        
	        int responseCode = conn.getResponseCode();
	        System.out.println("responseCode : " + responseCode);
	        
	        BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
	        
	        String result = "";
	        String line = "";
	        
	        while ((line = br.readLine()) != null) {
	            result += line;
	        }
	        System.out.println(result);
	    } catch (IOException e) {
	        e.printStackTrace();
	    }
	}


}
