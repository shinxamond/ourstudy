package kr.spring.pay.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;


import kr.spring.member.vo.MemberVO;
import kr.spring.pay.service.PayService;
import kr.spring.pay.vo.PayVO;
import kr.spring.ticket.service.TicketService;
import kr.spring.ticket.vo.TicketVO;

@Controller
public class PayController {
	private final Logger logger =
			LoggerFactory.getLogger(PayController.class);
	
	@Autowired
	private PayService payService;
	
	@Autowired
	private TicketService ticketService;
	
	@ModelAttribute
	public PayVO initCommand() {
		return new PayVO();
	}
	
	@RequestMapping("/pay/payPage.do")
	public String list(HttpSession session,
					   Model model) {
		
		/*
		 * MemberVO user = (MemberVO)session.getAttribute("user"); Map<String, Object>
		 * map = new HashMap<String, Object>(); map.put("user_num", user.getMem_num());
		 * 
		 * List<PayVO> list = null;
		 * 
		 * list = payService.selectListPay(map);
		 * 
		 * model.addAttribute("list",list);
		 */
		
		return "payPage";
	}
	
	//이용권 정보
	@RequestMapping("/pay/payinfo.do")
	@ResponseBody
	public Map<String, Object> submit(PayVO payVO,
								HttpSession session){
		
		logger.debug("<<이용권 결제 정보 담기 >> : " + payVO);
		
		Map<String, Object> mapAjax = new HashMap<String, Object>();
		
		MemberVO user = (MemberVO)session.getAttribute("user");
		TicketVO ticketVO = (TicketVO)session.getAttribute("ticketVO");
		
		if(user == null) {//로그인이 되지 않은 경우
			mapAjax.put("result", "logout");
		
		}else {//로그인 된 경우
			payVO.setMem_num(user.getMem_num());
			
			PayVO db_pay = payService.selectPay(payVO);
			if(db_pay == null) {
				ticketService.selectTicket(ticketVO.getTicket_num());
				mapAjax.put("result", "success");
			}else {
				//이용권 정보 호출
				TicketVO ticket = ticketService.selectTicket(db_pay.getTicket_num());
				payService.selectPay_num();
				mapAjax.put("result", "success");
			}
		}
		
		return mapAjax;
		
	}

	
}
