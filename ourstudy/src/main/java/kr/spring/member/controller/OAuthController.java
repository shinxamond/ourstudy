package kr.spring.member.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/main.do")
public class OAuthController {
	 @ResponseBody
	    @GetMapping("/main.do")
	    public void kakaoCallback(@RequestParam String code) {
	        System.out.println(code);
	    }
}
