package kr.spring.email.controller;

import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.spring.email.service.MailSendService;

@Controller
public class EmailController {
	
	@Autowired
	//private MailSendService mailService;
	private EmailSender emailSender;
	@Autowired
	private EmailVO emailVO;
	
	//이메일 인증
	@GetMapping("/mailCheck")
	@ResponseBody
	public String mailCheck(String email) throws Exception {
		
		emailVO.setContent("안녕하세요");
		emailVO.setReceiver("renoir421@naver.com");
		emailVO.setSubject("제목부분");
	
		emailSender.sendEmail(emailVO);
		
		return "redirect:/main/main.do";
	}
	

	
	
}
