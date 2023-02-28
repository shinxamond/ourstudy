package kr.spring.mypage.controller;

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

import kr.spring.util.AuthCheckException;
import kr.spring.util.FileUtil;
import kr.spring.util.PagingUtil;
import kr.spring.member.service.MemberService;
import kr.spring.member.vo.MemberVO;
import kr.spring.mypage.service.MypageService;
import kr.spring.point.vo.PointVO;
import kr.spring.seat.vo.SeatVO;

@Controller
public class MypageController {
	private static final Logger logger = LoggerFactory.getLogger(MypageController.class);
	
	//자바빈(VO) 초기화
	@ModelAttribute
	public PointVO initCommand() {
		return new PointVO();
	}
	@ModelAttribute
	public MemberVO initCommand1() {
		return new MemberVO();
	}
	@Autowired
	private MypageService mypageService;
	@Autowired
	private MemberService memberService;
	
	//마이페이지 메인 호출
	@RequestMapping("/mypage/myPageMain.do")
	public String form(HttpSession session, Model model) {
		
		//회원 기본 정보 세팅
		MemberVO user = (MemberVO)session.getAttribute("user");
		
		MemberVO member = mypageService.selectMember(user.getMem_num());
		
		SeatVO seat = mypageService.selectCurSeat(user.getMem_num());
		
		logger.debug("<<마이페이지 멤버 정보>> : " + member);
		
		model.addAttribute("member", member);
		model.addAttribute("seat", seat);
		
		return "myPageMain"; //타일스 설정값
	}
	
	//회원정보 수정 폼 호출
	@RequestMapping("/mypage/myPageModify.do")
	public String myPageModifyForm(HttpSession session, Model model) {
		
		MemberVO user = (MemberVO)session.getAttribute("user");
		
		MemberVO member = (MemberVO)mypageService.selectMember(user.getMem_num());
		
		SeatVO seat = mypageService.selectCurSeat(user.getMem_num());
		
		model.addAttribute("member", member);
		model.addAttribute("seat", seat);
		
		return "myPageModify";
	}
	//수정폼에서 받은 데이터 처리
	@PostMapping("/mypage/myPageModify.do")
	public String submitMypageUpdate(@Valid MemberVO member, BindingResult result, HttpSession session) {
		
		
		logger.debug("<<회원정보수정 처리>> : " + member);
		if(result.hasErrors()) {
			return "myPageModify";
		}
		
		MemberVO user = (MemberVO)session.getAttribute("user");
		
		member.setMem_num(user.getMem_num());
		
		mypageService.updateMember_detail(member);
		
		return "redirect:/mypage/myPageMain.do";
		
	}
	
	//비밀번호 변경 폼 호출
	@GetMapping("/mypage/myPagechangePasswd.do")
	public String myPageChangePasswdForm(HttpSession session, Model model) {
		
		MemberVO user = (MemberVO)session.getAttribute("user");
		
		MemberVO member = (MemberVO)mypageService.selectMember(user.getMem_num());
		
		SeatVO seat = mypageService.selectCurSeat(user.getMem_num());
		
		model.addAttribute("member", member);
		model.addAttribute("seat", seat);
		
		return "myPagechangePasswd";
	}
	
	//비밀번호 변경 폼에서 받은 데이터 처리
	@PostMapping("/mypage/myPagechangePasswd.do")
	public String submitMypageChangePasswd(@Valid MemberVO member, BindingResult result, HttpSession session, Model model, HttpServletRequest request) {
		
		
		
		if(result.hasFieldErrors("now_passwd") || result.hasFieldErrors("mem_pw")) {
			
			return myPageChangePasswdForm(session, model);
		}
		
		//세션에서 user 정보 불러오기
		MemberVO user = (MemberVO)session.getAttribute("user");
		
		member.setMem_num(user.getMem_num());
		
		//user 번호로 db에 저장된 비밀번호 확인을 위해 member 정보 불러오기
		MemberVO db_member = mypageService.selectMember(member.getMem_num());
		
		//비밀번호 변경 폼에서 받아 member에 저장된 mem_pw(새비밀번호), now_passwd(원래비밀번호) 따로 저장
		String np = member.getMem_pw();
		String op = member.getNow_passwd();
		
		//변경 후 마이페이지 메인에서 필요한 나머지 정보 member에 담아주기
		member = (MemberVO)mypageService.selectMember(user.getMem_num());
		
		//user정보로 불러와서 mem_pw는 현재비밀번호, now_passwd는 null이 됐으므로 다시 세팅해주기
		member.setMem_pw(np);
		member.setNow_passwd(op);		
		
		if(!db_member.getMem_pw().equals(member.getNow_passwd())) {
			result.rejectValue("now_passwd", "invalidPassword");
			
			return myPageChangePasswdForm(session, model);
		}
		
		logger.debug("<<변경폼 이후 멤버 정보>> : " + member);
		
		mypageService.updatePassword(member);
		
		memberService.deleteAuto_id(member.getMem_num());
		
		model.addAttribute("message", "비밀번호가 변경되었습니다(재접속 시 설정되어 있는 자동 로그인 기능이 해제됩니다).");
		model.addAttribute("url", request.getContextPath() + "/mypage/myPageMain.do");
		
		return "common/resultView";
		
	}
	
	//회원탈퇴 폼 호출
	@GetMapping("/mypage/myPagedeleteMember.do")
	public String myPageDeleteMemberForm(HttpSession session, Model model) {
		MemberVO user = (MemberVO)session.getAttribute("user");
		
		MemberVO member = (MemberVO)mypageService.selectMember(user.getMem_num());
		
		SeatVO seat = mypageService.selectCurSeat(user.getMem_num());
		
		model.addAttribute("member", member);
		model.addAttribute("seat", seat);
		
		return "myPagedeleteMember";
	}
	
