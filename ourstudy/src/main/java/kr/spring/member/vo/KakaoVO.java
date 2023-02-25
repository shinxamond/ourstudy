package kr.spring.member.vo;

public class KakaoVO {
	private String kakao_nickname;
	private String kakao_image;
	private String kakao_email;
	
	public String getKakao_nickname() {
		return kakao_nickname;
	}
	public void setKakao_nickname(String kakao_nickname) {
		this.kakao_nickname = kakao_nickname;
	}
	public String getKakao_image() {
		return kakao_image;
	}
	public void setKakao_image(String kakao_image) {
		this.kakao_image = kakao_image;
	}
	public String getKakao_email() {
		return kakao_email;
	}
	public void setKakao_email(String kakao_email) {
		this.kakao_email = kakao_email;
	}
	
	@Override
	public String toString() {
		return "KakaoVO [kakao_nickname=" + kakao_nickname + ", kakao_image=" + kakao_image + ", kakao_email="
				+ kakao_email + "]";
	}
	
}
