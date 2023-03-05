package kr.spring.locker.controller;

import java.time.Duration;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

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

import kr.spring.locker.service.LockerService;
import kr.spring.locker.vo.LockerVO;
import kr.spring.member.service.MemberService;
import kr.spring.member.vo.MemberVO;
import kr.spring.ticket.service.TicketService;

@Controller
public class LockerController {
	private static final Logger logger = LoggerFactory.getLogger(LockerController.class);
	
	@Autowired
	private LockerService lockerService;
	
	@Autowired
	private MemberService memberService;
	
	@Autowired
	private TicketService ticketService;
	
	@ModelAttribute("lockerVO")
	public LockerVO initCommand() {
		return new LockerVO();
	}
	
	@ModelAttribute("memberVO")
	public MemberVO initCommand2() {
		return new MemberVO();
	}
	
	//섹션 폼 이동
	@RequestMapping("/locker/section.do")
	public String Section(@RequestParam int ticket_num, Model model, HttpSession session) {
		session.setAttribute("ticket_num", ticket_num);
		return "sectionForm";
	}
	
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
		
		model.addAttribute("locker_num", locker_num);
		
		return "redirect:/main/main.do";			
	}
	
	
	@RequestMapping("/locker/sectionDetail.do")
	public String sectionDetail(@RequestParam String section, Model model, HttpSession session) {
		MemberVO member = (MemberVO)session.getAttribute("user");
		int mem_status = member.getMem_status();
		
		List<LockerVO> list = lockerService.getLockerList();
	     
		model.addAttribute("list", list);
		model.addAttribute("mem_status", mem_status);
		
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
		
		logger.debug("<<<<요청된 섹션 파라미터>>>>:" + sec);
		
		return sec;
	}
}
