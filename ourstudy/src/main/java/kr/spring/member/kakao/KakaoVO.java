package kr.spring.member.kakao;

public class KakaoVO {
	private String kakao_id;
	private String kakao_email;
	private String kakao_name;
	private String kakao_image;
	public String getKakao_id() {
		return kakao_id;
	}
	public void setKakao_id(String kakao_id) {
		this.kakao_id = kakao_id;
	}
	public String getKakao_email() {
		return kakao_email;
	}
	public void setKakao_email(String kakao_email) {
		this.kakao_email = kakao_email;
	}
	public String getKakao_name() {
		return kakao_name;
	}
	public void setKakao_name(String kakao_name) {
		this.kakao_name = kakao_name;
	}
	public String getKakao_image() {
		return kakao_image;
	}
	public void setKakao_image(String kakao_image) {
		this.kakao_image = kakao_image;
	}
	@Override
	public String toString() {
		return "KakaoVO [kakao_id=" + kakao_id + ", kakao_email=" + kakao_email + ", kakao_name=" + kakao_name
				+ ", kakao_image=" + kakao_image + "]";
	}
	
	
}
