package kr.spring.ticket.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

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

	//이용권 목록
	@RequestMapping("/ticket/admin_ticketList.do")
	public ModelAndView process() {

		ModelAndView mav = new ModelAndView();
		mav.setViewName("adminTicketList");


		return mav;
	}

	//======= 상품 등록 =======//
	@GetMapping("/ticket/admin_write.do")
	public String form() {
		return "ticketAdminWrite"; //타일스 설정값
	}

}


