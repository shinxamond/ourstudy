package kr.spring.interceptor;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.HandlerInterceptor;

import kr.spring.member.service.MemberService;
import kr.spring.member.vo.MemberVO;

public class AutoLoginCheckInterceptor implements HandlerInterceptor{
	private static final Logger logger = LoggerFactory.getLogger(AutoLoginCheckInterceptor.class);

	//처음 클라이언트가 진입했을 때 auto_id가 있는지 없는지 체크
	@Autowired
	MemberService memberService;

	@Override
	public boolean preHandle(HttpServletRequest request,
							 HttpServletResponse response,
							 Object handler) throws Exception{
		logger.debug("<<AutoLoginCheckInterceptor 진입>>");

		HttpSession session = request.getSession();
		MemberVO user = (MemberVO)session.getAttribute("user");
		if(user==null) {
			Cookie now_cookie = findCookie(request.getCookies(), "auto-log");
			if(now_cookie!=null) {
				MemberVO memberVO = memberService.selectAuto_id(now_cookie.getValue());
				//자동로그인 처리
				//일반회원이상만 자동로그인처리(탈퇴회원은 불가)
				if(memberVO!=null && memberVO.getMem_auth()>=1) {
					session.setAttribute("user", memberVO);
					logger.debug("<<AutoLogin Success>>");
				}

			}
		}

		return true;
	}

	private Cookie findCookie(Cookie[] cookies, String name) {
		if(cookies == null || cookies.length == 0) {
			return null;
		}else {
			for(int i=0;i<cookies.length;i++) {
				String cookie_name = cookies[i].getName();
				if(cookie_name.equals(name)) {
					return cookies[i]; //같은 이름의 쿠키가 있으면 쿠키 객체를 반환
				}
			}
			return null;
		}

	}
}
