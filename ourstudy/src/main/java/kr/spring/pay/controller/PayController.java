package kr.spring.pay.controller;


import java.time.Duration;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
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

import kr.spring.locker.controller.LockerController;
import kr.spring.locker.service.LockerService;
import kr.spring.locker.vo.LockerVO;
import kr.spring.member.service.MemberService;
import kr.spring.member.vo.MemberVO;
import kr.spring.mypage.service.MypageService;
import kr.spring.pay.service.PayService;
import kr.spring.pay.vo.PayVO;
import kr.spring.ticket.service.TicketService;
import kr.spring.ticket.vo.TicketVO;


@Controller
public class PayController {
	private final Logger logger = LoggerFactory.getLogger(PayController.class);

	@Autowired
	private MemberService memberService;

	@Autowired
	private PayService payService;

	@Autowired
	private TicketService ticketService;

	@Autowired
	private MypageService myPageService;

	@Autowired
	private LockerService lockerService;

	@ModelAttribute
	public PayVO initCommand() {
		return new PayVO();
	}

	@ModelAttribute("lockerVO")
	public LockerVO initCommand2() {
		return new LockerVO();
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
			Integer mypoint = myPageService.selectTotalPoint(user.getMem_num());

			mapAjax.put("result", "success");
			mapAjax.put("mypoint", mypoint);
			if(mypoint == null) {
				mapAjax.put("mypoint", 0);
			}

			logger.debug("<<포인트 정보>> : " + mypoint);

		}
		return mapAjax;
	}

	//결제 데이터 받아오기
	@RequestMapping("/pay/payResult.do")
	@ResponseBody
	public Map<String, Object> payResult(PayVO payVO,
			HttpSession session){

		TicketVO ticket = new TicketVO();

		Map<String, Object>mapAjax = new HashMap<String, Object>();
		MemberVO user = (MemberVO)session.getAttribute("user");

		if(user == null) {
			mapAjax.put("result", "logout");
		}else {
			logger.debug("<<카카오 페이 결과 pay>> : " + payVO);
			payVO.setMem_num(user.getMem_num());
			payService.insertPay(payVO);


			//payVO에 담긴 ticket num으로 ticket db에 있는 행 하나 가져오기 mapper에 작성
			ticket = payService.selectTicket(payVO.getTicket_num());


			//ticket 시간 타입 가져오기
			int type = ticket.getTicket_type();
			//ticket 종류 타입 가져오기
			int kind = ticket.getTicket_kind();
			//독서실 시간
			int time;
			//사물함 시간
			int l_time;

			if(kind == 1) {//독서실 이용권
				if(type == 1) {
					time = 2;
				}else if(type == 2) {
					time = 4;
				}else if(type == 3) {
					time = 8;
				}else if(type == 4) {
					time = 12;
				}else if(type == 5) {
					time = 50;
				}else if(type == 6) {
					time = 100;
				}else if(type == 7) {
					time = 7*24;
				}else if(type == 8) {
					time = 2*7*24;
				}else {
					time = 4*7*24;
				}
				//time 설정 끝
				if(type > 6) {//기간권
					payService.updateMemberHistory_Term(time, user.getMem_num());
				}else {//시간권
					payService.updateMemberHistory_Hour(time, user.getMem_num());
				}
			}else {//사물함 이용권	
				/*if(type == 7) {
					l_time = 1;
				}else if(type == 8) {
					l_time = 2;
				}else {
					l_time = 4;
				}*/
				
				
				LockerVO lockerVO = new LockerVO();
				
				lockerVO.setMem_num(user.getMem_num());
				lockerVO.setMem_name(memberService.getMem_name(user.getMem_num()));
				lockerVO.setLocker_num(lockerVO.getLocker_num());
				
				lockerService.selectLocker(lockerVO);
				
				String locker_in_db = lockerService.getLocker_start(lockerVO);
				DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
				
				LocalDateTime in_time = LocalDateTime.parse(locker_in_db,formatter);
				LocalDateTime now_time = LocalDateTime.now();
				String now = now_time.format(formatter);
				now_time = LocalDateTime.parse(now,formatter);
				
				LocalDateTime out_time = in_time.plusWeeks(1);		//1주, 2주, 4주
				String locker_out_db = out_time.format(formatter);
				
				logger.debug("<<DB에서 가져온 이용시작 시간(String)>> : " + locker_in_db);
				logger.debug("<<종료예정시각(String)>> : " + locker_out_db);
				
				logger.debug("<<현재시각(LocalDateTime)>> : " + now_time);
				logger.debug("<<종료예정시각(LocalDateTime)>> : " + out_time);
				
				Duration diff = Duration.between(now_time, out_time);
				long diffSeconds = diff.getSeconds();
				int diffIntSeconds = Long.valueOf(diffSeconds).intValue();
				
				
				logger.debug("<<dif>> : " + diffSeconds);
				logger.debug("<<difInt>> : " + diffIntSeconds);
				
				
				int hour = diffIntSeconds  / 3600;					
				int minute = diffIntSeconds  % 3600 / 60;			
				int second = diffIntSeconds  % 3600 % 60;
				
				logger.debug("종료까지 남은 시간 : " + hour +"시간 " + minute + "분 " + second + "초");
				
				lockerVO.setLocker_end(locker_out_db);
				lockerVO.setLocker_diff(diffIntSeconds);
				
				logger.debug("<<lockerVO>> : " + lockerVO);
				System.out.println(diffIntSeconds);
				
				lockerService.insertEndAndDiff(lockerVO);	
				
			}
			mapAjax.put("result", "success");
			mapAjax.put("payVO", payVO);
		}

		return mapAjax;
	}
}








