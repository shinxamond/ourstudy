package kr.spring.seat.controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import kr.spring.member.service.MemberService;
import kr.spring.member.vo.MemberVO;
import kr.spring.seat.service.SeatService;
import kr.spring.seat.vo.SeatVO;

@Controller
public class SeatController {
	private static final Logger logger = LoggerFactory.getLogger(SeatController.class);
	
	//서비스 주입
	@Autowired
	private SeatService seatService;
	
	@Autowired
	private MemberService memberService;
	
	
	//VO 초기화
	@ModelAttribute("seatVO")
	public SeatVO initCommand() {
		return new SeatVO();
	}
	
	@ModelAttribute("memberVO")
	public MemberVO initCommand2() {
		return new MemberVO();
	}
	
	//좌석선택폼으로 이동
	@RequestMapping("/seat/selectSeatForm.do")
	public ModelAndView drawing() {
		ModelAndView mav = new ModelAndView();
		List<SeatVO> list = seatService.getSeatList();

		mav.setViewName("seat/drawing");
		mav.addObject("list", list);
		
		return mav;
	}
	

	//좌석을 선택한 회원의 정보가 입력됨
	@RequestMapping("/seat/selectSeat.do")
	@ResponseBody
	public Map<String, String> selectSeat(@RequestParam int seat_num, HttpServletRequest request) {
		Map<String, String> mapJson = new HashMap<String, String>();
		
		HttpSession session = request.getSession();
		if(session.getAttribute("user") == null) {
			logger.debug("객체"
					+ " null");
		}
		
		MemberVO member = (MemberVO)session.getAttribute("user");
		
		int mem_num = (Integer)session.getAttribute("user_num");		
		logger.debug("mem_num = " + mem_num);
//		String mem_name = memberService.getMem_Name(mem_num);			
//		logger.debug("mem_name = " + mem_name);
		
		SeatVO seatVO = initCommand();
		if(seatVO == null) {
			logger.debug("이미 선택된 좌석임");
			mapJson.put("result", "fail");
		}
		
		seatVO.setMem_num(mem_num);
//		seatVO.setMem_name(mem_name);
		seatVO.setSeat_num(seat_num);
		seatService.selectSeat(seatVO);
		
		mapJson.put("result", "success");
		
		return mapJson;
	}
	
	//좌석이동
	@RequestMapping("seat/move.do")
	public String moveSeat(HttpServletRequest request) {
		//세션에서 mem_num값을 가져온다
		HttpSession session = request.getSession();
		int mem_num = (Integer)session.getAttribute("user_num");
		
		seatService.outSeat(mem_num);
		
		return "";
		//
	}
	//외출처리
	
	//퇴실처리
	@RequestMapping("/seat/out.do")
	public String Out(@RequestParam int seat_num) {
		seatService.outSeat(seat_num);
		logger.debug("seat_num = " + seat_num);
		
		SeatVO seatVO = seatService.getTimes(seat_num);
		String in_time = seatVO.getIn_time();
		String out_time = seatVO.getOut_time();
		
		logger.debug("in = " + in_time + ", out = " + out_time);
		
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		
		Date in_date = null;
		Date out_date = null;
		
		try {
			in_date = format.parse(in_time);				
			out_date = format.parse(out_time);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		
		long diff = out_date.getTime() - in_date.getTime();
		long diffSeconds = diff / 1000;	
		
		int diffIntSeconds = Long.valueOf(diffSeconds).intValue();
		seatVO.setTotal_time(diffIntSeconds);
		seatVO.setSeat_num(seat_num);
		
		seatService.insertTotal_time(seatVO);
		
		return "";
	}
}

