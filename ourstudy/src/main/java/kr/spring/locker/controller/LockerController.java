package kr.spring.locker.controller;

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
	
	@RequestMapping("/locker/select.do")
	public String selectLocker(@RequestParam int locker_num, HttpServletRequest request, Model model) {
		HttpSession session = request.getSession();
		MemberVO memberVO = (MemberVO)session.getAttribute("user");		
		LockerVO lockerVO = initCommand();
		
		
		if(lockerVO == null || memberVO == null) {
			logger.debug("NULL");
		}
		
		logger.debug("1." + memberVO.getMem_num() + "2." + memberService.getMem_name(memberVO.getMem_num()) +  
				"3." +locker_num );
		

		lockerVO.setMem_num(memberVO.getMem_num());
		lockerVO.setMem_name(memberService.getMem_name(memberVO.getMem_num()));
		lockerVO.setLocker_num(locker_num);
		lockerService.selectLocker(lockerVO);
		
		model.addAttribute("lockerVO", lockerVO);
		
		return "";
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
	
	
}
