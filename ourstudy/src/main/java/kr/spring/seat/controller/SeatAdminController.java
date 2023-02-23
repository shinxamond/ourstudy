package kr.spring.seat.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import kr.spring.member.vo.MemberVO;
import kr.spring.seat.service.SeatService;
import kr.spring.seat.vo.SeatVO;

@Controller
public class SeatAdminController {
	private static final Logger logger = LoggerFactory.getLogger(SeatAdminController.class);
	
	@Autowired
	private SeatService seatService;
	
	@ModelAttribute("seatVO")
	public SeatVO initCommand() {
		return new SeatVO();
	}
	
	@ModelAttribute("memberVO")
	public MemberVO initCommand2() {
		return new MemberVO();
	}
	
	
	@RequestMapping("/seat/insertForm.do")
	public String insertForm(HttpServletRequest request, Model model) {
		HttpSession session = request.getSession();
		MemberVO member = (MemberVO)session.getAttribute("user");
		int mem_num = member.getMem_num();
		int mem_auth = member.getMem_auth();
		
		logger.debug("mem_num = " + mem_num);
		logger.debug("mem_auth = " + mem_auth);
		
		List<SeatVO> list = seatService.getSeatList();
		
		model.addAttribute("mem_num", mem_num);
		model.addAttribute("member", member);
		model.addAttribute("list", list);
		
		return "seat/admin_drawing";
	}
	
//	@RequestMapping("/seat/insert.do")
//	@ResponseBody
//	public Map<String, String> checkInsertSeat(SeatVO vo) {
//		Map<String, String> mapJson = new HashMap<String, String>();
//		
//		if(vo == null) {
//			logger.debug("NULL");
//			mapJson.put("result", "InsertFail");
//		}
//		logger.debug("NOT NULL");
//		seatService.insertSeat(vo);
//		mapJson.put("result", "InsertSuccess");
//		
//		return mapJson;
//	}
	
	@PostMapping("/seat/insert.do")
	public ModelAndView insertSeat(SeatVO vo) {
		seatService.insertSeat(vo);
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("seat/seatDrawing");
		mav.addObject("seatVO", vo);
		return mav;
	}
	
}
