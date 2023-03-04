package kr.spring.ticket.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import kr.spring.ticket.service.TicketService;
import kr.spring.ticket.vo.TicketVO;
import kr.spring.util.PagingUtil;

@Controller
public class TicketController {
	private static final Logger logger = 
			LoggerFactory.getLogger(TicketController.class);

	@Autowired
	private TicketService ticketService;

	//자바빈 초기화
	@ModelAttribute
	public TicketVO initCommand() {
		return new TicketVO();
	}
	
	//이용권 목록
	@RequestMapping("/ticket/study_ticketList.do")
	public ModelAndView process(
			@RequestParam(value="pageNum",defaultValue="1")
			int currentPage,
			String keyfield,
			String keyword) {

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("keyfield", keyfield);
		map.put("keyword", keyword);

		//상품의 총 개수 또는 검색된 상품의 개수
		int count = ticketService.selectTicketCount(map);

		//페이지 처리
		PagingUtil page = new PagingUtil(keyfield, keyword,
				currentPage, count, 20, 10, "list.do");

		List<TicketVO> ticket = null;
		if(count > 0) {	
			map.put("start", page.getStartRow());
			map.put("end", page.getEndRow());

			ticket = ticketService.selectTicketList(map);
		}

		ModelAndView mav = new ModelAndView();
		mav.setViewName("study_ticketList");
		mav.addObject("count", count);
		mav.addObject("ticket", ticket);
		mav.addObject("page", page.getPage());


		return mav;
		
	}
	
	
	
}



