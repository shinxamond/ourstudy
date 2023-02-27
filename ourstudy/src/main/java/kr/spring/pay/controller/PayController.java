package kr.spring.pay.controller;


import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import kr.spring.member.vo.MemberVO;
import kr.spring.pay.service.PayService;
import kr.spring.pay.vo.PayVO;
import kr.spring.point.vo.PointVO;
import kr.spring.ticket.service.TicketService;
import kr.spring.ticket.vo.TicketVO;


@Controller
public class PayController {
	private final Logger logger = LoggerFactory.getLogger(PayController.class);

	@Autowired
	private PayService payService;

	@Autowired
	private TicketService ticketService;

	@ModelAttribute
	public PayVO initCommand() {
		return new PayVO();
	}

	@GetMapping("/pay/payPage.do")
	public ModelAndView process(@RequestParam int ticket_num) {

		logger.debug("<<이용권 정보>> : " + ticket_num);

		TicketVO ticketVO = ticketService.selectTicket(ticket_num);
		return new ModelAndView("payPage","ticket", ticketVO);

	}

	@RequestMapping("/pay/payPagePoint.do")
	@ResponseBody
	public Map<String, Object> selectPoint(HttpSession session){

		MemberVO user = (MemberVO)session.getAttribute("user");
		Map<String, Object> mapAjax = new HashMap<String, Object>();

		if(user == null) {//로그인 되지 않은 경우
			mapAjax.put("result", "logout");
		}else{//로그인 된 경우 
			int mypoint = payService.selectPoint(user.getMem_num());

			mapAjax.put("result", "success");
			mapAjax.put("mypoint", mypoint);

			logger.debug("<<포인트 정보>> : " + mypoint);

		}
		return mapAjax;
	}
	
	//결제 데이터 받아오기
	@RequestMapping("/pay/payResult.do")
	@ResponseBody
	public Map<String, String> payResult(PayVO payVO,
										 HttpSession session){
		
		Map<String, String>mapAjax = new HashMap<String, String>();
		MemberVO user = (MemberVO)session.getAttribute("user");
		
		if(user == null) {
			mapAjax.put("result", "logout");
		}else {
			payService.insertPay(payVO);
			mapAjax.put("result", "success");
		}
		
		return mapAjax;
	}
}








