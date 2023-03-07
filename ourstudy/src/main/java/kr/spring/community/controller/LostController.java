package kr.spring.community.controller;

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

import kr.spring.community.service.LostService;
import kr.spring.community.vo.LostReplyVO;
import kr.spring.community.vo.LostVO;
import kr.spring.info.controller.InformationController;
import kr.spring.member.vo.MemberVO;
import kr.spring.util.PagingUtil;
import kr.spring.util.StringUtil;

@Controller
public class LostController {
	private static final Logger logger =
			LoggerFactory.getLogger(InformationController.class);
	
	private int rowCount = 3;
	
	@Autowired
	private LostService lostService;
	
	//자바빈(VO) 초기화
		@ModelAttribute
		public LostVO initCommand1() {
			return new LostVO();
		}
		@ModelAttribute
		public LostReplyVO initCommand2() {
			return new LostReplyVO();			
		}
		
	//==분실물 게시판 글목록
		@RequestMapping("/community/lostList.do")
		public ModelAndView process(
				 @RequestParam(value="pageNum",defaultValue="1") int currentPage,
				 @RequestParam(value="keyfield",defaultValue="1") String keyfield, String keyword) {
					
				Map<String,Object> map = 
							new HashMap<String,Object>();
				map.put("keyfield", keyfield);
				map.put("keyfield", keyword);
				
				//글의 총개수 또는 검색된 글의 개수
				int count = lostService.selectRowCount(map);
				logger.debug("<<count>> : " + count);
				
				//페이지 처리
				PagingUtil page = new PagingUtil(keyfield,keyword,
						 currentPage,count,10,10,"lostList.do");
				
				map.put("start", page.getStartRow());
				map.put("end", page.getEndRow());
				
				
				List<LostVO> list = null;
				if(count > 0) {
					map.put("start", page.getStartRow());
					map.put("end", page.getEndRow());
					
					list = lostService.selectList(map);
				}
				ModelAndView mav = new ModelAndView();
				mav.setViewName("lostList");
				mav.addObject("count",count);
				mav.addObject("lostList",list);
				mav.addObject("page",page.getPage());
				
				return mav;
		}
		
//분실물
	//==분실물 글쓰기 
	//등록 폼 호출
	@GetMapping("/community/lostWrite.do")
	public String form() {
		return "lostWrite";
	}
	
	//등록 폼에서 전송된 데이터 처리
	@PostMapping("/community/lostWrite.do")
		public String submit(@Valid LostVO lostVO, BindingResult result, Model model,
				HttpServletRequest request, RedirectAttributes redirect, HttpSession session) {
			
		logger.debug("<<분실물 글쓰기>> : " + lostVO);
				
		//유효성 체크 결과 오류가 있으면 폼을 호출
		if(result.hasErrors()) {
					return form();
		}
		
		MemberVO user = (MemberVO)session.getAttribute("user");
		lostVO.setMem_num(user.getMem_num());
		
		//글쓰기	
		lostService.insertLost(lostVO);
		
		model.addAttribute("message", "등록 되었습니다.");
		model.addAttribute("url", request.getContextPath()+"/community/lostList.do");
		return "common/resultView";
	}
	
	//==글상세
	 @GetMapping("/community/lostDetail.do")
	 public ModelAndView process(@RequestParam int lf_num) {
		 
		 logger.debug("<<lf_num>> : " + lf_num);
		 
		 LostVO lost =
				 lostService.selectLost(lf_num);
		 
		lost.setLf_title(StringUtil.useNoHtml(lost.getLf_title()));

		 
		 return new ModelAndView("lostView","lost",lost); 
	 }
	
	//==글수정
	//수정 폼 
	 @GetMapping("/community/lostUpdate.do") 
	 public String formUpdate(@RequestParam int lf_num, Model model) { 
			LostVO lostVO = lostService.selectLost(lf_num);
			model.addAttribute("lostVO",lostVO);
			
			logger.debug("<<lostVO>> : " + lostVO);
			return "lostModify";
	}
	 
	 //폼에서 전송된 데이터 처리
	 @PostMapping("/community/lostUpdate.do")
	 public String submitUpdate(@Valid LostVO lostVO, BindingResult result,
				HttpServletRequest request, Model model) {
			
			logger.debug("<<글수정>> : " + lostVO);
		
			if(result.hasErrors()) {
				
				return "lostModify";
			}		
			
			//글수정 
			lostService.updateLost(lostVO);
			
			//View에 표시할 메시지
			model.addAttribute("message", "수정 되었습니다.");
			model.addAttribute("url", request.getContextPath()+"/community/lostList.do");
			
			return "common/resultView";
			
		}
	
