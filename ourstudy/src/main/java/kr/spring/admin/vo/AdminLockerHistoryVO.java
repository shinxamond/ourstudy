package kr.spring.admin.vo;

import java.io.IOException;
import java.sql.Date;

import javax.validation.constraints.Email;
import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.Pattern;
import javax.validation.constraints.Size;

import org.springframework.web.multipart.MultipartFile;

public class AdminLockerHistoryVO {
	private int locker_detail_num;
	private int locker_num;
	private int mem_num;
	private String mem_name;
	private String locker_start;
	private String locker_end;
	private int locker_status;
	
	public int getLocker_detail_num() {
		return locker_detail_num;
	}
	public void setLocker_detail_num(int locker_detail_num) {
		this.locker_detail_num = locker_detail_num;
	}
	public int getLocker_num() {
		return locker_num;
	}
	public void setLocker_num(int locker_num) {
		this.locker_num = locker_num;
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
	public String getLocker_start() {
		return locker_start;
	}
	public void setLocker_start(String locker_start) {
		this.locker_start = locker_start;
	}
	public String getLocker_end() {
		return locker_end;
	}
	public void setLocker_end(String locker_end) {
		this.locker_end = locker_end;
	}
	public int getLocker_status() {
		return locker_status;
	}
	public void setLocker_status(int locker_status) {
		this.locker_status = locker_status;
	}
	
	@Override
	public String toString() {
		return "AdminLockerHistoryVO [locker_detail_num=" + locker_detail_num + ", locker_num=" + locker_num
				+ ", mem_num=" + mem_num + ", mem_name=" + mem_name + ", locker_start=" + locker_start + ", locker_end="
				+ locker_end + ", locker_status=" + locker_status + "]";
	}
}
