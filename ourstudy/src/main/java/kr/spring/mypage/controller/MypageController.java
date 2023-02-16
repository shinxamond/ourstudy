package kr.spring.mypage.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import kr.spring.member.controller.MemberController;
import kr.spring.member.vo.MemberVO;
import kr.spring.point.vo.PointVO;

@Controller
public class MypageController {
	private static final Logger logger = LoggerFactory.getLogger(MypageController.class);

	//자바빈(VO) 초기화
	@ModelAttribute
	public PointVO initCommand() {
		return new PointVO();
	}

	
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
}






