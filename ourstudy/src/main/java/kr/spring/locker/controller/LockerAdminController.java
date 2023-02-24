package kr.spring.locker.controller;

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

import kr.spring.locker.service.LockerService;
import kr.spring.locker.vo.LockerVO;
import kr.spring.member.service.MemberService;
import kr.spring.member.vo.MemberVO;

@Controller
public class LockerAdminController {
	private static final Logger logger = LoggerFactory.getLogger(LockerAdminController.class);
	
	@Autowired
	private LockerService lockerService;
	
	@Autowired
	private MemberService MemberService;
	
	@ModelAttribute("lockerVO")
	public LockerVO initCommand() {
		return new LockerVO();
	}
	
	@ModelAttribute("memberVO")
	public MemberVO initCommand2() {
		return new MemberVO();
	}
	/*===========================
	 * 			사물함 편집 폼
	 ============================*/
	//사물함 관리폼
	@RequestMapping("/locker/editForm.do")
	public String editForm(HttpServletRequest request, Model model) {
		HttpSession session = request.getSession();
		
		MemberVO memberVO = (MemberVO)session.getAttribute("user");
		logger.debug("<<mem_auth>> : " + memberVO.getMem_auth());
		
		List<LockerVO> list = lockerService.getLockerList();
		
		model.addAttribute("list", list);
		return "locker/admin_editForm";
	}
	
	//사물함 추가
	@RequestMapping("/locker/insert.do")
	public String insertLocker() {
		LockerVO lockerVO = initCommand();
		
		lockerService.insertLocker(lockerVO);
		return "";
	}
}
