package kr.spring.admin.controller;

import java.text.DecimalFormat;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import kr.spring.admin.service.AdminService;
import kr.spring.admin.vo.AdminLockerHistoryVO;
import kr.spring.admin.vo.AdminMemberVO;
import kr.spring.admin.vo.AdminSeatHistoryVO;
import kr.spring.seat.vo.SeatVO;
import kr.spring.util.PagingUtil;

@Controller
public class AdminController {
	private static final Logger logger =
			           LoggerFactory.getLogger(
					     AdminController.class);
	
	@ModelAttribute("AdminMemberVO")
	public AdminMemberVO initCommand() {
		return new AdminMemberVO();
	}
	
	@ModelAttribute("AdminSeatHistoryVO")
	public AdminSeatHistoryVO initCommand2() {
		return new AdminSeatHistoryVO();
	}

	@ModelAttribute("AdminLockerHistoryVO")
	public AdminLockerHistoryVO initCommand3() {
		return new AdminLockerHistoryVO();
	}
	
	@Autowired
	private AdminService adminService;
	
	//=====현재고객현황판 및 회원목록 관리=====//
	@RequestMapping("/admin/admin_list.do")
	public ModelAndView process(
			@RequestParam(value="pageNum",defaultValue="1") int currentPage,
			@RequestParam(value="keyfield",defaultValue="1") String keyfield, 
			String keyword) {
		
		//현재 고객 현황판
		DecimalFormat df = new DecimalFormat("###,###");
		
		int total1 = adminService.countUsingNum();	
		String usingnum = df.format(total1);
		
		int total2 = adminService.countTermNum();	
		String periodnum = df.format(total2);
		
		int total3 = adminService.countTimeNum();	
		String timenum = df.format(total3);
		
		String totalnum = df.format(total2+total3);
		
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("keyfield", keyfield);
		map.put("keyword", keyword);
		
		//총 글의 개수 또는 검색된 글의 갯수
		int count = adminService.selectRowCount(map);
		
		//페이지 처리
		PagingUtil page = new PagingUtil(keyfield,keyword,currentPage,count,5,10,"admin_list.do");
		
		List<AdminMemberVO> list = null;
		if(count > 0) {
			map.put("start", page.getStartRow());
			map.put("end", page.getEndRow());
			
			list = adminService.selectList(map);
		}
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("adminMemberList");
		
		//현재고객현황판
		mav.addObject("usingnum", usingnum);
		mav.addObject("periodnum", periodnum);
		mav.addObject("timenum", timenum);
		mav.addObject("totalnum", totalnum);
		
		//회원목록
		mav.addObject("count", count);
		mav.addObject("adminMemberList", list);
		mav.addObject("page", page.getPage());
		
		return mav;
	}
	
	
	//=====좌석 히스토리 목록=====//
	@RequestMapping("/admin/admin_seathistory.do")
	public ModelAndView seathistory(
			@RequestParam(value="pageNum",defaultValue="1") int currentPage,
			@RequestParam(value="keyfield",defaultValue="1") String keyfield) {
		
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("keyfield", keyfield);
		
		//총 글의 개수 또는 검색된 글의 갯수
		int count = adminService.selectSeatRowCount(map);
		logger.debug("<<총 글 갯수>> : " + count);
		
		//페이지 처리
		PagingUtil page = new PagingUtil(keyfield,null,currentPage,count,4,10,"admin_seathistory.do");
		
		List<AdminSeatHistoryVO> list = null;
		if(count > 0) {
			map.put("start", page.getStartRow());
			map.put("end", page.getEndRow());
			
			list = adminService.selectSeatList(map);
		}
				
		ModelAndView mav = new ModelAndView();
		mav.setViewName("adminSeatHistory");
		
		//좌석히스토리목록
		mav.addObject("count", count);
		mav.addObject("adminUseHistoryList", list);
		mav.addObject("page", page.getPage());
		
		return mav;
	}		

	//=====사물함 히스토리 목록=====//
	@RequestMapping("/admin/admin_lockerhistory.do")
	public ModelAndView lockerhistory(
			@RequestParam(value="pageNum",defaultValue="1") int currentPage,
			@RequestParam(value="keyfield",defaultValue="1") String keyfield) {
		
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("keyfield", keyfield);
		
		//총 글의 개수 또는 검색된 글의 갯수
		int count = adminService.selectLockerRowCount(map);
		logger.debug("<<총 글 갯수>> : " + count);
		
		//페이지 처리
		PagingUtil page = new PagingUtil(keyfield,null,currentPage,count,4,10,"admin_lockerhistory.do");
		
		List<AdminLockerHistoryVO> list = null;
		if(count > 0) {
			map.put("start", page.getStartRow());
			map.put("end", page.getEndRow());
			
			list = adminService.selectLockerList(map);
		}
				
		ModelAndView mav = new ModelAndView();
		mav.setViewName("adminLockerHistory");
		
		//좌석히스토리목록
		mav.addObject("count", count);
		mav.addObject("adminLockerHistoryList", list);
		mav.addObject("page", page.getPage());
		
		return mav;
	}			
}










