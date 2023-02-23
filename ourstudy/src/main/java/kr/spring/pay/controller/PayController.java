package kr.spring.pay.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.spring.member.vo.MemberVO;
import kr.spring.pay.service.PayService;
import kr.spring.pay.vo.PayVO;


@Controller
public class PayController {
	private final Logger logger = LoggerFactory.getLogger(PayController.class);

	@Autowired
	private PayService payService;

	@ModelAttribute
	public PayVO initCommand() {
		return new PayVO();
	}

	@RequestMapping("/pay/payPage.do")
	@ResponseBody
	public Map<String, String> submit(PayVO payVO,
			HttpSession session){

		logger.debug("<<이용권 정보 담기>> : " + payVO);

		Map<String, String> mapAjax = new HashMap<String, String>();

		MemberVO user = (MemberVO)session.getAttribute("user");

		if(user == null) {
			mapAjax.put("result", "logout");
		}else {
			payVO.setMem_num(user.getMem_num());

			PayVO db_pay = payService.selectPay(payVO);

			if(db_pay == null) {
				payService.insertPay(payVO);
				mapAjax.put("result", "success");
			}
		}
		return mapAjax;
	}
}









