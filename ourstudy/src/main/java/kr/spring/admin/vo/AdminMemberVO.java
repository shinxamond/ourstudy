package kr.spring.admin.vo;

import java.io.IOException;
import java.sql.Date;

import javax.validation.constraints.Email;
import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.Pattern;
import javax.validation.constraints.Size;

import org.springframework.web.multipart.MultipartFile;

public class AdminMemberVO {
	private int mem_num;
	private String mem_name;
	private String mem_id;
	private Date mem_regdate;
	private String mem_phone;
	private String mem_email;
	public int getMem_num() {
		return mem_num;
	}
	public void setMem_num(int mem_num) {
		this.mem_num = mem_num;
	}
	public String getMem_name() {
		return mem_name;
	}
	public void setMem_name(String mem_name) {
		this.mem_name = mem_name;
	}
	public String getMem_id() {
		return mem_id;
	}
	public void setMem_id(String mem_id) {
		this.mem_id = mem_id;
	}
	public Date getMem_reg_date() {
		return mem_regdate;
	}
	public void setMem_reg_date(Date mem_reg_date) {
		this.mem_regdate = mem_reg_date;
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
	
	@Override
	public String toString() {
		return "AdminMemberVO [mem_num=" + mem_num + ", mem_name=" + mem_name + ", mem_id=" + mem_id + ", mem_reg_date="
				+ mem_regdate + ", mem_phone=" + mem_phone + ", mem_email=" + mem_email + "]";
	}
}
