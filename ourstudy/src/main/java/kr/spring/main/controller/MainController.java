package kr.spring.main.controller;


import java.time.DayOfWeek;
import java.time.LocalDate;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.spring.admin.service.AdminService;
import kr.spring.info.service.InformationService;
import kr.spring.info.vo.InformationVO;
import kr.spring.main.service.MainService;
import kr.spring.member.vo.MemberVO;
import kr.spring.seat.vo.SeatVO;

@Controller
public class MainController {
	
	@Autowired
	private AdminService adminMemberService; 
	
	@Autowired
	private InformationService informationService;
	
	@Autowired
	private MainService mainService;
	
	//자바빈(VO) 초기화
	@ModelAttribute
	public MemberVO initCommand() {
		return new MemberVO();
	}
	
	@RequestMapping("/")
	public String main() {
		return "redirect:/main/main.do";
	}
	
	@RequestMapping("/main/main.do")
	public String main(Model model) {

		//안내사항 최신글 4개
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("start", 1);
		map.put("end", 4);
		
		List<InformationVO> infoList = informationService.selectInfoList(map);
		model.addAttribute("infoList", infoList);
		
		//누적공부순위 차트
	    Map<String, Object> map2 = new HashMap<String,Object>();
	    
	   //List<MemberVO> member_studyTime = mainService.member_studyTime(map2);  
	    
	   LocalDate now = LocalDate.now();
	   LocalDate setThisMonday = now.with(DayOfWeek.MONDAY);
	   LocalDate setNextMonday = setThisMonday.plusDays(7);

	   int[] memArray = mainService.setMemberArray();

	   for(int i = 0; i < memArray.length; i++) {
		   System.out.println("member[" + i +"] = " + memArray[i]);
	   }

	   
		map2.put("start", 1);
		map2.put("end", 4);
	   
	   List<SeatVO> member_RankStudyTime = mainService.member_Rank(memArray, setThisMonday.toString(), setNextMonday.toString());
	   
		   model.addAttribute("studyTime", member_RankStudyTime);
	   
	   //model.addAttribute("studyTime", member_studyTime);
	   
	   return "main";//타일스 설정값
	}
	
}





