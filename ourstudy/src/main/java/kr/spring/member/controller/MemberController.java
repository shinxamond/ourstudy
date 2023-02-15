package kr.spring.member.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;

import kr.spring.member.controller.MemberController;
import kr.spring.member.vo.MemberVO;

public class MemberController {
	private static final Logger logger = LoggerFactory.getLogger(MemberController.class);

	//자바빈(VO) 초기화
	@ModelAttribute
	public MemberVO initCommand() {
		return new MemberVO();
	}
	
	//회원등록 폼 호출
	@GetMapping("/member/registerUser.do")
	public String form() {
		return "memberRegister"; //타일스 설정값
	}
	
}






