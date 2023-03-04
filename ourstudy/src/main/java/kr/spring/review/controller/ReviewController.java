package kr.spring.review.controller;

import java.util.Collections;
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
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
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
	
	private int rowCount = 3;
	
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
		logger.debug("<<r_num>> : " + r_num);
		
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
	//수정 폼 호출
	@GetMapping("/review/update.do")
	public String formUpdate(@RequestParam int r_num, Model model) {
		ReviewVO reviewVO = reviewService.selectReview(r_num);
		
		model.addAttribute("reviewVO",reviewVO);
		
		return "reviewModify";
	}	
	
	//수정 폼에서 전송된 데이터 처리
	@PostMapping("/review/update.do")
	public String submitUpdate(@Valid ReviewVO reviewVO, BindingResult result,
			HttpServletRequest request, Model model) {
		
		logger.debug("<<글수정>> : " + reviewVO);
		logger.debug("<<업로드 파일 용량>> : " + reviewVO.getR_img().length);

		if(reviewVO.getR_img().length > 5*1024*1024) {//5MB
			result.reject("limitUploadSize",new Object[]{"5MB"},null);
		}
		
		//유효성 체크 결과 오류가 있으면 폼을 호출
		if(result.hasErrors()) {
			//title 또는 content가 입력되지 않아서 유효성
			//체크에 걸리면 파일 정보를 잃어버리기 때문에
			//폼을 호출할 때 파일 정보를 다시 셋팅
			ReviewVO vo = reviewService.selectReview(reviewVO.getR_num());
			reviewVO.setR_imgname(vo.getR_imgname());
			return "reviewModify";
		}
		
		//글수정
		reviewService.updateReview(reviewVO);
		
		//View에 표시할 메시지
		model.addAttribute("message", "글수정 완료!");
		model.addAttribute("url", request.getContextPath()+"/review/detail.do?r_num="+reviewVO.getR_num());
		
		return "common/resultView";
	}	
		
	//=====이용후기 글삭제=======//
	@RequestMapping("/review/delete.do")
	public String submitDelete(@RequestParam int r_num, Model model, HttpServletRequest request) {
		
		logger.debug("<<이용후기 글삭제>> : " + r_num);
		
		//글삭제
		reviewService.deleteReview(r_num);
		
		return "redirect:/review/list.do";
	}	
	
	//=====파일 다운로드====//
	@RequestMapping("/review/file.do")
	public ModelAndView download(
			         @RequestParam int r_num) {
		ReviewVO review = reviewService.selectReview(r_num);
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("downloadView");
		mav.addObject("downloadFile", review.getR_img());
		mav.addObject("filename", review.getR_imgname());
		
		return mav;
	}

	//=====이용후기 이미지 출력=====//
	@RequestMapping("/review/imageView.do")
	public ModelAndView viewImage(
			        @RequestParam int r_num,
			        @RequestParam int review_type) {
		
		ReviewVO review = reviewService.selectReview(r_num);
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("imageView");
		
		/*
		if(review_type==1) {//프로필 사진
			mav.addObject("imageFile",review.getPhoto());
			mav.addObject("filename", review.getPhoto_name());
		}
		*/
		if(review_type==2) {//업로드된 이미지
			mav.addObject("imageFile", review.getR_img());
			mav.addObject("filename", review.getR_imgname());
		}
		return mav;
	}

	//=====이용후기 이미지 삭제=======//
	@RequestMapping("/review/deleteFile.do")
	@ResponseBody
	public Map<String,String> processFile(int r_num, HttpSession session){
		Map<String,String> mapJson = new HashMap<String,String>();
		
		MemberVO user = (MemberVO)session.getAttribute("user");
		if(user==null) {
			mapJson.put("result", "logout");
		}else {
			reviewService.deleteFile(r_num);
			
			mapJson.put("result", "success");
		}
		
		return mapJson;
	}	
	
	//========댓글 등록==========//
	@RequestMapping("/review/writeReply.do")
	@ResponseBody
	public Map<String,String> writeReply(ReviewReplyVO vo,
			               HttpSession session, HttpServletRequest request){
		
		logger.debug("<<댓글 등록>> : " + vo);
		
		Map<String,String> mapJson = new HashMap<String,String>();
		
		MemberVO user = (MemberVO)session.getAttribute("user");
		if(user==null) {
			//로그인 안 됨
			mapJson.put("result","logout");
		}else {
			//회원번호 등록
			vo.setMem_num(user.getMem_num());
			//댓글 등록
			reviewService.insertReply(vo);
			mapJson.put("result", "success");
		}
		return mapJson;
	}

	//======댓글 목록========//
	@RequestMapping("/review/listReply.do")
	@ResponseBody
	public Map<String,Object> getList(@RequestParam(value="pageNum",defaultValue="1")int currentPage, 
			@RequestParam int r_num, HttpSession session){
		
		logger.debug("<<currentPage>> : " + currentPage);
		logger.debug("<<review_num>> : " + r_num);
		
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("r_num", r_num);
		
		//총 글의 개수
		int count = reviewService.selectRowCountReply(map);
		
		//페이지 처리
		PagingUtil page = new PagingUtil(currentPage,count,rowCount,1,null);
		map.put("start", page.getStartRow());
		map.put("end", page.getEndRow());
		
		//목록 데이터 읽기
		List<ReviewReplyVO> list = null;
		if(count > 0) {
			list = reviewService.selectListReply(map);
		}else {
			list = Collections.emptyList();
		}
		
		Map<String,Object> mapJson = new HashMap<String,Object>();
		mapJson.put("count", count);
		mapJson.put("rowCount", rowCount);
		mapJson.put("list", list);
		
		//===== 로그인 한 회원정보 셋팅 =====//
		MemberVO user = (MemberVO)session.getAttribute("user");
		if(user!=null) {
			mapJson.put("user_num", user.getMem_num());
		}	
		
		return mapJson;
	}
	
	//==========댓글수정==========//
	@RequestMapping("/review/updateReply.do")
	@ResponseBody
	public Map<String,String> modifyReply(ReviewReplyVO reviewReplyVO, 
			        HttpSession session, HttpServletRequest request){
		
		logger.debug("<<댓글수정>> : " + reviewReplyVO);
		
		Map<String,String> mapJson = new HashMap<String,String>();
		
		MemberVO user = (MemberVO)session.getAttribute("user");
		ReviewReplyVO db_reply = reviewService.selectReply(reviewReplyVO.getRevw_num());
		if(user==null) {
			//로그인이 안 되어있는 경우
			mapJson.put("result", "logout");
		}else if(user!=null && 
				user.getMem_num()==db_reply.getMem_num()) {
			//로그인 회원번호와 작성자 회원번호 일치
	
			//댓글 수정
			reviewService.updateReply(reviewReplyVO);
			mapJson.put("result", "success");			
		}else {
			//로그인 회원번호와 작성자 회원번호 불일치
			mapJson.put("result", "wrongAccess");
		}
		
		return mapJson;
	}
	
	//======댓글 삭제========//
	@RequestMapping("/review/deleteReply.do")
	@ResponseBody
	public Map<String,String> deleteReply(@RequestParam int revw_num, HttpSession session){
		logger.debug("<<댓글 삭제>> : " + revw_num);
		
		Map<String,String> mapJson = new HashMap<String,String>();
		
		MemberVO user = (MemberVO)session.getAttribute("user");
		ReviewReplyVO db_reply = reviewService.selectReply(revw_num);
		if(user==null) {
			//로그인이 되어있지 않음
			mapJson.put("result", "logout");
		}else if(user!=null && 
			user.getMem_num()==db_reply.getMem_num()) {
			//로그인한 회원번호와 작성자 회원번호 일치
			reviewService.deleteReply(revw_num);
			mapJson.put("result", "success");
		}else {
			//로그인한 회원번호와 작성자 회원번호 불일치
			mapJson.put("result", "wrongAccess");
		}
		
		return mapJson;
	}
}
