package kr.spring.email.controller;

import java.util.Random;

import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;

//import kr.spring.email.service.MailSendService;

@Controller
public class EmailController {
	
	@Autowired
	//private MailSendService mailService;
	private EmailSender emailSender;
	@Autowired
	private EmailVO emailVO;
	
	// 난수 발생
	private int authNumber;
	public void makeRandomNumber() {
		// 난수의 범위 111111 ~ 999999 (6자리 난수)
		Random r = new Random();
		int checkNum = r.nextInt(888888) + 111111;
		System.out.println("인증번호 : " + checkNum);
		authNumber = checkNum;
	}
		
	
	//이메일 인증
	@GetMapping("/mailCheck")
	@ResponseBody
	public String mailCheck(String email) throws Exception {
		makeRandomNumber();
		emailVO.setReceiver(email);
		emailVO.setSubject("아워스터디 인증번호 안내");
		emailVO.setContent("인증 번호는 " + authNumber + " 입니다." +
						   "\n 해당 인증번호를 정확하게 기입하여 주세요.");
	
		emailSender.sendEmail(emailVO);
		
		return Integer.toString(authNumber);
	}
	

	
	
}
