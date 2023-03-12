package kr.spring.member.controller;

import java.time.LocalDate;
import java.time.Period;
import java.time.format.DateTimeFormatter;
import java.util.Arrays;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;
import java.util.regex.Pattern;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.apache.catalina.User;
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

import kr.spring.locker.service.LockerService;
import kr.spring.member.kakao.KakaoService;
import kr.spring.member.service.MemberService;
import kr.spring.member.vo.MemberVO;
import kr.spring.pay.service.PayService;
import kr.spring.seat.service.SeatService;
import kr.spring.util.AuthCheckException;

@Controller
public class MemberController {
   private static final Logger logger = LoggerFactory.getLogger(MemberController.class);

   @Autowired
   private MemberService memberService;
   @Autowired
   private KakaoService kakao;
   @Autowired
   private LockerService lockerService;
   @Autowired
   private SeatService seatService;
   @Autowired
   private PayService payService;
   
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

   //로그인 폼에 전송된 데이터 처리
   @PostMapping("/member/login.do")
   public String submitLogin(@Valid MemberVO memberVO, BindingResult result,
         HttpSession session,
         HttpServletRequest request,
         HttpServletResponse response, Model model) {
      logger.debug("<<회원로그인>> : " + memberVO);

      Map<String,String> mapAjax = new HashMap<String,String>();
      
      //로그인 체크
      MemberVO member = null;
      
      memberVO.setMem_id(request.getParameter("mem_id"));
      memberVO.setMem_pw(request.getParameter("mem_pw"));
      
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
            session.setAttribute("user_num", member.getMem_num());

            logger.debug("<<인증 성공>> : " + member.getMem_id());
            
            ///////////////로그인하면서 사물함 종료시각 체크//////////////////
            String locker_end = lockerService.getLockerEnd(member.getMem_num());
            //오늘날짜 >= locker_end ---> 자동으로 사물함 statusd == 0
            String term_end = seatService.getMemberTerm(member.getMem_num());
            if(term_end != null) {
            	LocalDate now = LocalDate.now();
            	LocalDate termEnd = LocalDate.parse(term_end, DateTimeFormatter.ISO_DATE);
            	
            	//시작값 - 끝값 = 양수이면 기간남은거 음수이면 지난거 0이면 당일
            	Period remainPeriod = Period.between(now, termEnd);
            	if(remainPeriod.getDays() <= 0) {//당일이거나 지난경우
            		payService.updateTerm("", member.getMem_num());
            	}
            }
            
            if(locker_end != null) {
               LocalDate now = LocalDate.now();
               
               LocalDate lockerEnd = LocalDate.parse(locker_end, DateTimeFormatter.ISO_DATE);
               boolean compareDate = lockerEnd.isBefore(now);      
            
               if(compareDate || lockerEnd.isEqual(now)) {
                  Integer current_locker_num = lockerService.getLockerNum(member.getMem_num());
                  if(current_locker_num != null) {
                	  lockerService.lockerStatusOut(current_locker_num);
                  }
               }
            }
                  
            return "redirect:/main/main.do";
         }
         //인증실패
         throw new AuthCheckException();
      }catch(AuthCheckException e) {
         //인증실패로 로그인폼 호출
         if(member!=null && member.getMem_auth()==0) {
            //정지회원 메시지 표시
            model.addAttribute("message", "탈퇴한 계정입니다.");
            model.addAttribute("url", "/main/main.do");
            return "common/resultView";
         }else { //아이디 또는 비밀번호 틀림
            model.addAttribute("message", "아이디 또는 비밀번호 오류");
            model.addAttribute("url", "/main/main.do");
            return "common/resultView";
         }
   
         
      }   
   }
   
   //========회원로그아웃=========
   @RequestMapping("/member/logout.do")
   public String processLogout(HttpSession session, HttpServletResponse response) {

      String access_Token = (String)session.getAttribute("access_Token");
        
      if(access_Token != null && !"".equals(access_Token)){
      
            kakao.kakaoLogout(access_Token);
            session.removeAttribute("access_Token");
            
            System.out.println("###카카오톡 로그아웃###");
            System.out.println(access_Token);
        }
      
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
   
   //========아이디 찾기==========
   
   //아이디 찾기 폼 호출
   @GetMapping("/member/findId.do")
   public String findIdForm() {
      return "memberFindId";
   }
   
   //아이디 찾기 처리
   @PostMapping("/member/findId.do")
   public String FindIdSubmit(@Valid MemberVO memberVO, BindingResult result,
                       HttpServletRequest request, Model model) {
      
      logger.debug("<<아이디 찾기>> : " + memberVO);

      String mem_name = request.getParameter("mem_name");
      String mem_email = request.getParameter("mem_email");
      
      memberVO.setMem_all_id(memberService.find_id(mem_name, mem_email));
      String[] mem_all_id = memberVO.getMem_all_id();
      
      
      if(mem_all_id.length==0) {
         model.addAttribute("message","존재하지 않는 계정입니다.");
         model.addAttribute("url", "/member/findId.do");
         return "common/resultView";
      }else {
         model.addAttribute("accessMsg", mem_name+"님의 아이디는<br><br>" + Arrays.toString(mem_all_id) + "<br><br>입니다");
         return "common/notice";
      }
      
   }
   
   
   //========비밀번호 찾기=========
   
   //비밀번호 찾기 폼 호출
   @GetMapping("/member/findPw.do")
   public String findPwForm() {
      return "memberFindPw";
   }
   
   //비밀번호 찾기 처리
   @PostMapping("/member/findPw.do")
   public String FindPwsubmit(@Valid MemberVO memberVO, BindingResult result,
         HttpServletRequest request, Model model) {

      logger.debug("<<비밀번호 찾기>> : " + memberVO);

      String mem_id = request.getParameter("mem_id");
      String mem_email = request.getParameter("mem_email");
      
      String mem_pw = memberService.find_pw(mem_id, mem_email);

      if(mem_pw==null) {
         model.addAttribute("message","존재하지 않는 계정입니다.");
         model.addAttribute("url", "/member/findPw.do");
         return "common/resultView";
      }else {
         model.addAttribute("accessMsg", "비밀번호는<br><br> [" + mem_pw + "] <br><br>입니다");
         return "common/notice";
      }
      
   }
}





