package kr.spring.ticket.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.spring.ticket.service.TicketService;
import kr.spring.ticket.vo.TicketVO;

@Controller
public class TicketAdminController {
	private static final Logger logger = 
			LoggerFactory.getLogger(TicketAdminController.class);

	@Autowired
	private TicketService ticketService;

	//자바빈 초기화
	@ModelAttribute
	public TicketVO initCommand() {
		return new TicketVO();
	}

	//======= 상품 등록 =======//
	@GetMapping("/ticket/admin_write.do")
	public String form() {
		return "ticketAdminWrite"; //타일스 설정값
	}
	
	//등록 폼에서 전송된 데이터 처리
	@PostMapping("/ticket/admin_write.do")
	public String submit(@Valid TicketVO ticketVO,
						 BindingResult result,
						 HttpServletRequest request,
						 RedirectAttributes redirect,
						 HttpSession session) {
		
		
		
		return "";
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}

