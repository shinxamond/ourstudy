package kr.spring.seat.controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.mail.Session;
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
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.spring.member.service.MemberService;
import kr.spring.member.vo.MemberVO;
import kr.spring.mypage.service.MypageService;
import kr.spring.seat.service.SeatService;
import kr.spring.seat.service.SeatServiceImpl;
import kr.spring.seat.vo.SeatVO;

@Controller
public class SeatController {
   private static final Logger logger = LoggerFactory.getLogger(SeatController.class);
   
   //서비스 주입
   @Autowired
   private SeatService seatService;
   
   @Autowired
   private MemberService memberService;
   
   @Autowired
   private MypageService myPageService;
   
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
   @RequestMapping("/seat/selectForm.do")
   public ModelAndView selectForm(HttpSession session) {
	  int mem_status = seatService.getMem_status((Integer)session.getAttribute("user_num"));
	  
	  MemberVO member = (MemberVO)session.getAttribute("user");
	  
      ModelAndView mav = new ModelAndView();
      
      List<SeatVO> list = seatService.getSeatList();

      mav.setViewName("selectForm");
      mav.addObject("mem_num", member.getMem_num());
      mav.addObject("list", list);
      mav.addObject("mem_status", mem_status);
      
      return mav;
   }
   
   //좌석을 선택한 회원의 정보가 입력됨(기간권,시간권 잔여시간 없을 경우 결제페이지 호출)
   @RequestMapping("/seat/select.do")
   public String selectSeat(@RequestParam int seat_num,HttpServletRequest request,RedirectAttributes attributes, Model model) {
      HttpSession session = request.getSession();
      MemberVO member = (MemberVO)session.getAttribute("user");
      if(member == null) {
         logger.debug("객체 null");
      }
      
      int mem_num = (Integer)session.getAttribute("user_num");      
      String mem_name = memberService.getMem_name(mem_num);       
      int mem_status = seatService.getMem_status(mem_num);
      
      logger.debug("mem_num = " + mem_num);
      logger.debug("mem_name = " + mem_name);
      logger.debug("mem_status = " + mem_status);
      
      Float hour = seatService.getMemberHour(mem_num);
      Float term = seatService.getMemberTerm(mem_num);
      
      logger.debug("HOUR>>>>" + hour);
      
		/*
		 * if(hour.floatValue() > 0) { //잔여시간만 있는 경우 //기간권도 있을 때 
		 * }
		 */
		/*
		 * if(term.floatValue() > 0) { //잔여기간만 있는 경우
		 * 
		 * }
		 */
      if(hour.floatValue() <= 0 && term.floatValue() <= 0) {		//잔여시간, 잔여기간 둘 다 없는 경우
    	 attributes.addAttribute("seat_num", seat_num);
    	 return "redirect:/ticket/study_ticketList.do";
      }
      
      
      SeatVO seatVO = initCommand();
      if(seatVO == null) {
         logger.debug("이미 선택된 좌석임");
      }
      
      seatVO.setMem_num(mem_num);
      seatVO.setMem_name(mem_name);
      seatVO.setSeat_num(seat_num);
      
      seatService.selectSeat(seatVO);
      
      member.setMem_status(seatService.getMem_status(mem_num));
      
      model.addAttribute("seat_num",seat_num);
      attributes.addFlashAttribute("mem_statusForCheckIn", member.getMem_status());
      attributes.addFlashAttribute("mem_numForCheckIn", member.getMem_num());
      return "redirect:/mypage/myPageMain.do";

   }

   //DB에 저장된 잔여시간 가져오기
   @RequestMapping("/seat/deadlineCheck.do")
   @ResponseBody
   public Map<String, String> deadlineCheck(Integer mem_num, HttpSession session){
	   
	   Map<String, String> mapAjax = new HashMap<String, String>();
	   Float hour = seatService.getMemberHour(mem_num);
	   logger.debug(">>>>>>>====DB에서 가져온 시간 변환 전====>>>>>>>" + hour);
	   
	   hour = hour * 3600;
	   
	   logger.debug(">>>>>>>====DB에서 가져온 시간 변환 후 ====>>>>>>>" + hour);
	   
	   
	   
	   if(hour <= 61.0) {
		   mapAjax.put("result", "setLogout");
	   }else if(hour >= 280.0 && hour <= 330.0) {
		   mapAjax.put("time", Float.toString(hour));
		   mapAjax.put("result", "lessThanFive");
	   }else {
		   mapAjax.put("time", Float.toString(hour));
		   mapAjax.put("result", "success");		   
	   }

	   return mapAjax;
   }
   
