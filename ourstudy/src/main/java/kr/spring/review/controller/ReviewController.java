package kr.spring.review.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.spring.member.vo.MemberVO;
import kr.spring.review.service.ReviewService;
import kr.spring.review.vo.ReviewReplyVO;
import kr.spring.review.vo.ReviewVO;
import kr.spring.util.PagingUtil;
import kr.spring.util.StringUtil;

@Controller
public class ReviewController {
	private static final Logger logger = 
            LoggerFactory.getLogger(
	          ReviewController.class);
	
	private int rowCount = 10;
	
	@Autowired
	private ReviewService reviewService;
	
	//자바빈(VO) 초기화
	@ModelAttribute
	public ReviewVO initCommand1() {
		return new ReviewVO();			
	}
	@ModelAttribute
	public ReviewReplyVO initCommand2() {
		return new ReviewReplyVO();			
	}	
	
	//=======이용후기 글목록=========//
	@RequestMapping("/review/list.do")
	public ModelAndView process(
		@RequestParam(value="pageNum",defaultValue="1") int currentPage, 
		@RequestParam(value="keyfield",defaultValue="1") String keyfield, String keyword) {

		Map<String,Object> map = 
				new HashMap<String,Object>();
		map.put("keyfield", keyfield);
		map.put("keyword", keyword);
		
		//글의 총개수 또는 검색된 글의 개수
		int count = reviewService.selectRowCount(map);
		
		logger.debug("<<count>> : " + count);
		
		//페이지 처리
		PagingUtil page = new PagingUtil(keyfield,keyword,currentPage,count,5,10,"list.do");
				
		List<ReviewVO> list = null;
		if(count > 0) {
			map.put("start", page.getStartRow());
			map.put("end", page.getEndRow());
			
			list = reviewService.selectList(map);
		}
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("reviewList");
		mav.addObject("count", count);
		mav.addObject("list", list);
		mav.addObject("page", page.getPage());
		
		return mav;
	}
	
	//=======이용후기 글쓰기=========//
	//등록 폼 호출
	@GetMapping("/review/write.do")
	public String form() {
		return "reviewWrite";
	}	

	//등록 폼에서 전송된 데이터 처리
	@PostMapping("/review/write.do")
	public String submit(@Valid ReviewVO reviewVO, BindingResult result,
			      HttpServletRequest request, RedirectAttributes redirect, HttpSession session) {
		
		logger.debug("<<업로드 파일 용량>> : " + reviewVO.getR_img().length);
		
		if(reviewVO.getR_img().length > 5*1024*1024) {//5MB
			result.reject("limitUploadSize",new Object[]{"5MB"},null);
		}
		
		//유효성 체크 결과 오류가 있으면 폼을 호출
		if(result.hasErrors()) {
			return form();
		}
		
		//회원번호 셋팅
		reviewVO.setMem_num(
			((MemberVO)session.getAttribute("user")).getMem_num());

		//글쓰기
		reviewService.insertReview(reviewVO);
		
		//RedirectAttributes 객체는 리다이렉트 시점에 한 번만 사용되는 데이터를 전송.
		//브라우저에 데이터를 전송하지만 URL상에 보이지 않는 숨겨진 데이터의 형태로 전달
		redirect.addFlashAttribute("result","success");
		
		return "redirect:/review/list.do";
	}
	
	//========이용후기 글상세=======//
	@RequestMapping("/review/detail.do")
	public ModelAndView process(@RequestParam int r_num) {
		logger.debug("<<review_num>> : " + r_num);
		
		ReviewVO review = reviewService.selectReview(r_num);
		
		//제목에 태그를 허용하지 않음
		review.setR_title(StringUtil.useNoHtml(review.getR_title()));
		
		//내용에 태그를 허용하지 않음
		//CKEditor 사용시 주석 처리
		//review.setContent(StringUtil.useBrNoHtml(review.getContent()));
		                         //뷰이름       속성명	   속성값
		return new ModelAndView("reviewView","review",review);
	}
	
	//=====이용후기 글수정=====//
	
	//=====이용후기 글삭제=======//
	
	//=====이용후기 이미지 삭제=====//
	
	//=====이용후기 이미지 출력=====//
	
	//========댓글 등록==========//
	
	//======댓글 목록========//
	
	//==========댓글수정==========//
	
	//======댓글 삭제========//
}
