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
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.spring.locker.service.LockerService;
import kr.spring.locker.vo.LockerVO;
import kr.spring.member.service.MemberService;
import kr.spring.member.vo.MemberVO;
import kr.spring.mypage.service.MypageService;
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
   
   @Autowired
   private LockerService lockerService;
   
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
   @RequestMapping("/seat/selectSeatForm.do")
   public ModelAndView drawing(HttpSession session) {
	  int mem_status = seatService.getMem_status((Integer)session.getAttribute("user_num"));
	  
      ModelAndView mav = new ModelAndView();
      List<SeatVO> list = seatService.getSeatList();

      mav.setViewName("seat/selectForm");
      mav.addObject("list", list);
      mav.addObject("mem_status", mem_status);
      
      return mav;
   }

   /*===========KEEP============================================================================
   //좌석선택폼으로 이동
   @RequestMapping("/seat/checkMember.do")
   @ResponseBody
   public Map<String, String> checkMember(@RequestParam (value="mem_auth", defaultValue="0") int mem_auth, HttpSession session) {
//	   HttpSession session = request.getSession();
//	   MemberVO memberVO = (MemberVO)session.getAttribute("user");
	   Map<String, String> map  = new HashMap<String, String>();
	   logger.debug("mem_auth = " + mem_auth);
	   
	   if(mem_auth == 0) {
		   map.put("auth", "notMember"); 			//로그아웃 상태거나 회원이 아님
	   }else if(mem_auth == 9) {
		   map.put("auth", "admin");				//관리자임
	   }
	   map.put("auth", "member");					//일반회원임
	   return map;
   }
   
   
   
   //좌석을 선택한 회원의 정보가 입력됨
   @RequestMapping("/seat/select.do")
   @ResponseBody
   public Map<String, String> selectSeat(@RequestParam int seat_num, HttpServletRequest request) {
      Map<String, String> mapJson = new HashMap<String, String>();
      
      HttpSession session = request.getSession();
      if(session.getAttribute("user") == null) {
         logger.debug("객체 null");
      }
      
      int mem_num = (Integer)session.getAttribute("user_num");      
      String mem_name = memberService.getMem_name(mem_num);         
      logger.debug("mem_num = " + mem_num);
      logger.debug("mem_name = " + mem_name);
      
      SeatVO seatVO = initCommand();
      if(seatVO == null) {
         logger.debug("이미 선택된 좌석임");
         mapJson.put("result", "fail");
      }
      
      seatVO.setMem_num(mem_num);
      seatVO.setMem_name(mem_name);
      seatVO.setSeat_num(seat_num);
      seatService.selectSeat(seatVO);
      
      mapJson.put("result", "success");
      
      return mapJson;
   }
   =============================================================================================*/
   
   //좌석을 선택한 회원의 정보가 입력됨
   @RequestMapping("/seat/select.do")
   public String selectSeat(@RequestParam int seat_num,HttpServletRequest request,RedirectAttributes attributes, Model model) {
      HttpSession session = request.getSession();
      if(session.getAttribute("user") == null) {
         logger.debug("객체 null");
      }
      
      int mem_num = (Integer)session.getAttribute("user_num");      
      String mem_name = memberService.getMem_name(mem_num);       
      int mem_status = seatService.getMem_status(mem_num);
      
      logger.debug("mem_num = " + mem_num);
      logger.debug("mem_name = " + mem_name);
      logger.debug("mem_status = " + mem_status);
      
      SeatVO seatVO = initCommand();
      if(seatVO == null) {
         logger.debug("이미 선택된 좌석임");
      }
      
      seatVO.setMem_num(mem_num);
      seatVO.setMem_name(mem_name);
      seatVO.setSeat_num(seat_num);
      seatService.selectSeat(seatVO);
      
      String success_message = "좌석이 선택되었습니다.";
      attributes.addFlashAttribute("message", success_message);
//      List<LockerVO> list = lockerService.getLockerList();
//      
//      model.addAttribute("list", list);
//      model.addAttribute("mem_status", mem_status);
      	model.addAttribute("seat_num",seat_num);
      
      return "seat/temporary_page";
   }


   
   //좌석이동
   @RequestMapping("/seat/move.do")
   public String moveSeat(HttpServletRequest request) {
      //세션에서 mem_num값을 가져온다
      HttpSession session = request.getSession();
      int mem_num = (Integer)session.getAttribute("user_num");      
//      String mem_name = memberService.getMem_name(mem_num);   
      
      SeatVO seatVO = initCommand();
      seatVO.setMem_num(mem_num);
//      seatVO.setSeat_num(seat_num);
      seatService.outSeatWhenIn(seatVO);
      
      return "";
      //
   }
   
   //외출 상태에서 입실 처리
   @RequestMapping("/seat/in.do")
   @ResponseBody
   public Map<String, String> In(@RequestParam int seat_num, HttpServletRequest request) {
      HttpSession session = request.getSession();
      Map<String, String> map = new HashMap<String, String>();
      
      int mem_num = (Integer)session.getAttribute("user_num");
      int mem_status = seatService.getMem_status(mem_num);
      
      SeatVO seatVO = initCommand();
      seatVO.setMem_num(mem_num);
      seatVO.setSeat_num(seat_num);

      if(mem_status != 2) {            //외출 상태가 아닐때
         map.put("status", "NotHold");
      }
         // 외출상태일 때
         seatService.inSeatWhenHold(seatVO);
         map.put("status", "Hold");
         
         return map;
   }
   
   //외출처리
   @RequestMapping("/seat/hold.do")
   public String Hold(@RequestParam int seat_num, HttpServletRequest request) {
      HttpSession session = request.getSession();
      int mem_num = (Integer)session.getAttribute("user_num");      
      String mem_name = memberService.getMem_name(mem_num);   
      
      SeatVO seatVO = initCommand();
      seatVO.setMem_num(mem_num);
      seatVO.setSeat_num(seat_num);
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
      
      int diffIntSeconds = Long.valueOf(diffSeconds).intValue();
      seatVO.setTotal_time(diffIntSeconds);
      seatVO.setSeat_num(seat_num);
      
      seatService.insertTotal_time(seatVO);
      return "";
   }
   
   //회원 퇴실처리 + 관리자 권한 강제 퇴실처리
   @RequestMapping("/seat/out.do")
   public String Out(@RequestParam int seat_num, HttpServletRequest request) {
      HttpSession session = request.getSession();
      MemberVO member = (MemberVO)session.getAttribute("user");
      
      int mem_num = (Integer)session.getAttribute("user_num");
      if(member.getMem_auth() == 9) {
    	  mem_num = seatService.getSeatDetail(seat_num).getMem_num();
    	  logger.debug("<<타겟 멤넘>> ::::: " + mem_num);
      }
      int mem_status = seatService.getMem_status(mem_num);
      
      logger.debug("<<user_auth>> --------------= " + member.getMem_auth());					//관리자 신분 검사
      
      SeatVO seatVO = initCommand();
      seatVO.setMem_num(mem_num);
      seatVO.setSeat_num(seat_num);

      														
	  if(mem_status == 2) {            //외출 상태일 때
		  seatService.outSeatWhenHold(seatVO);
	  }if(mem_status == 1) {            //입실 상태일 때
		  seatService.outSeatWhenIn(seatVO);
	  }
  
      
      logger.debug("seat_num = " + seat_num);
      
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
      
      logger.debug("seatVO" + seatVO);
      
      return "";
   }

}
