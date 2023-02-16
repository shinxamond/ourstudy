package kr.spring.member.vo;

import java.io.IOException;
import java.sql.Date;

import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.Pattern;
import javax.validation.constraints.Size;

import org.springframework.web.multipart.MultipartFile;

public class MemberVO {
	private int mem_num;
	//'guest'로 시작할 수 없도록 나중에 설정 추가 예정
	@Pattern(regexp="[a-z0-9]{4,12}$") //알파벳 소문자&숫자가능, 4~12자
	private String mem_id;
	private int mem_auth;
	private String auto; //자동로그인 처리
	private String auto_id;
	@NotEmpty
	private String mem_name;
	@Pattern(regexp="^[A-Za-z0-9]{8,16}$") //알파벳 대소문자&숫자가능, 8~16자
	private String mem_pw;
	private String mem_phone;
	@NotEmpty
	private String mem_email;
	@Size(min=5,max=5)
	private String mem_zipcode;
	private String mem_address1;
	private String mem_address2;
	private byte[] mem_photo;
	private Date mem_regdate;
	private Date mem_mdate;
	
	//비밀번호 변경시 현재 비밀번호를 저장하는 용도로 사용
	@Pattern(regexp="^[A-Za-z0-9]{8,16}$")
	private String now_passwd;
	
	//====비밀번호 일치 여부 체크====//
	public boolean isCheckedPassword(String userPasswd) {
		if(mem_auth > 0 && mem_pw.equals(userPasswd)) {
			return true;
		}
		return false;
	}
	
	//====이미지 BLOB 처리====//
	//(주의)폼에서 파일업로드 파라미터네임은 반드시 upload로 지정해야 함(mem_photo로 하면 안 됨! upload로 받은 걸 photo로 바꿀 거라서)
	public void setUpload(MultipartFile upload) throws IOException{

		//MultipartFile -> byte[]
		setMem_photo(upload.getBytes());
	}

	public int getMem_num() {
		return mem_num;
	}

	public void setMem_num(int mem_num) {
		this.mem_num = mem_num;
	}

	public String getMem_id() {
		return mem_id;
	}

	public void setMem_id(String mem_id) {
		this.mem_id = mem_id;
	}

	public int getMem_auth() {
		return mem_auth;
	}

	public void setMem_auth(int mem_auth) {
		this.mem_auth = mem_auth;
	}

	public String getAuto() {
		return auto;
	}

	public void setAuto(String auto) {
		this.auto = auto;
	}

	public String getAuto_id() {
		return auto_id;
	}

	public void setAuto_id(String auto_id) {
		this.auto_id = auto_id;
	}

	public String getMem_name() {
		return mem_name;
	}

	public void setMem_name(String mem_name) {
		this.mem_name = mem_name;
	}

	public String getMem_pw() {
		return mem_pw;
	}

	public void setMem_pw(String mem_pw) {
		this.mem_pw = mem_pw;
	}

	public String getMem_phone() {
		return mem_phone;
	}

	public void setMem_phone(String mem_phone) {
		this.mem_phone = mem_phone;
	}

	public String getMem_email() {
		return mem_email;
	}

	public void setMem_email(String mem_email) {
		this.mem_email = mem_email;
	}

	public String getMem_zipcode() {
		return mem_zipcode;
	}

	public void setMem_zipcode(String mem_zipcode) {
		this.mem_zipcode = mem_zipcode;
	}

	public String getMem_address1() {
		return mem_address1;
	}

	public void setMem_address1(String mem_address1) {
		this.mem_address1 = mem_address1;
	}

	public String getMem_address2() {
		return mem_address2;
	}

	public void setMem_address2(String mem_address2) {
		this.mem_address2 = mem_address2;
	}
	
	public byte[] getMem_photo() {
		return mem_photo;
	}

	public void setMem_photo(byte[] mem_photo) {
		this.mem_photo = mem_photo;
	}

	public Date getMem_regdate() {
		return mem_regdate;
	}

	public void setMem_regdate(Date mem_regdate) {
		this.mem_regdate = mem_regdate;
	}

	public Date getMem_mdate() {
		return mem_mdate;
	}

	public void setMem_mdate(Date mem_mdate) {
		this.mem_mdate = mem_mdate;
	}

	public String getNow_passwd() {
		return now_passwd;
	}

	public void setNow_passwd(String now_passwd) {
		this.now_passwd = now_passwd;
	}

	@Override
	public String toString() {
		return "가상vo [mem_num=" + mem_num + ", mem_id=" + mem_id + ", mem_auth=" + mem_auth + ", auto=" + auto
				+ ", auto_id=" + auto_id + ", mem_name=" + mem_name + ", mem_pw=" + mem_pw + ", mem_phone=" + mem_phone
				+ ", mem_email=" + mem_email + ", mem_zipcode=" + mem_zipcode + ", mem_address1=" + mem_address1
				+ ", mem_address2=" + mem_address2 + ", mem_regdate=" + mem_regdate + ", mem_mdate=" + mem_mdate
				+ ", now_passwd=" + now_passwd + "]";
	}
	
}