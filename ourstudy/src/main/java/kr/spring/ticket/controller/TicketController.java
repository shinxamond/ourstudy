package kr.spring.ticket.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import kr.spring.ticket.service.TicketService;
import kr.spring.ticket.vo.TicketVO;

public class TicketController {
	private static final Logger logger = 
			LoggerFactory.getLogger(TicketController.class);
	
	@Autowired
	private TicketService ticketService;
	
	//자바빈 초기화
	@ModelAttribute
	public TicketVO initCommand() {
		return new TicketVO();
	}
	
	//======= 이용권 목록 =========//
	@RequestMapping("/ticket/ticketList.do")
	public ModelAndView process() {
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("ticketList");
		
		
		return mav;
	}
	
	
}
