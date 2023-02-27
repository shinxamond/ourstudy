package kr.spring.locker.controller;

import java.time.Duration;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.sun.mail.imap.protocol.SaslAuthenticator;

import kr.spring.locker.service.LockerService;
import kr.spring.locker.vo.LockerVO;
import kr.spring.member.service.MemberService;
import kr.spring.member.vo.MemberVO;

@Controller
public class LockerController {
	private static final Logger logger = LoggerFactory.getLogger(LockerController.class);
	
	@Autowired
	private LockerService lockerService;
	
	@Autowired
	private MemberService memberService;
	
	@ModelAttribute("lockerVO")
	public LockerVO initCommand() {
		return new LockerVO();
	}
	
	@ModelAttribute("memberVO")
	public MemberVO initCommand2() {
		return new MemberVO();
	}
	/*=========================================
				사물함 이용시작 처리
	--------------------------------------------
	1. mapAjax (@respnseBody)
	    로그인 처리 체크 
			ㄴmem_num == null  -> {result - logout} json  ->로그인 모달창 이동
	   이미 이용하는 사물함이 있을 경우 : result - occupied   -> 경고창
	   사용하는 사물함이 없을 경우 : result - empty  -> 다른 링크로 이동
	==================================================*/
	
	
//	//입실 날짜 찍힘과 동시에 마감날짜, 마감까지 남은 날짜 저장
	@RequestMapping("/locker/select.do")
	public String selectLocker(@RequestParam int locker_num, HttpServletRequest request, Model model) {
		HttpSession session = request.getSession();
		MemberVO memberVO = (MemberVO)session.getAttribute("user");		
		LockerVO lockerVO = initCommand();
		
		if(memberVO == null) {
			logger.debug("NULL");
		}
		
		logger.debug("mem_num : " + memberVO.getMem_num() + ", mem_name = " + memberService.getMem_name(memberVO.getMem_num()) +  
				", locker_num = " +locker_num );
		
		lockerVO.setMem_num(memberVO.getMem_num());
		lockerVO.setMem_name(memberService.getMem_name(memberVO.getMem_num()));
		lockerVO.setLocker_num(locker_num);
		
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
		
		return "";			//다시 메인 리다이렉트하던가 모 ... 
	}
	
	
	@RequestMapping("/locker/lockerList.do")
	public String lockerList(@RequestParam String section, Model model) {
		String sec = "";
		switch (section) {
		case "A" : 
			//사물함 리스트를 뽑아서 보낸다. jsp에서 인덱스에 제한을 두고 출력함
			sec = "sectionA";
			break;
		case "B" :
			sec = "sectionB";
			break;
		case "C" : 
			sec = "sectionC";
			break;
		case "D" : 
			sec = "sectionD";
			break;
		};
		model.addAttribute("list", "추출한 사물함 리스트");
		return sec;
	}
	
//	@RequestMapping("/locker/select.do")
//	@ResponseBody
//	public Map<String, String> 
	/*=================================================
	2. 사물함 선택 링크 이동  @request String/ModelAndView
	   //사물함 이용시작 (이용권의 시간 1주/2주/4주 를 check하는 로직 필요) 
	    - mem_num으로 가지고 있는 이용권 주 (int period) 추출 
	       ㄴplusWeek(period) 사용
	          ㄴ종료예정시각, 남은 시간 추출 후 DB입력 
	================================================*/
	
	
//	public String out(HttpServletRequest request) {
//		HttpSession session = request.getSession();
//	    int mem_num = (Integer)session.getAttribute("user_num");
//	    
//	    
//		String in = "2023-02-22 15:34:58";		//사물함 선택한 시간
//		
//		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
//		
//		LocalDateTime in_time = LocalDateTime.parse(in,formatter);
//		LocalDateTime now_time = LocalDateTime.now();
//		
//		System.out.println("사물함 선택 시간 = " + in_time);
//		System.out.println("현재시간 = " + now_time);	
//		
//		LocalDateTime out_time = in_time.plusWeeks(1);		//1주, 2주, 4주
//		System.out.println(out_time);
//		
//		Duration diff = Duration.between(now_time.toLocalTime(), out_time.toLocalTime());
//		long diffSeconds = diff.getSeconds();
//		int diffIntSeconds = Long.valueOf(diffSeconds).intValue();
//		
//		int hour = diffIntSeconds  / 3600;					
//		int minute = diffIntSeconds  % 3600 / 60;			
//		int second = diffIntSeconds  % 3600 % 60;
//		
//		System.out.println("종료까지 남은 시간 : " + hour +"시간 " + minute + "분 " + second + "초");
//		return "";
//	}
//	
}
