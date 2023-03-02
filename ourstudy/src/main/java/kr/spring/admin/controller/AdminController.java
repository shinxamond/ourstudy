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
import kr.spring.admin.vo.AdminItemHistoryVO;
import kr.spring.admin.vo.AdminLockerHistoryVO;
import kr.spring.admin.vo.AdminMemberVO;
import kr.spring.admin.vo.AdminSalesVO;
import kr.spring.admin.vo.AdminSeatHistoryVO;
import kr.spring.admin.vo.AdminTalkHistoryVO;
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

	@ModelAttribute("AdminItemHistoryVO")
	public AdminLockerHistoryVO initCommand4() {
		return new AdminLockerHistoryVO();
	}

	@ModelAttribute("AdminSalesVO")
	public AdminSalesVO initCommand5() {
		return new AdminSalesVO();
	}
	
	@ModelAttribute("AdminTalkHistoryVO")
	public AdminTalkHistoryVO initCommand6() {
		return new AdminTalkHistoryVO();
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
		
		int total2 = adminService.countGoOutNum();	
		String gooutnum = df.format(total2);
		
		int total3 = adminService.countTermNum();	
		String periodnum = df.format(total3);
		
		int total4 = adminService.countTimeNum();	
		String timenum = df.format(total4);
		
		
		String totalnum = df.format(total3+total4);
		
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
		mav.addObject("gooutnum", gooutnum);
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
		
		//좌석 히스토리목록
		mav.addObject("count", count);
		mav.addObject("adminLockerHistoryList", list);
		mav.addObject("page", page.getPage());
		
		return mav;
	}
	
	//=====물품대여 히스토리 목록=====//
	@RequestMapping("/admin/admin_itemhistory.do")
	public ModelAndView itemhistory(
			@RequestParam(value="pageNum",defaultValue="1") int currentPage,
			@RequestParam(value="keyfield",defaultValue="1") String keyfield, 
			String keyword) {
		
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("keyfield", keyfield);
		map.put("keyword", keyword);
		
		//총 글의 개수 또는 검색된 글의 갯수
		int count = adminService.selectItemRowCount(map);
		logger.debug("<<총 글 갯수>> : " + count);
		
		//페이지 처리
		PagingUtil page = new PagingUtil(keyfield,keyword,currentPage,count,4,10,"admin_itemhistory.do");
		
		List<AdminItemHistoryVO> list = null;
		if(count > 0) {
			map.put("start", page.getStartRow());
			map.put("end", page.getEndRow());
			
			list = adminService.selectItemList(map);
		}
				
		ModelAndView mav = new ModelAndView();
		mav.setViewName("adminItemHistory");
		
		//물품대여 히스토리목록
		mav.addObject("count", count);
		mav.addObject("adminItemHistoryList", list);
		mav.addObject("page", page.getPage());
		
		return mav;
	}
	
	//=====미반납자 목록=====//
	@RequestMapping("/admin/admin_unreturnlist.do")
	public ModelAndView unreturnlist(
			@RequestParam(value="pageNum",defaultValue="1") int currentPage,
			@RequestParam(value="keyfield",defaultValue="1") String keyfield, 
			String keyword) {
		
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("keyfield", keyfield);
		map.put("keyword", keyword);
		
		//총 글의 개수 또는 검색된 글의 갯수
		int count = adminService.selectUnreturnRowCount(map);
		logger.debug("<<총 글 갯수>> : " + count);
		
		//페이지 처리
		PagingUtil page = new PagingUtil(keyfield,keyword,currentPage,count,4,10,"admin_unreturnlist.do");
		
		List<AdminItemHistoryVO> list = null;
		if(count > 0) {
			map.put("start", page.getStartRow());
			map.put("end", page.getEndRow());
			
			list = adminService.selectUnreturnList(map);
		}
				
		ModelAndView mav = new ModelAndView();
		mav.setViewName("adminUnreturnList");
		
		//미반납자 히스토리목록
		mav.addObject("count", count);
		mav.addObject("adminUnreturnList", list);
		mav.addObject("page", page.getPage());
		
		return mav;
	}	
	
	//=====일별판매정산판 및 판매기록목록 관리=====//
	@RequestMapping("/admin/admin_saleslist.do")
	public ModelAndView saleslist(
			@RequestParam(value="pageNum",defaultValue="1") int currentPage,
			@RequestParam(value="keyfield",defaultValue="1") String keyfield, 
			String keyword) {
		
		//현재 고객 현황판
		DecimalFormat df = new DecimalFormat("###,###");
		
		int total1 = adminService.ticketSalesSum();	
		String ticketsales = df.format(total1);
		
		int total2 = adminService.lockerSalesSum();	
		String lockersales = df.format(total2);
		
		String totalsales = df.format(total1+total2);
		
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("keyfield", keyfield);
		map.put("keyword", keyword);
		
		//총 글의 개수 또는 검색된 글의 갯수
		int count = adminService.selectSalesRowCount(map);
		logger.debug("<<총 판매기록 목록 갯수>> : " + count);
		
		//페이지 처리
		PagingUtil page = new PagingUtil(keyfield,keyword,currentPage,count,4,10,"admin_saleslist.do");
		
		List<AdminSalesVO> list = null;
		if(count > 0) {
			map.put("start", page.getStartRow());
			map.put("end", page.getEndRow());
			
			list = adminService.selectSalesList(map);
		}
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("adminSalesList");
		
		//일별판매정산판
		mav.addObject("ticketsales", ticketsales);
		mav.addObject("lockersales", lockersales);
		mav.addObject("totalsales", totalsales);
		
		//판매기록목록
		mav.addObject("count", count);
		mav.addObject("adminSalesList", list);
		mav.addObject("page", page.getPage());
		
		return mav;
	}
	
	//=====수신 채팅 히스토리 목록=====//
	@RequestMapping("/admin/admin_receivehistory.do")
	public ModelAndView receivehistory(
			@RequestParam(value="pageNum",defaultValue="1") int currentPage,
			@RequestParam(value="keyfield",defaultValue="1") String keyfield, 
			String keyword) {
		
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("keyfield", keyfield);
		map.put("keyword", keyword);
		
		//총 글의 개수 또는 검색된 글의 갯수
		int count = adminService.selectReceiveRowCount(map);
		logger.debug("<<총 수신 채팅 갯수>> : " + count);
		
		//페이지 처리
		PagingUtil page = new PagingUtil(keyfield,keyword,currentPage,count,4,10,"admin_receivehistory.do");
		
		List<AdminTalkHistoryVO> list = null;
		if(count > 0) {
			map.put("start", page.getStartRow());
			map.put("end", page.getEndRow());
			
			list = adminService.selectReceiveList(map);
		}
				
		ModelAndView mav = new ModelAndView();
		mav.setViewName("adminReceiveHistory");
		
		//좌석히스토리목록
		mav.addObject("count", count);
		mav.addObject("adminReceiveList", list);
		mav.addObject("page", page.getPage());
		
		return mav;
	}
}










