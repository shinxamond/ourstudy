package kr.spring.mypage.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import kr.spring.util.FileUtil;
import kr.spring.member.controller.MemberController;
import kr.spring.member.vo.MemberVO;
import kr.spring.mypage.service.MypageService;
import kr.spring.point.vo.PointVO;

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
	
	//회원등록 폼 호출
	@GetMapping("/mypage/myPageMain.do")
	public String form() {
		return "myPageMain"; //타일스 설정값
	}
	
	//회원정보 수정 폼 호출
	@GetMapping("/mypage/myPageModify.do")
	public String myPageModifyForm() {
		return "myPageModify";
	}
	
	//비밀번호 변경 폼 호출
	@GetMapping("/mypage/myPagechangePasswd.do")
	public String myPageChangePasswdForm() {
		return "myPagechangePasswd";
	}
	
	//회원탈퇴 폼 호출
	@GetMapping("/mypage/myPagedeleteMember.do")
	public String myPageDeleteMemberForm() {
		return "myPagedeleteMember";
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
	@GetMapping("/mypage/studyTimeList.do")
	public String studyTimeList() {
		return "studyTimeList";
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
		
		logger.debug("<<프로필사진출력시 member 정보>> : " + user);
		
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
		
		logger.debug("<<프로필사진 업로드>> : " + user);
		
		if(user == null) {
			mapAjax.put("result", "logout");
			System.out.println("ss");
		}else {
			System.out.println("dd");
			member.setMem_num(user.getMem_num());
			logger.debug("<멤버정보>" + member);
			mypageService.updateProfile(member);
			System.out.println("dddd");
			mapAjax.put("result", "success");
		}
		
		return mapAjax;
	}
}






