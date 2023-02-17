package kr.spring.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.HandlerInterceptor;

public class LoginCheckInterceptor implements HandlerInterceptor {
	//로그 대상 지정해야 로그 찍을 수 있음
	private static final Logger logger = LoggerFactory.getLogger(LoginCheckInterceptor.class);

	@Override
	public boolean preHandle(HttpServletRequest request,
							 HttpServletResponse response,
							 Object handler) throws Exception{

		logger.debug("<<LoginCheckInterceptor 진입>>");

		HttpSession session = request.getSession();

		//로그인여부 검사
		if(session.getAttribute("user")==null) { 
			//로그인 안 된 상태
			response.sendRedirect(request.getContextPath()+"/member/login.do");
			return false; //리다이렉트한 페이지가 동작되게 하기 위해 return false
		}

		return true;
	}
}
