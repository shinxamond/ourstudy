package kr.spring.admin.vo;

import java.io.IOException;
import java.sql.Date;

import javax.validation.constraints.Email;
import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.Pattern;
import javax.validation.constraints.Size;

import org.springframework.web.multipart.MultipartFile;

public class AdminSeatHistoryVO {
	private int seat_detail_num;
	private int seat_num;
	private int mem_num;
	private String mem_name;
	private Date in_time;
	private Date out_time;
	private int total_time;
	
	public int getSeat_detail_num() {
		return seat_detail_num;
	}

	public void setSeat_detail_num(int seat_detail_num) {
		this.seat_detail_num = seat_detail_num;
	}

	public int getSeat_num() {
		return seat_num;
	}

	public void setSeat_num(int seat_num) {
		this.seat_num = seat_num;
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

	public Date getIn_time() {
		return in_time;
	}

	public void setIn_time(Date in_time) {
		this.in_time = in_time;
	}

	public Date getOut_time() {
		return out_time;
	}

	public void setOut_time(Date out_time) {
		this.out_time = out_time;
	}

	public int getTotal_time() {
		return total_time;
	}

	public void setTotal_time(int total_time) {
		this.total_time = total_time;
	}

	@Override
	public String toString() {
		return "AdminSeatHistoryVO [seat_detail_num=" + seat_detail_num + ", seat_num=" + seat_num + ", mem_num="
				+ mem_num + ", mem_name=" + mem_name + ", in_time=" + in_time + ", out_time=" + out_time
				+ ", total_time=" + total_time + "]";
	}	
}
