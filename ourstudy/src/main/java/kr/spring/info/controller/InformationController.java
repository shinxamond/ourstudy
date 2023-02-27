package kr.spring.info.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import kr.spring.info.vo.InformationVO;
import kr.spring.info.service.InformationService;

import kr.spring.util.PagingUtil;


@Controller
public class InformationController {
	private static final Logger logger =
			LoggerFactory.getLogger(InformationController.class);
	
	//private int rowCount = 10;
	
	@Autowired
	private InformationService informationService;
	
	//자바빈(VO) 초기화
	@ModelAttribute
	public InformationVO initCommand() {
		return new InformationVO();
	}
		
	//==안내사항 게시판 글목록
	@RequestMapping("/info/informationList.do")
	public ModelAndView process(
			 @RequestParam(value="pageNum",defaultValue="1") 
			    int currentPage,String keyfield,String keyword) {
				
			Map<String,Object> map = 
						new HashMap<String,Object>();
			map.put("keyfield", keyfield);
			map.put("keyword", keyword);
			
			//글의 총개수 또는 검색된 글의 개수
			int count = informationService.selectinfoRowCount(map);
			logger.debug("<<count>> : " + count);
			
			//페이지 처리
			PagingUtil page = 
					new PagingUtil(keyfield,keyword,
					 currentPage,count,20,10,"informationList.do");
			
			List<InformationVO> list = null;
			if(count > 0) {
				map.put("start", page.getStartRow());
				map.put("end", page.getEndRow());
				
				list = informationService.selectInfoList(map);
			}
			ModelAndView mav = new ModelAndView();
			mav.setViewName("informationList");
			mav.addObject("count",count);
			mav.addObject("informationList",list);
			mav.addObject("page",page.getPage());
			
			return mav;
	}
	
	//==글쓰기
	//등록 폼 호출
	@GetMapping("/info/infoWrite.do")
	public String form() {
		return "informationWrite";
	}
	
	//등록 폼에서 전송된 데이터 처리
	@PostMapping("/info/informationWrite.do")
	public String submit(@Valid InformationVO informationVO, BindingResult result, Model model) {
		logger.debug("<<게시판 글쓰기>> : " + informationVO);
		//유효성 체크 결과 오류가 있으면 폼을 호출
				if(result.hasErrors()) {
					return form();
				}
		//글쓰기	
		informationService.insertInformation(informationVO);
		
		return "redirect:/info/informationList.do";
	}
	
	//==글상세
	/*
	 * @RequestMapping("/info/infoView.do") public ModelAndView process(
	 * 
	 * @RequestParam int info_num) { logger.debug("<<info_num>> : " + info_num);
	 * 
	 * return new ModelAndView("informationView","information",info); }
	 */
	//==글수정
	//수정 폼 호출
	@GetMapping("/info/infoModify.do")
	public String infoModify(
	          @RequestParam int info_num,Model model) {
		InformationVO informationVO= informationService.selectInformation(info_num);
		
		model.addAttribute("informationVO", informationVO);
		return "informationModify";	
	}
	
	//폼에서 전송된 데이터 처리
	public String submitUpdate(@Valid InformationVO informationVO,
			BindingResult result,
			Model model,
			HttpServletRequest request) {
		logger.debug("<<안내사항 수정>> : " + informationVO);
		
		informationService.updateInformation(informationVO);

	
		model.addAttribute("message", "수정 완료되었습니다");
		model.addAttribute("url", request.getContextPath()
				+"/info/informationView.do?info_num"+informationVO.getInfo_num());
		return "common/resultView";
	}
	

	
	
	//==글삭제
	@RequestMapping("/info/infoDelete.do")
	public String submitDelete(@RequestParam int info_num,Model model,
			HttpServletRequest request) {
		logger.debug("<<안내사항 글삭제>> : " + info_num);
		
		informationService.deleteInformation(info_num);
		
		return "redirect:/info/informationList.do";
	}
	
	
	
	
}
