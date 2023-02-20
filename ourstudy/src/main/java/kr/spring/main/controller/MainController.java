package kr.spring.main.controller;


import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.spring.admin.service.AdminMemberService;
import kr.spring.admin.vo.AdminMemberVO;

@Controller
public class MainController {
	
	@Autowired
	private AdminMemberService adminMemberService;
	
	@RequestMapping("/")
	public String main() {
		return "redirect:/main/main.do";
	}
	
	@RequestMapping("/main/main.do")
	public String main(Model model) {

		return "memberHome";//타일스 설정값
	}
	
	@RequestMapping("/main/admin.do")
	public String adminMain(Model model) {
		Map<String,Object> map = 
				     new HashMap<String,Object>();
		map.put("start", 1);
		map.put("end", 5);
		List<AdminMemberVO> adminMemberList = 
				adminMemberService.selectList(map);
		
		model.addAttribute("adminMemberList", adminMemberList);
		
		return "admin";//타일스 설정값
	}
	
}





