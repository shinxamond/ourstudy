package kr.spring.member.kakao;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
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

import com.github.scribejava.core.model.OAuth2AccessToken;

import kr.spring.member.controller.MemberController;
import kr.spring.member.service.MemberService;
import kr.spring.member.vo.MemberVO;

@Controller
public class NaverController {
	private static final Logger logger = LoggerFactory.getLogger(MemberController.class);
	
	@Autowired
	private MemberService memberService; 
	@Autowired
	private NaverService naver;

	//자바빈(VO) 초기화
	@ModelAttribute
	public MemberVO initCommand() {
		return new MemberVO();
	}

	private String apiResult = null;
	
	//네이버 데이터 가져오기 및 로그인
	@RequestMapping("/member/naverLogin")
	public String naverLogin(Model model, @RequestParam String code,
			HttpSession session, @RequestParam String state) throws Exception {
		 	
			System.out.println("성공?");
			OAuth2AccessToken oauthToken;
		    oauthToken = naver.getAccessToken(session, code, state);
		    //1. 로그인 사용자 정보를 읽어온다.
		    apiResult = naver.getUserProfile(oauthToken); //String형식의 json데이터
		    //2. String형식인 apiResult를 json형태로 바꿈
		    JSONParser parser = new JSONParser();
		    JSONObject jsonObj = (JSONObject) parser.parse(apiResult);
		    
		    //3. 데이터 파싱
		    //Top레벨 단계 _response 파싱
		    JSONObject response_obj = (JSONObject)jsonObj.get("response");
		    //response의 nickname값 파싱
		    String naver_name = (String)response_obj.get("name");
		    String naver_email = (String)response_obj.get("email");

		    //4.파싱 닉네임 세션으로 저장
		    session.setAttribute("naver", apiResult);
		    System.out.println("네아로 성공");
		    System.out.println(naver_name);
		    System.out.println(naver_email);
		    
		    MemberVO member = memberService.selectNaverCheck(naver_email);
			
			if(member!=null) { //회원가입 했음
				logger.debug("<<네이버 인증 성공>> : " + member.getMem_id());
				
				member.setMem_id(member.getMem_id());
				member.setMem_pw(member.getMem_pw());
				
				member = memberService.selectCheckMember(member.getMem_id());
				
				session.setAttribute("user", member);
				session.setAttribute("user_num", member.getMem_num());
				
				return "redirect:/main/main.do";
				
			}else { //회원가입한 적 없음
				
				model.addAttribute("code", oauthToken);
				model.addAttribute("naver_email", naver_email);
				model.addAttribute("naver_name", naver_name);
				
				return "memberNaverRegister";
			}
		}
	
	//네이버 회원가입 폼 호출
	@GetMapping("/member/naverForm.do")
	public String naverForm() {
		return "memberNaverRegister";
	}


	//카카오톡 회원가입 데이터 전송
	@PostMapping("/member/registerNaverUser.do")
	public String submit(@Valid MemberVO memberVO, BindingResult result,
			HttpSession session, Model model) {


		logger.debug("<<네이버 회원가입>> : " + memberVO);

		//유효성 체크 결과 오류가 있으면 폼 호출
		if(result.hasErrors()) {
			return naverForm();
		}

		//회원가입
		memberService.insertNMember(memberVO);

		MemberVO member = null;
		member = memberService.selectCheckMember(memberVO.getMem_id());

		session.setAttribute("user", member);
		session.setAttribute("user_num", member.getMem_num());

		model.addAttribute("accessMsg", "회원가입이 완료되었습니다.");

		return "common/notice"; // 이렇게 경로/타일명으로 명시하면 jsp 호출


	}


}
