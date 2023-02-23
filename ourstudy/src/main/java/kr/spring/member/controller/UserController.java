package kr.spring.member.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class UserController {
	@ResponseBody
	@GetMapping("/main.do")
	public void  kakaoCallback(@RequestParam String code) throws Exception {

	            System.out.println(code);

	    }
}
