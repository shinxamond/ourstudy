package kr.spring.pay.controller;


import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

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


	@ModelAttribute
	public PayVO initCommand() {
		return new PayVO();
	}

	@ModelAttribute("lockerVO")
	public LockerVO initCommand2() {
		return new LockerVO();
	}

	@GetMapping("/pay/study_pay.do")
	public ModelAndView study_pay(@RequestParam int ticket_num) {

		logger.debug("<<이용권 정보>> : " + ticket_num);

		TicketVO ticketVO = ticketService.selectTicket(ticket_num);
		return new ModelAndView("study_pay","ticket", ticketVO);

	}
	
	@GetMapping("/pay/locker_pay.do")
	public ModelAndView locker_pay(Integer locker_num, Integer ticket_num, HttpSession session, Model model) {
		Integer ticket_numFromSession = (Integer)session.getAttribute("ticket_num");//Session에서 이용권 번호 가져오기
		
		if(ticket_numFromSession != null) {
			logger.debug("<<이용권 정보>> : " + ticket_numFromSession);

			TicketVO ticketVO = ticketService.selectTicket(ticket_numFromSession);
			
			session.removeAttribute("ticket_num");//정보 삭제
			
			model.addAttribute("locker_num", locker_num);
			
			return new ModelAndView("locker_pay","ticket", ticketVO);
		}else {
			TicketVO ticketVO = ticketService.selectTicket(ticket_num);
			
			model.addAttribute("locker_num", locker_num);
			
			return new ModelAndView("locker_pay","ticket", ticketVO);
		}

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
	
	//시간권,기간권 보유 체크
	@RequestMapping("/pay/checkTicket.do")
	@ResponseBody
	public Map<String, Object> checkTicket(PayVO payVO,
										   HttpSession session){
		
		Map<String, Object> mapAjax = new HashMap<String, Object>();
		MemberVO user = (MemberVO)session.getAttribute("user");
		TicketVO ticket = new TicketVO();
		
		logger.debug("<<시간제,기간권 보유 체크>> : " + payVO);
		
		ticket = ticketService.selectTicket(payVO.getTicket_num());
		int type = ticket.getTicket_type();
		
		
		if(user == null) {
			mapAjax.put("result", "logout");
		}else {
			Integer m_term = payService.checkTerm(user.getMem_num());
			double m_time = Double.parseDouble(payService.checkTime(user.getMem_num()));

			logger.debug("남은 기간"+ m_term);
			logger.debug("남은 시간"+ m_time);
			
			if(m_term > 0) {//기간권 보유중
				if(type < 7) {//시간권 구매 불가
					mapAjax.put("result", "cantBuy");
				}else {//기간권 구매 가능
					mapAjax.put("result", "success");	
				}
			}else if(m_time != 0) {//시간권 보유중
				if(type > 6) {//기간권 구매 불가
					mapAjax.put("result", "cantBuy");
				}else {//시간권 구매 가능
					mapAjax.put("result", "success");	
				}
			}else {
			mapAjax.put("result", "success");		
			}
		}
		return mapAjax;
	}

	//결제 데이터 받아오기
	@RequestMapping("/pay/payResult.do")
	@ResponseBody
	public Map<String, Object> payResult(
			PayVO payVO,
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

			if(kind == 1) {//독서실 이용권
				if(type == 1) {
					time = 1;
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
				
				int checkUser = payService.checkUsingLocker(user.getMem_num());
				if(checkUser != 0) {
					//이미 사물함 이용하고 있으니까 연장해주면 됨
					String originEnd = payService.selectLockerEnd(user.getMem_num());
					System.out.println("오리진엔드" + originEnd);
					DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
					LocalDateTime oEnd = LocalDateTime.parse(originEnd, formatter);
					System.out.println("변환한 엔드" + oEnd);
						if(type == 7) {
							oEnd = oEnd.plusWeeks(1);
			            }else if(type == 8){
			            	oEnd = oEnd.plusWeeks(2);
			            }else {
			            	oEnd = oEnd.plusWeeks(4);
			            }
					
					originEnd = oEnd.format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));
					System.out.println("변환후 오리진엔드 스트링" + originEnd);
					String[] originEnd_split = originEnd.split(" ");
					System.out.println("오리진엔드 스플릿1" + originEnd_split[0]);
					LockerVO locker = new LockerVO();
					locker.setMem_num(user.getMem_num());
					locker.setLocker_end(originEnd_split[0]);
					
					payService.updateLocker_end(locker);
				}else {
					//사물함 이용한 내역이 없거나 
					//사물함 시간 구하기
					
					
					DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
					/*
					 * 이미 사물함 이용하고 있고 거기에 + 구매 할떄 end_time 업데이트하기
					 * 사물함 결제 - 지금 이미 사물함을 이용중인가 or 처음 구매냐 
					 * 
					 * 1. locker_detail에서 end_time 값 가져오기 -> vo가 String임
					 * 2. String타입이니까 계산하라면 localdatetime타입으로 변환 : String -> localdatetime
					 * 3. 변환한 localdatetime 변수에 .plusWeeks  -> localdatetime 타입임
					 * 4. localdatetime -> String으로 변환해주기
					 * 5. 변환된 String타입 변수 vo에 담아서 update문 호출
					 */
					PayVO payVOForLocker = new PayVO();
					String mem_name = memberService.getMem_name(user.getMem_num());
					
					payVOForLocker.setMem_num(user.getMem_num());
					System.out.println(user.getMem_num());
					payVOForLocker.setMem_name(mem_name);
					System.out.println(mem_name);
					payVOForLocker.setLocker_num(payVO.getLocker_num());
					
					LocalDateTime now_time = LocalDateTime.now();
					String now = now_time.format(formatter);
					now_time = LocalDateTime.parse(now,formatter);
		            LocalDateTime end_time;    //1주, 2주, 4주
		            if(type == 7) {
		               end_time = now_time.plusWeeks(1);
		            }else if(type == 8){
		               end_time = now_time.plusWeeks(2);
		            }else {
		               end_time = now_time.plusWeeks(4);
		            }
		            String newEnd = end_time.format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));
		            System.out.println(newEnd);
					payVOForLocker.setLocker_end(newEnd);
					
					payService.insertNewLockerMember(payVOForLocker);
				}
			}
			mapAjax.put("result", "success");
			mapAjax.put("payVO", payVO);
		}
		return mapAjax;
	}
}