   //DB 1분마다 update
   @RequestMapping("/seat/updateDeadline.do")
   @ResponseBody
   public Map<String, String> updateDeadline(Float newRemain, HttpSession session){
	   Map<String, String> mapAjax = new HashMap<String, String>();
	   MemberVO member = (MemberVO)session.getAttribute("user");
	   
	   Float hour_prev = seatService.getMemberHour(member.getMem_num());
	   logger.debug(">>>>>DB 갱신 전 hour>>>>" + hour_prev);
	   
	   //String new_remain = String.format("%.3f", newRemain);
	   //newRemain = Float.valueOf(new_remain);
	   
	   seatService.updateMemberHistory_Hour(newRemain / 3600, member.getMem_num());
	   Float hour_next = seatService.getMemberHour(member.getMem_num());
	   
	   logger.debug(">>>DB 갱신 후 HOUR>>>>>>>>>>>>>>>><<<<<===" + hour_next);
	   
	   if(hour_prev == 0.0 || hour_next == 0.0) {
		   mapAjax.put("result", "end");
		   return mapAjax;
	   }else if(!hour_prev.equals(hour_next)) {
		   mapAjax.put("result", "success");
		   return mapAjax;
	   }else {
		   mapAjax.put("result", "Fail");
		   return mapAjax;
	   }
	   
	   
   }
   
   //외출 상태에서 입실 처리
   @RequestMapping("/seat/in.do")
   public String In(HttpSession session, RedirectAttributes attributes) {
	  MemberVO member = (MemberVO)session.getAttribute("user");
      int mem_num = (Integer)session.getAttribute("user_num");
      String mem_name = memberService.getMem_name(mem_num);  
      
      int mem_status = seatService.getMem_status(mem_num);
      
      if(mem_status == 0) {
    	  return "redirect:/seat/selectForm.do";
      }
      
      int seat_num = seatService.getOutMemberSeat(mem_num);
      
      
      logger.debug("<<<<회원정보 >>>>: " + mem_num + "<<<<<<<좌석번호>>>>: " + seat_num + "<<<<회원이름>>>>:" + mem_name);
      
      SeatVO seatVO = initCommand();
      seatVO.setMem_num(mem_num);
      seatVO.setMem_name(mem_name);
      seatVO.setSeat_num(seat_num);

      seatService.inSeatWhenHold(seatVO);
      
      member.setMem_status(seatService.getMem_status(mem_num));
      attributes.addFlashAttribute("mem_statusForCheckIn", member.getMem_status());   
      return "redirect:/mypage/myPageMain.do";
   }
   
   //외출처리
   @RequestMapping("/seat/hold.do")
   public String Hold(@RequestParam int seat_num, HttpSession session, RedirectAttributes attributes) {
	  MemberVO member = (MemberVO)session.getAttribute("user");
      int mem_num = (Integer)session.getAttribute("user_num");      
      
      logger.debug("user_num ============= " +  mem_num);
      
      SeatVO seatVO = initCommand();
      seatVO.setMem_num(mem_num);
      seatVO.setSeat_num(seat_num);
      
      logger.debug(">>> mem_num>>>" + mem_num);
      logger.debug("<<<seat_num<<<" + seat_num); 
      
      seatService.holdSeat(seatVO);
      
      seatVO = seatService.getTimes(seat_num);
      
      String in_time = seatVO.getIn_time();
      String out_time = seatVO.getOut_time(); 
      
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
      
      logger.debug("<<<<<<<diffSeconds>>>>> : " + diffSeconds);
      
      int diffIntSeconds = Long.valueOf(diffSeconds).intValue();
      
      seatVO.setTotal_time(diffIntSeconds);
      seatVO.setSeat_num(seat_num);
      seatVO.setMem_num(mem_num);
      
      seatService.insertTotal_time(seatVO);
      
      member.setMem_status(seatService.getMem_status(mem_num));
      
      attributes.addFlashAttribute("mem_statusForCheckIn", member.getMem_status());
      
      return "redirect:/mypage/myPageMain.do";
   }
    