	//회원탈퇴 폼에서 전송받은 데이터 처리
	@PostMapping("/mypage/myPagedeleteMember.do")
	public String submitMypageDeleteMember(@Valid MemberVO member, BindingResult result, HttpSession session, Model model) {
		
		if(result.hasFieldErrors("mem_id") || result.hasFieldErrors("mem_pw")) {
			return myPageDeleteMemberForm(session, model);
		}
		
		MemberVO user = (MemberVO)session.getAttribute("user");
		MemberVO db_member = mypageService.selectMember(user.getMem_num());
		
		boolean check = false;
		
		try {
			if(db_member != null && db_member.getMem_id().equals(member.getMem_id())) {
				check = db_member.isCheckedPassword(member.getMem_pw());
			}
			
			if(check) {
				mypageService.deleteMember(user.getMem_num());
				
				session.invalidate();
				
				model.addAttribute("accessMsg", "회원탈퇴가 완료되었습니다.");
				
				return "common/notice";
			}
			
			throw new AuthCheckException();
		}catch(AuthCheckException e) {
			result.reject("invalidIdOrPassword");
			
			return myPageDeleteMemberForm(session, model);
		}
	}
	
	//포인트 목록
	@GetMapping("/mypage/pointList.do")
	public String pointList() {
		return "pointList";
	}
	/*
	 * @RequestMapping("/mypage/pointList.do") public ModelAndView pointList() {
	 * 
	 * }
	 */
	
	//공부시간 목록
	@RequestMapping("/mypage/studyTimeList.do")
	public ModelAndView studyTimeList(@RequestParam(value = "pageNum", defaultValue = "1") int currentPage, @RequestParam(value = "keyfield", defaultValue = "1") String keyfield , HttpSession session, Model model) {
		
		ModelAndView mav = new ModelAndView();
		
		//마이페이지 헤더 정보
		MemberVO user = (MemberVO)session.getAttribute("user");
		
		MemberVO member = (MemberVO)mypageService.selectMember(user.getMem_num());
		
		SeatVO seat = mypageService.selectCurSeat(user.getMem_num());
		
		mav.addObject("member", member);
		mav.addObject("seat", seat);
		
		//공부시간 리스트
		Map<String, Object> map = new HashMap<String, Object>();
		
		logger.debug("<<user>> : " + user.getMem_num());
		
		int count = mypageService.selectSeatDetailRowCount(user.getMem_num());
		
		logger.debug("<<count>>" + count);
				
		PagingUtil page = new PagingUtil(keyfield, null, currentPage, count, 5, 5, "studyTimeList.do");
		
		List<SeatVO> list = null; 
		
		if(count > 0) {
		
		map.put("start", page.getStartRow()); 
		map.put("end", page.getEndRow());
		map.put("keyfield", keyfield);
		map.put("mem_num", user.getMem_num());
		
		list = mypageService.selectSeatDetailListByMem_num(map);
		}
		
		
		mav.addObject("count", count); 
		mav.addObject("list", list);
		mav.addObject("page", page.getPage());
		
		logger.debug("list" + list);
		
		mav.setViewName("studyTimeList");
		
		return mav;
	}
	
	
	
	//좌석선택 폼
	@GetMapping("/mypage/myPageselectSeat.do")
	public String myPageSelectSeat() {
		return "myPageselectSeat";
	}
	
	//=======================프로필사진 처리==========================//
	
	//프로필 사진 공통코드
	public void viewProfile(MemberVO member, HttpServletRequest request, Model model) {
		if(member == null || member.getMem_photo_name() == null) {
			byte[] readbyte = FileUtil.getBytes(request.getServletContext().getRealPath("/image_bundle/face.png"));
			model.addAttribute("imageFile", readbyte);
			model.addAttribute("filename", "face.png");
		}else {
			model.addAttribute("imageFile", member.getMem_photo());
			model.addAttribute("filename", member.getMem_photo_name());
		}
	}
	
	//프로필 사진 출력(회원번호 지정)
	@RequestMapping("/mypage/viewProfile.do")
	public String getProfileByMem_num(@RequestParam int mem_num, HttpSession session, HttpServletRequest request, Model model) {
		
		MemberVO member = mypageService.selectMember(mem_num);
		
		
		viewProfile(member, request, model);
		
		return "imageView";
	}
	
	//프로필사진 출력(로그인 전용)
	@RequestMapping("/mypage/photoView.do")
	public String getProfile(HttpSession session, HttpServletRequest request, Model model) {
		
		MemberVO user = (MemberVO)session.getAttribute("user");
				
		if(user == null) {
			byte[] readbyte = FileUtil.getBytes(
					request.getServletContext().getRealPath("/image_bundle/face.png"));
			model.addAttribute("imageFile", readbyte);
			model.addAttribute("filename", "face.png");
		}else {
			MemberVO memberVO = mypageService.selectMember(user.getMem_num());
			viewProfile(memberVO,request,model);
		}
		return "imageView";
	}
	
	//프로필 사진 업로드
	@RequestMapping("/mypage/updateProfileImg.do")
	@ResponseBody
	public Map<String, String> updateProfile(MemberVO member, HttpSession session){
		
		Map<String, String> mapAjax = new HashMap<String, String>();
		
		MemberVO user = (MemberVO)session.getAttribute("user");
				
		if(user == null) {
			mapAjax.put("result", "logout");
		}else {
			member.setMem_num(user.getMem_num());
			mypageService.updateProfile(member);
			mapAjax.put("result", "success");
		}
		
		return mapAjax;
	}
}






