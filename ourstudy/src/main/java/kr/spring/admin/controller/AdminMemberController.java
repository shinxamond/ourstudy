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
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import kr.spring.admin.service.AdminMemberService;
import kr.spring.admin.vo.AdminMemberVO;
import kr.spring.util.PagingUtil;

@Controller
public class AdminMemberController {
	private static final Logger logger =
			           LoggerFactory.getLogger(
					     AdminMemberController.class);
	@Autowired
	private AdminMemberService adminMemberService;
	
	//=====현재고객현황판 및 회원목록 관리=====//
	@RequestMapping("/admin/admin_list.do")
	public ModelAndView process(
			@RequestParam(value="pageNum",defaultValue="1") int currentPage,
			@RequestParam(value="keyfield",defaultValue="1") String keyfield, 
			String keyword) {
		
		//현재 고객 현황판
		DecimalFormat df = new DecimalFormat("###,###");
		
		int total1 = adminMemberService.countUsingNum();	
		String usingnum = df.format(total1);
		logger.debug("<<현재 이용중인 회원수  - usingnum>> : " + usingnum);
		
		int total2 = adminMemberService.countTermNum();	
		String periodnum = df.format(total2);
		logger.debug("<<기간권 회원수  - periodnum>> : " + periodnum);
		
		int total3 = adminMemberService.countTimeNum();	
		String timenum = df.format(total3);
		logger.debug("<<시간권 회원수  - timenum>> : " + timenum);
		
		String totalnum = df.format(total2+total3);
		
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("keyfield", keyfield);
		map.put("keyword", keyword);
		
		//총 글의 개수 또는 검색된 글의 갯수
		int count = adminMemberService.selectRowCount(map);
		
		logger.debug("<<회원관리 - count>> : " + count);
		
		//페이지 처리
		PagingUtil page = new PagingUtil(keyfield,keyword,currentPage,count,5,10,"admin_list.do");
		
		List<AdminMemberVO> list = null;
		if(count > 0) {
			map.put("start", page.getStartRow());
			map.put("end", page.getEndRow());
			
			list = adminMemberService.selectList(map);
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
}










