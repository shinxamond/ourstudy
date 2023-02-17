package kr.spring.pay.vo;

import java.sql.Date;

public class PayVO {
	private int pay_num;
	private int pay_price;
	private int pay_plan;
	private String pay_content;
	private Date pay_date;
	
	private int mem_num;
	private int ticket_num;
	private int point_num;
	
	public int getPay_num() {
		return pay_num;
	}
	public void setPay_num(int pay_num) {
		this.pay_num = pay_num;
	}
	public int getPay_price() {
		return pay_price;
	}
	public void setPay_price(int pay_price) {
		this.pay_price = pay_price;
	}
	public int getPay_plan() {
		return pay_plan;
	}
	public void setPay_plan(int pay_plan) {
		this.pay_plan = pay_plan;
	}
	public String getPay_content() {
		return pay_content;
	}
	public void setPay_content(String pay_content) {
		this.pay_content = pay_content;
	}
	public Date getPay_date() {
		return pay_date;
	}
	public void setPay_date(Date pay_date) {
		this.pay_date = pay_date;
	}
	public int getMem_num() {
		return mem_num;
	}
	public void setMem_num(int mem_num) {
		this.mem_num = mem_num;
	}
	public int getTicket_num() {
		return ticket_num;
	}
	public void setTicket_num(int ticket_num) {
		this.ticket_num = ticket_num;
	}
	public int getPoint_num() {
		return point_num;
	}
	public void setPoint_num(int point_num) {
		this.point_num = point_num;
	}
	
	@Override
	public String toString() {
		return "PayVO [pay_num=" + pay_num + ", pay_price=" + pay_price + ", pay_plan=" + pay_plan + ", pay_content="
				+ pay_content + ", pay_date=" + pay_date + ", mem_num=" + mem_num + ", ticket_num=" + ticket_num
				+ ", point_num=" + point_num + "]";
	}
}