	 //==글삭제
	 @RequestMapping("/community/lostDelete.do")
		public String submitDelete(@RequestParam int lf_num,Model model,
				HttpServletRequest request) {
			logger.debug("<<글삭제>> : " + lf_num);
			
			lostService.deleteLost(lf_num);
			
			return "redirect:/community/lostList.do";
		}
		
		
	 
	 	//댓글!
	 	//==댓글 등록 
	 	@RequestMapping("/community/writelfReply.do")
	 	@ResponseBody
	 	public Map<String,String> writeReply(LostReplyVO lost,
	               HttpSession session, HttpServletRequest request){

			logger.debug("<<댓글 등록>> : " + lost);
			
			Map<String,String> mapJson = new HashMap<String,String>();
			
			MemberVO user = (MemberVO)session.getAttribute("user");
			if(user==null) {
				//로그인 안 됨
				mapJson.put("result","logout");
			}else {
				//회원번호 등록
				lost.setMem_num(user.getMem_num());
				//댓글 등록
				lostService.insertLostReply(lost);
				mapJson.put("result", "success");
			}
			return mapJson;
			}
	 	
	 	//==댓글 목록 
	 	@RequestMapping("/community/listlfReply.do")
		@ResponseBody
		public Map<String,Object> getList(@RequestParam(value="pageNum",defaultValue="1") int currentPage, 
				@RequestParam int lf_num, HttpSession session){
			
			logger.debug("<<currentPage>> : " + currentPage);
			logger.debug("<<lost_num>> : " + lf_num);
			
			Map<String,Object> map = new HashMap<String,Object>();
			map.put("lf_num", lf_num);
			
			//총 글의 개수
			int count = lostService.selectRowCountLostReply(map);
			
			//페이지 처리
			PagingUtil page = new PagingUtil(currentPage,count,rowCount,1,null);
			map.put("start", page.getStartRow());
			map.put("end", page.getEndRow());
			
			//목록 데이터 읽기
			List<LostReplyVO> list = null;
			if(count > 0) {
				list = lostService.selectListLostReply(map);
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
	 	
	 	
	 	//==댓글 수정 
	 	@RequestMapping("/community/updatelfReply.do")
		@ResponseBody
		public Map<String,String> modifyReply(LostReplyVO lostReplyVO, 
				        HttpSession session, HttpServletRequest request){
			
			logger.debug("<<댓글수정>> : " + lostReplyVO);
			
			Map<String,String> mapJson = new HashMap<String,String>();
			
			MemberVO user = (MemberVO)session.getAttribute("user");
			LostReplyVO db_reply = lostService.selectLostReply(lostReplyVO.getRe_num());
			if(user==null) {
				//로그인이 안 되어있는 경우
				mapJson.put("result", "logout");
			}else if(user!=null && 
					user.getMem_num()==db_reply.getMem_num()) {
				//로그인 회원번호와 작성자 회원번호 일치
		
				//댓글 수정
				lostService.updateLostReply(lostReplyVO);
				mapJson.put("result", "success");			
			}else {
				//로그인 회원번호와 작성자 회원번호 불일치
				mapJson.put("result", "wrongAccess");
			}
			
			return mapJson;
		}
	 	//==댓글 삭제
	 	@RequestMapping("/community/deletelfReply.do")
		@ResponseBody
		public Map<String,String> deleteLostReply(@RequestParam int re_num, HttpSession session){
			logger.debug("<<댓글 삭제>> : " + re_num);
			
			Map<String,String> mapJson = new HashMap<String,String>();
			
			MemberVO user = (MemberVO)session.getAttribute("user");
			LostReplyVO db_reply = lostService.selectLostReply(re_num);
			if(user==null) {
				//로그인이 되어있지 않음
				mapJson.put("result", "logout");
			}else if(user!=null && 
				user.getMem_num()==db_reply.getMem_num()) {
				//로그인한 회원번호와 작성자 회원번호 일치
				lostService.deleteLostReply(re_num);
				mapJson.put("result", "success");
			}else {
				//로그인한 회원번호와 작성자 회원번호 불일치
				mapJson.put("result", "wrongAccess");
			}
			
			return mapJson;
		}
}
