package kr.spring.admin.vo;

import java.io.IOException;
import java.sql.Date;

import javax.validation.constraints.Email;
import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.Pattern;
import javax.validation.constraints.Size;

import org.springframework.web.multipart.MultipartFile;

public class AdminItemHistoryVO {
	private int item_rnum;
	private String item_title;
	private int item_index;
	private int mem_num;
	private String mem_name;
	private String mem_phone;
	private String item_start;
	private String item_end;
	
	public int getItem_rnum() {
		return item_rnum;
	}
	public void setItem_rnum(int item_rnum) {
		this.item_rnum = item_rnum;
	}
	public String getItem_title() {
		return item_title;
	}
	public void setItem_title(String item_title) {
		this.item_title = item_title;
	}
	public int getItem_index() {
		return item_index;
	}
	public void setItem_index(int item_index) {
		this.item_index = item_index;
	}
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
	public String getMem_phone() {
		return mem_phone;
	}
	public void setMem_phone(String mem_phone) {
		this.mem_phone = mem_phone;
	}
	public String getItem_start() {
		return item_start;
	}
	public void setItem_start(String item_start) {
		this.item_start = item_start;
	}
	public String getItem_end() {
		return item_end;
	}
	public void setItem_end(String item_end) {
		this.item_end = item_end;
	}
	
	@Override
	public String toString() {
		return "AdminItemHistoryVO [item_rnum=" + item_rnum + ", item_title=" + item_title + ", item_index="
				+ item_index + ", mem_num=" + mem_num + ", mem_name=" + mem_name + ", mem_phone=" + mem_phone
				+ ", item_start=" + item_start + ", item_end=" + item_end + "]";
	}	
}
