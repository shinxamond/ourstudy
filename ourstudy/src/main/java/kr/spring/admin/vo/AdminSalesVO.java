package kr.spring.admin.vo;

import java.io.IOException;
import java.sql.Date;

import javax.validation.constraints.Email;
import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.Pattern;
import javax.validation.constraints.Size;

import org.springframework.web.multipart.MultipartFile;

public class AdminSalesVO {
	private int mem_num;
	private String mem_name;
	private String ticket_name; 
	private int ticket_kind;
	private int pay_plan;
	private String pay_price;
	private String pay_date;
	
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
	public String getTicket_name() {
		return ticket_name;
	}
	public void setTicket_name(String ticket_name) {
		this.ticket_name = ticket_name;
	}
	public int getTicket_kind() {
		return ticket_kind;
	}
	public void setTicket_kind(int ticket_kind) {
		this.ticket_kind = ticket_kind;
	}
	public int getPay_plan() {
		return pay_plan;
	}
	public void setPay_plan(int pay_plan) {
		this.pay_plan = pay_plan;
	}	
	public String getPay_price() {
		return pay_price;
	}
	public void setPay_price(String pay_price) {
		this.pay_price = pay_price;
	}
	public String getPay_date() {
		return pay_date;
	}
	public void setPay_date(String pay_date) {
		this.pay_date = pay_date;
	}
	
	@Override
	public String toString() {
		return "AdminSalesVO [mem_num=" + mem_num + ", mem_name=" + mem_name + ", ticket_name=" + ticket_name
				+ ", ticket_kind=" + ticket_kind + ", pay_plan=" + pay_plan + ", pay_price=" + pay_price + ", pay_date="
				+ pay_date + "]";
	}
}
