package kr.spring.member.controller;

import java.util.HashMap;
import java.util.Map;
import java.util.UUID;
import java.util.regex.Pattern;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletResponse;
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

import kr.spring.member.service.MemberService;
import kr.spring.member.vo.MemberVO;
import kr.spring.util.AuthCheckException;

@Controller
public class MemberController {
	private static final Logger logger = LoggerFactory.getLogger(MemberController.class);

	@Autowired
	private MemberService memberService;

	//자바빈(VO) 초기화
	@ModelAttribute
	public MemberVO initCommand() {
		return new MemberVO();
	}

	//========회원가입=========
	//아이디 중복 체크
	@RequestMapping("/member/confirmId.do")
	@ResponseBody
	public Map<String,String> process(@RequestParam String mem_id){
		logger.debug("<<id>> : " + mem_id);

		Map<String,String> mapAjax = new HashMap<String,String>();

		MemberVO member = memberService.selectCheckMember(mem_id);
		if(member!=null) {
			//아이디 중복
			mapAjax.put("result", "idDuplicated");
		}else {
			if(!Pattern.matches("^[a-z0-9]{4,12}$", mem_id)) { //정규표현식을 따르지 않았을 때
				//패턴 불일치
				mapAjax.put("result", "notMatchPattern");
			}else {
				//패턴 일치하면서 아이디 미중복
				mapAjax.put("result", "idNotFound");
			}
		}
		return mapAjax;
	}

	//회원등록 폼 호출
	@GetMapping("/member/registerUser.do")
	public String form() {
		return "memberRegister";
	}

	//회원가입 데이터 전송
	@PostMapping("/member/registerUser.do")
	public String submit(@Valid MemberVO memberVO, BindingResult result, Model model) {

		logger.debug("<<회원가입>> : " + memberVO);

		//유효성 체크 결과 오류가 있으면 폼 호출
		if(result.hasErrors()) {
			return form();
		}

		//회원가입
		memberService.insertMember(memberVO);

		model.addAttribute("accessMsg", "회원가입이 완료되었습니다.");

		return "common/notice"; // 이렇게 경로/타일명으로 명시하면 jsp 호출
	}

	//========회원로그인=========
	//로그인 폼 호출
	@GetMapping("/member/login.do")
	public String formLogin() {
		return "memberLogin";
	}

	//로그인 폼에 전송된 데이터 처리
	@PostMapping("/member/login.do")
	public String submitLogin(@Valid MemberVO memberVO, BindingResult result,
			HttpSession session,
			HttpServletResponse response) {
		logger.debug("<<회원로그인>> : " + memberVO);

		//유효성 체크 결과 오류가 있으면 폼을 호출
		//특정 필드만 체크
		if(result.hasFieldErrors("mem_id") || result.hasFieldErrors("mem_pw")) {
			return formLogin();
		}

		//로그인 체크
		MemberVO member = null;
		try {
			member = memberService.selectCheckMember(memberVO.getMem_id());
			boolean check = false;

			if(member!=null) { //아이디 체크 -> 존재
				//비밀번호 일치여부 체크
				check = member.isCheckedPassword(memberVO.getMem_pw());
			}
			if(check) { //인증성공
				//자동로그인 체크
				boolean autoLogin = memberVO.getAuto() != null && memberVO.getAuto().equals("on");
				if(autoLogin) {
					//자동로그인 체크를 한 경우
					String auto_id = member.getAuto_id(); 
					//한 번도 체크한 적이 없으면 au_id가 없다
					if(auto_id==null) {
						//자동로그인 체크 식별값 생성
						auto_id = UUID.randomUUID().toString();
						logger.debug("<<auto_id>> : " + auto_id);
						memberService.updateAuto_id(auto_id, memberVO.getMem_id());
					}

					//클라이언트에서 식별가능하도록 쿠키 만들기
					Cookie auto_cookie = new Cookie("auto-log",auto_id);
					//쿠키의 유효기간은 하루
					auto_cookie.setMaxAge(60*60*24*1);
					auto_cookie.setPath("/");

					//생성한 쿠키를 클라이언트에 전송
					response.addCookie(auto_cookie);
				}

				//인증 성공, 로그인 처리
				session.setAttribute("user", member);

				logger.debug("<<인증 성공>> : " + member.getMem_id());

				if(member.getMem_auth()==9) {
					logger.debug("<<관리자 로그인 성공>> : " + member.getMem_auth());
					return "redirect:/main/admin.do";
				}else {
					return "redirect:/main/main.do";
				}
			}
			//인증실패
			throw new AuthCheckException();
		}catch(AuthCheckException e) {
			//인증실패로 로그인폼 호출
			if(member!=null && member.getMem_auth()==0) {
				//탈퇴회원 메시지 표시
				result.reject("noAuthority");
			}else {
				result.reject("invalidIdOrPassword");
			}

			logger.debug("<<인증 실패>>");

			return formLogin();
		}	
	}
	
	//========회원로그아웃=========
	@RequestMapping("/member/logout.do")
	public String processLogout(HttpSession session, HttpServletResponse response) {

		//로그아웃
		session.invalidate();

		//자동로그인 클라이언트 쿠키 처리
		//자동로그인 쿠키 삭제
		Cookie auto_cookie = new Cookie("auto-log","");
		auto_cookie.setMaxAge(0); //0 넣으면 쿠키 유효시간 만료
		auto_cookie.setPath("/");

		//클라이언트에 쿠키 전송
		response.addCookie(auto_cookie);

		return "redirect:/main/main.do";
	}
}






