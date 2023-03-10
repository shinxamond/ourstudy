package kr.spring.config;

import java.util.Properties;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
import org.springframework.web.servlet.view.tiles3.TilesConfigurer;
import org.springframework.web.servlet.view.tiles3.TilesView;
import org.springframework.web.servlet.view.tiles3.TilesViewResolver;

import kr.spring.interceptor.AdminCheckInterceptor;
import kr.spring.interceptor.AutoLoginCheckInterceptor;
import kr.spring.interceptor.LoginCheckInterceptor;

//자바코드 기반 설정 클래스
@Configuration
public class AppConfig implements WebMvcConfigurer{
	
	private AutoLoginCheckInterceptor autoLogin;
	private LoginCheckInterceptor loginCheck;
	private AdminCheckInterceptor adminCheck;
	
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
	
	@Bean
	public AdminCheckInterceptor interceptor3() {
		adminCheck = new AdminCheckInterceptor();
		return adminCheck;
	}
	
	//인터셉터 등록
		@Override
		public void addInterceptors(InterceptorRegistry registry) {
			//AutoLoginCheckInterceptor 설정
			registry.addInterceptor(autoLogin).addPathPatterns("/**") //모든 경로
											  .excludePathPatterns("/member/login.do") //제외할 화면
											  .excludePathPatterns("/member/logout.do"); //제외할 화면
			//LoginCheckInterceptor 설정
			registry.addInterceptor(loginCheck).addPathPatterns("/community/lostList.do")
											   .addPathPatterns("/community/lostWrite.do")
											   .addPathPatterns("/community/lostDetail.do")
											   .addPathPatterns("/community/lostUpdate.do")
											   .addPathPatterns("/community/lostDelete.do")
											   .addPathPatterns("/community/writelfReply.do")
											   .addPathPatterns("/community/listlfReply.do")
											   .addPathPatterns("/community/updatelfReply.do")
											   .addPathPatterns("/community/deletelfReply.do")
											   .addPathPatterns("/item/userList.do")
											   .addPathPatterns("/item/userRental.do");
			//AdminCheckInterceptor 설정
			registry.addInterceptor(adminCheck).addPathPatterns("/admin/admin_list.do")
											   .addPathPatterns("/admin/admin_seathistory.do")
											   .addPathPatterns("/admin/admin_lockerhistory.do")
											   .addPathPatterns("/admin/admin_itemhistory.do")
											   .addPathPatterns("/admin/admin_unreturnlist.do")
											   .addPathPatterns("/admin/admin_saleslist.do")
											   .addPathPatterns("/admin/admin_receivehistory.do")
											   .addPathPatterns("/admin/admin_sendhistory.do")
											   .addPathPatterns("/info/infoWrite.do")
											   .addPathPatterns("/info/infoUpdate.do")
											   .addPathPatterns("/info/infoDelete.do")
											   .addPathPatterns("/info/deleteFile.do")
											   .addPathPatterns("/talk/talkList.do")
											   .addPathPatterns("/talk/talkRoomWrite.do")
											   .addPathPatterns("/item/adminList.do")
											   .addPathPatterns("/item/itemWrite.do")
											   .addPathPatterns("/item/itemModify.do");
			//WriterCheckInterceptor 설정
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
	
	@Bean
    public JavaMailSenderImpl javaMailSenderImpl() {
    	Properties prop = new Properties();
    	prop.put("mail.smtp.ssl.trust", "smtp.gmail.com");
    	prop.put("mail.smtp.starttls.enable", "true");
    	prop.put("mail.transport.protocol", "smtp");
    	prop.put("mail.smtp.auth", "true");
    	prop.put("mail.debug", "true");
    	
    	JavaMailSenderImpl javaMail = new JavaMailSenderImpl();
    	javaMail.setHost("smtp.gmail.com");
    	javaMail.setPort(587);
    	javaMail.setDefaultEncoding("utf-8");
    	javaMail.setUsername("ourstudy777@gmail.com");
    	javaMail.setPassword("mlzafaiobikevduf");
    	javaMail.setJavaMailProperties(prop);
    	return javaMail;
    }
}



