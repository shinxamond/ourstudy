package kr.spring.mypage.controller;

import java.time.DayOfWeek;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.Period;
import java.time.format.DateTimeFormatter;
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
import kr.spring.item.service.ItemService;
import kr.spring.item.vo.ItemVO;
import kr.spring.member.service.MemberService;
import kr.spring.member.vo.MemberVO;
import kr.spring.mypage.service.MypageService;
import kr.spring.pay.vo.PayVO;
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
	@Autowired
	private ItemService itemService;
	
	//////////////나중에 지울것////////////////////////////
	@PostMapping("/mypage/deleteSometing.do")
	public String deleteSome(HttpSession session, String delnum) {
		
		MemberVO user = (MemberVO)session.getAttribute("user");
		
		if(delnum == null || delnum == "") {
			mypageService.deleteSomething(user.getMem_num());
		}else {
			mypageService.deleteSomething(Integer.parseInt(delnum));
		}
		
		return "redirect:/mypage/myPageMain.do";
		
	}
	
	//마이페이지 메인 호출
	@RequestMapping("/mypage/myPageMain.do")
	public String form(@RequestParam(value="pageNum", defaultValue="1")int currentPage, HttpSession session, Model model) {
		
		//회원 기본 정보 세팅
		MemberVO user = (MemberVO)session.getAttribute("user");
		
		MemberVO member = mypageService.selectMember(user.getMem_num());
		
		SeatVO seat = mypageService.selectCurSeat(user.getMem_num());
		
		Integer pointSum = mypageService.selectTotalPoint(user.getMem_num());
		
		Float remainTime = mypageService.selectRemainTime(user.getMem_num());
		
		if(pointSum == null) {
			pointSum = 0;
		}
		
		logger.debug("<<마이페이지 멤버 정보>> : " + member);
		
		String[] setThisWeek = new String[7];
		Integer[] setTotalTime_thisWeek = new Integer[7];
		LocalDate now = LocalDate.now();
		LocalDate setThisMonday = now.with(DayOfWeek.MONDAY);
		LocalDate setNextMonday = setThisMonday.plusDays(7);
		
		for(int i = 0; i < setThisWeek.length; i++) {
			setThisWeek[i] = setThisMonday.plusDays(i).toString();
		}
		for(int i = 0; i < setTotalTime_thisWeek.length; i++) {
			if(i == setTotalTime_thisWeek.length - 1) {
				setTotalTime_thisWeek[i] = mypageService.selectSumTotalTimeForGraph(setThisWeek[i], setNextMonday.toString(), user.getMem_num());
			}else {
				setTotalTime_thisWeek[i] = mypageService.selectSumTotalTimeForGraph(setThisWeek[i], setThisWeek[i+1], user.getMem_num());
			}
		}
		
		
		/*=============================================
		 * 				그래프에 데이터 전달하기
		 *=============================================*/
		/*//요일 기준으로 일요일까지 날짜 2011-11-11 형식으로 배열에 담아줄거임 먼저 초기화 일주일치 담을거니까 크기는 7
		//가입일이 월요일이 아닌 사람은 나머지 값을 널로 해야되니까 세팅
		String[] setWeek = new String[7];
		//그 날짜가 포함된 월~수 날짜 전부 담아줄 배열
		//얘는 그래프 x축에 넘겨줄 데이터
		String[] setFullWeek = new String[7];
		//더할 날짜 늘리면서 해야되니까 0으로 미리 초기화
		int cnt = 0;
		//이거는 다음주 월료일 담아주려고
		String setMon = null;
		//이거는 신규 가입자가 월요일에 가입한게 아닐 때 가입일 담아주려고
		String u_regdate = null;
		//이거는 신규 가입자 localdate 타입으로 변환해서 담아두려고 or 월요일일 때 월요일 날짜 담아두려고
		LocalDate user_regdate = null;
		//요거는 위에걸로 가져온 날짜에 월요일(1) 담아두려고
		int userRegWeekNum;
		u_regdate = mypageService.selectRegDate(user.getMem_num());
		//회원가입일 String으로 받아오면 2011-11-11 11:11:11이므로 뒤에거 잘라주기
		String[] u_regdate_split = u_regdate.split(" ");
		//공백 기준으로 자른 배열 첫 번째(연월일)만 가져와서 다시 하이픈 기준으로 잘라주기
		String[] u_regdate_split2 = u_regdate_split[0].split("-");
		
		//요게 이제 2011-11-11 이런 형식 -> LocalDate로 바꿔서 요일 가져올 수 있게
		user_regdate = LocalDate.of(Integer.parseInt(u_regdate_split2[0]),Integer.parseInt(u_regdate_split2[1]), Integer.parseInt(u_regdate_split2[2]));		
		
		
		
		//이거는 컨트롤러 호출될 때 요일
		int thisMon = LocalDate.now().getDayOfWeek().getValue();
		Period period = null;
		//오늘이 월요일이면 user_regdate에 오늘 날짜 localdate로 담아주고 userRegWeek 월(1)로 세팅
		if(thisMon == 1) {
			user_regdate = LocalDate.now();
			
			userRegWeekNum = thisMon;
		} else if(Period.between(user_regdate, LocalDate.now()).getDays() < 6){
			//요일 구하려면 dayofweek 객체가 필요하다니까 생성
			DayOfWeek thisWeek = user_regdate.getDayOfWeek();
			
			//dayofweek 객체의 getvalue 메소드를 쓰면 요일 가져온대 가입일에 해당하는 요일(1:월~7:일)
			userRegWeekNum = thisWeek.getValue();
		}
		
		//월료일부터 일요일까지 루프 돌리기 날짜 월(1)~일(7)이니까 1부터 시작해보자
		for(int i = 1; i < 8; i++) {
			//i가 가입일에 해당하는 요일보다 작으면 ex) 오늘(목,4) i= 1이면 1 < 4 가 되고 setWeek[i(1)-1]에 null세팅
			if(i < userRegWeekNum) {
				setWeek[i-1] = null;
				//데이터는 널이어도 날짜는 x축에 표시해야되니까 plusDays에 -값을 줘서 이전 날짜를 구한다
				setFullWeek[i-1] = user_regdate.plusDays(i-userRegWeekNum).format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));
			}else {//오늘 요일(목,4)랑 i가 같아지면(i, 4) setWeek[3]부터 plusDays(0)
				setWeek[i-1] = user_regdate.plusDays(cnt).format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));
				setFullWeek[i-1] = user_regdate.plusDays(cnt).format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));
				//첫번째 호출 때 0 더했으니까 cnt증가시켜주고 다음 호출시엔 1 더하는걸로 그담은 2 ...
				cnt++;
			}
		}
		//setMon에 일요일 다음에 올 날짜를 미리 담아두고 나중에 시간 비교해서 이 날짜랑 오늘 날짜가 같아지면 mem_detail에 reg_date를 일주일 뒤 값으로 업데이트 해준다
		setMon = user_regdate.plusDays(cnt).format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));
		
		
		
		
		//이까지해서 찍어보면 월화수목금토일 날짜가 나온다
		//3월 2일일 경우 setWeek에는 null, null, null, 2023-03-02, 2023-03-03, 2023-03-04, 2023-03-05가 들어있음
		//이러며는 이제 어.. 인덱스 0이 월요일 인덱스 6이 일요일이 될거니까 사실상 요일 정보도 담았다고 볼 수 있다
		//각 날짜별 시간 담을 배열
		Integer[] setTime = new Integer[7];
		
		for(int i = 0; i < setWeek.length; i++) {
			//setweek배열 가져와서 내용물 끄내보고 null이면 해당 인덱스 값도 null로 세팅
			if(setWeek[i] == null) {
				setTime[i] = (Integer) null;
			}else {
				if(i == setWeek.length - 1) { //i가 마지막 인덱스에 가면 그 다음 월료일 날짜를 파라미터로 줘서 날짜 검색이 가능하도록 한다
					setTime[i] = mypageService.selectSumTotalTimeForGraph(setWeek[i], setMon, user.getMem_num());
				}else { //그 전까진 다음 날 날짜를 검색 범위 날짜로 줌           ex)2023-03-02   2023-03-03
					setTime[i] = mypageService.selectSumTotalTimeForGraph(setWeek[i], setWeek[i+1], user.getMem_num());
				}
			}
		}*/
		
		//날짜별 시간 담은 배열 넘겨주기
		model.addAttribute("week", setThisWeek);
		System.out.println("week 찍어보기" + setThisWeek[0]+" "+setThisWeek[1]+" "+setThisWeek[2]+" "+setThisWeek[3]+" "+setThisWeek[4]+" "+setThisWeek[5]+" "+setThisWeek[6]);
		//한 주 날짜 넘겨주기
		model.addAttribute("time", setTotalTime_thisWeek);
		System.out.println("time 찍어보기" + setTotalTime_thisWeek[0]+" "+setTotalTime_thisWeek[1]+" "+setTotalTime_thisWeek[2]+" "+setTotalTime_thisWeek[3]+" "+setTotalTime_thisWeek[4]+" "+setTotalTime_thisWeek[5]+" "+setTotalTime_thisWeek[6]);

		
		
		
		
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		int count = itemService.rentalItemCount(2, user.getMem_num());
		
		PagingUtil page = new PagingUtil(currentPage, count, 3, 3, "myPageMain.do");
		
		List<ItemVO> list = null;
		
		map.put("item_r_status", 2);
		map.put("mem_num", user.getMem_num());
		if(count > 0) {
			map.put("start", page.getStartRow());
			map.put("end", page.getEndRow());
			
			list = itemService.rentalItemList(map);
		}
		
		model.addAttribute("count", count);
		model.addAttribute("list", list);
		model.addAttribute("member", member);
		model.addAttribute("seat", seat);
		model.addAttribute("pointSum", pointSum);
		model.addAttribute("remainTime", remainTime * 3600);
		
		return "myPageMain"; //타일스 설정값
	}
	
	//회원정보
	@RequestMapping("/mypage/myPageMemInfo.do")
	public String formInfo(HttpSession session, Model model) {
		
		MemberVO user = (MemberVO)session.getAttribute("user");
		
		MemberVO member = mypageService.selectMember(user.getMem_num());
		
		SeatVO seat = mypageService.selectCurSeat(user.getMem_num());
		
		Integer pointSum = mypageService.selectTotalPoint(user.getMem_num());
		
		Float remainTime = mypageService.selectRemainTime(user.getMem_num());
		
		if(pointSum == null) {
			pointSum = 0;
		}
		logger.debug("<<마이페이지 멤버 정보>> : " + member);
		
		model.addAttribute("member", member);
		model.addAttribute("seat", seat);
		model.addAttribute("pointSum", pointSum);
		model.addAttribute("remainTime", remainTime * 3600);
		
		return "myPageMemInfo";
	}
	
	//회원정보 수정 폼 호출
	@RequestMapping("/mypage/myPageModify.do")
	public String myPageModifyForm(HttpSession session, Model model) {
		
		MemberVO user = (MemberVO)session.getAttribute("user");
		
		MemberVO member = (MemberVO)mypageService.selectMember(user.getMem_num());
		
		SeatVO seat = mypageService.selectCurSeat(user.getMem_num());
		
		Integer pointSum = mypageService.selectTotalPoint(user.getMem_num());
		
		Float remainTime = mypageService.selectRemainTime(user.getMem_num());
		
		if(pointSum == null) {
			pointSum = 0;
		}
		model.addAttribute("member", member);
		model.addAttribute("seat", seat);
		model.addAttribute("pointSum", pointSum);
		model.addAttribute("remainTime", remainTime * 3600);
		
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
		
		Integer pointSum = mypageService.selectTotalPoint(user.getMem_num());
		
		Float remainTime = mypageService.selectRemainTime(user.getMem_num());
		
		if(pointSum == null) {
			pointSum = 0;
		}
		model.addAttribute("member", member);
		model.addAttribute("seat", seat);
		model.addAttribute("pointSum", pointSum);
		model.addAttribute("remainTime", remainTime * 3600);
		
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
		
		Integer pointSum = mypageService.selectTotalPoint(user.getMem_num());
		
		Float remainTime = mypageService.selectRemainTime(user.getMem_num());
		
		if(pointSum == null) {
			pointSum = 0;
		}
		model.addAttribute("member", member);
		model.addAttribute("seat", seat);
		model.addAttribute("pointSum", pointSum);
		model.addAttribute("remainTime", remainTime * 3600);
		
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
	@RequestMapping("/mypage/pointList.do")
	public ModelAndView pointList(@RequestParam(value = "pageNum", defaultValue = "1") int currentPage, @RequestParam(value = "keyfield", defaultValue = "1") String keyfield, HttpSession session, Model model) {
		
		ModelAndView mav = new ModelAndView();
		
		//헤더 정보 세팅
		MemberVO user = (MemberVO)session.getAttribute("user");
		
		MemberVO member = (MemberVO)mypageService.selectMember(user.getMem_num());
		
		SeatVO seat = mypageService.selectCurSeat(user.getMem_num());		
		
		Integer pointSum = mypageService.selectTotalPoint(user.getMem_num());
		
		Float remainTime = mypageService.selectRemainTime(user.getMem_num());
		
		if(pointSum == null) {
			pointSum = 0;
		}
		mav.addObject("member", member);
		mav.addObject("seat", seat);
		mav.addObject("pointSum", pointSum);
		mav.addObject("remainTime", remainTime * 3600);
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		int count = mypageService.selectPointListCountByMemNum(user.getMem_num());
		
		PagingUtil page = new PagingUtil(keyfield, null, currentPage, count, 5, 5, "pointList.do");
		
		List<PayVO> list = null;
		
		if(count > 0) {
			map.put("start", page.getStartRow());
			map.put("end", page.getEndRow());
			map.put("keyfield", keyfield);
			map.put("mem_num", user.getMem_num());
			
			list = mypageService.selectPointListByMemNum(map);
		}
		
		mav.addObject("count", count); 
		mav.addObject("list", list);
		mav.addObject("page", page.getPage());
		
		mav.setViewName("pointList");
		return mav;
	}
	
	//공부시간 목록
	@RequestMapping("/mypage/studyTimeList.do")
	public ModelAndView studyTimeList(@RequestParam(value = "pageNum", defaultValue = "1") int currentPage, @RequestParam(value = "keyfield", defaultValue = "1") String keyfield , HttpSession session, Model model) {
		
		ModelAndView mav = new ModelAndView();
		
		//마이페이지 헤더 정보
		MemberVO user = (MemberVO)session.getAttribute("user");
		
		MemberVO member = (MemberVO)mypageService.selectMember(user.getMem_num());
		
		SeatVO seat = mypageService.selectCurSeat(user.getMem_num());
		
		Integer pointSum = mypageService.selectTotalPoint(user.getMem_num());
		
		Float remainTime = mypageService.selectRemainTime(user.getMem_num());
		
		if(pointSum == null) {
			pointSum = 0;
		}
		mav.addObject("member", member);
		mav.addObject("seat", seat);
		mav.addObject("pointSum", pointSum);
		mav.addObject("remainTime", remainTime * 3600);
		
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






