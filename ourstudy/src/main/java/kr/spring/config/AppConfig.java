package kr.spring.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
import org.springframework.web.servlet.view.tiles3.TilesConfigurer;
import org.springframework.web.servlet.view.tiles3.TilesView;
import org.springframework.web.servlet.view.tiles3.TilesViewResolver;

import kr.spring.interceptor.AutoLoginCheckInterceptor;
import kr.spring.interceptor.LoginCheckInterceptor;

//자바코드 기반 설정 클래스
@Configuration
public class AppConfig implements WebMvcConfigurer{
	
	private AutoLoginCheckInterceptor autoLogin;
	private LoginCheckInterceptor loginCheck;
	
	@Bean
	public AutoLoginCheckInterceptor interceptor() {
		autoLogin = new AutoLoginCheckInterceptor();
		return autoLogin;
	}
	
	@Bean
	public LoginCheckInterceptor interceptor2() {
		loginCheck = new LoginCheckInterceptor();
		return loginCheck;
	}
	
	//타일스 설정
	@Bean
	public TilesConfigurer tilesConfigurer() {
		final TilesConfigurer configurer =
				new TilesConfigurer();
		//해당 경로에 xml 설정 파일을 넣음
		configurer.setDefinitions(new String[] {
				"/WEB-INF/tiles-def/main.xml",
				"/WEB-INF/tiles-def/HJ.xml",
				"/WEB-INF/tiles-def/JH.xml",
				"/WEB-INF/tiles-def/KJ.xml",
				"/WEB-INF/tiles-def/KY.xml",
				"/WEB-INF/tiles-def/NR.xml",
				"/WEB-INF/tiles-def/YG.xml",
				"/WEB-INF/tiles-def/YM.xml"
		});
		configurer.setCheckRefresh(true);
		return configurer;
	}
	@Bean
	public TilesViewResolver tilesViewResolver() {
		final TilesViewResolver tilesViewResolver = 
				new TilesViewResolver();
		tilesViewResolver.setViewClass(TilesView.class);
		return tilesViewResolver;
	}
}



