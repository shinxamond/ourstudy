package kr.spring.member.kakao;

import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class KakaoController {
	
	 @Autowired
	 private KakaoService kakao;
	 
	//자바빈(VO) 초기화
	@ModelAttribute
	public KakaoVO initCommand() {
		return new KakaoVO();
	}
	
	@GetMapping("/member/kakaoLogin")
	@ResponseBody
	public String kakaoLogin(@RequestParam("code") String code) {
		String access_Token = kakao.getAccessToken(code);
        System.out.println("controller access_token : " + access_Token);
        
     	HashMap<String, Object> userInfo = kakao.getUserInfo(access_Token);
     	
     	
     	//mem_id
     	String kakao_id = (String)userInfo.get("kakao_email");
     	int idx = kakao_id.indexOf("@"); 
     	kakao_id = kakao_id.substring(0,idx);
     	System.out.println(kakao_id);
     	
     	//mem_name
     	String kakao_name = (String)userInfo.get("kakao_name");
     	
     	//mem_email
     	String kakao_email = (String)userInfo.get("kakao_email");
     	
     	//mem_photo
     	String kakao_image = (String)userInfo.get("kakao_image");

     	
        return "mem_id : " + kakao_id + "<br>mem_name : " + kakao_name +
        		"<br>mem_email : " + kakao_email + "<br>mem_photo : " + kakao_image;
    }

	
	
	//카카오톡 로그아웃
	@RequestMapping(value="/logout")
	public String logout(HttpSession session) {
	    kakao.kakaoLogout((String)session.getAttribute("access_Token"));
	    session.removeAttribute("access_Token");
	    session.removeAttribute("userId");
	    return "main";
	}

    	
}