   //회원 퇴실처리 + 관리자 권한 강제 퇴실처리
   @RequestMapping("/seat/out.do")
   public String Out(@RequestParam(value="seat_num", required=false, defaultValue="1") int seat_num, HttpSession session, RedirectAttributes attributes) {
      MemberVO member = (MemberVO)session.getAttribute("user");
      
      SeatVO seatVO = initCommand();
      
      int mem_num = (Integer)session.getAttribute("user_num");
      int mem_status = seatService.getMem_status(mem_num);
      int mem_auth = member.getMem_auth();
      
      if(mem_status == 2 && mem_auth == 1) {										//현재 회원이 외출 상태일 때
    	  seat_num = seatService.getOutMemberSeat(mem_num);
    	  
    	  logger.debug("<<<<<<<<<<<<<<<<<<<seat_num>>>>>>>>>>>>>>>>" + seat_num);
    	  logger.debug("<<<<<<<mem_auth>>>>> --- " + mem_auth);
    	  logger.debug(">>>mem_num>>>>" + mem_num);
    	  
    	  seatVO.setMem_num(mem_num);
    	  seatVO.setSeat_num(seat_num);
    	  
    	  seatService.outSeatWhenHold(seatVO);
    	  
    	  member.setMem_status(seatService.getMem_status(mem_num));
    	  
    	  attributes.addFlashAttribute("mem_statusForCheckIn", member.getMem_status());
    	  
    	  return "redirect:/mypage/myPageMain.do";
      }else if(mem_status == 1 && mem_auth == 1) {								//현재 회원이 입실 상태일 때
    	  seat_num = seatService.getInMemberSeat(mem_num);
    	  
    	  logger.debug("<<<<<<<<<<<<<<<<<<<seat_num>>>>>>>>>>>>>>>>" + seat_num);
    	  logger.debug(">>>mem_num<<<<<====" + mem_num);
    	  
    	  seatVO.setMem_num(mem_num);
    	  seatVO.setSeat_num(seat_num);
    	  
    	  seatService.outSeatWhenIn(seatVO);
    	  
    	  member.setMem_status(seatService.getMem_status(mem_num));
      }

      
      if(member.getMem_auth() == 9) { 
    	   mem_num = seatService.getSeatDetail(seat_num).getMem_num();
       
    	   logger.debug("<<타겟 멤넘>> ::::: " + mem_num); 
    	   logger.debug(">>>>>관리자한테만 보이는 좌석번호>>>>>>" + seat_num);
       }
      
      logger.debug("<<user_auth>> --------------= " + member.getMem_auth());					//관리자 신분 검사
      logger.debug("<<<<mem_NUM>>>> : " + mem_num);
      logger.debug("<<<<SEAT_NUM>>>> : " + seat_num);
      
      seatVO.setMem_num(mem_num);
      seatVO.setSeat_num(seat_num);

      logger.debug("seat_num = " + seat_num);
      
      if(member.getMem_auth() == 9 && seatService.getSeat_status(seat_num) == 0) {
    	  logger.debug(">>>>>TARGET_NUMBER>>>>===>>>>" + mem_num);
    	  
    	  seatService.outSeatWhenIn(seatVO);
      }
      
      seatVO = seatService.getTimes(seat_num);
      
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
      seatVO.setMem_num(mem_num);
      
      seatService.insertTotal_time(seatVO);
      
      seatVO.setTotal_time(diffIntSeconds);
      
      myPageService.updateStudyTime(seatVO);
      
      member.setMem_status(seatService.getMem_status(mem_num));
      
      logger.debug("seatVO" + seatVO);

      //관리자에서 강제 퇴실할 경우 
      if(member.getMem_auth() == 9) { 
    	  return "redirect:/admin/admin_seathistory.do"; 
      }
		
      attributes.addFlashAttribute("mem_statusForCheckIn", member.getMem_status());
      
      return "redirect:/mypage/myPageMain.do";
   }

}
